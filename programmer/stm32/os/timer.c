#include "timer.h"
#include "lib.h"

LIST_NODE(timer_list);
static struct timer *current_timer;

TASK_DECL(ostimer);

// Assumed to be called in critical section
static void ostimer_insert(struct timer *timer) {
    assert(timer != NULL);
    assert(list_node_is_empty(&timer->list_node));

    // Add timer to list of active time events (sorted by expiration time)
    struct list_node *node = &timer_list;
    while (node->next != &timer_list) {
        struct list_node *next_node = node->next;

        struct timer *node_timer = GET_CONTAINER_OF(node->next, struct timer, list_node);
        if (node_timer->expiration_time > timer->expiration_time) {
            break;
        }
        node = next_node;
    }
    list_node_insert(&timer->list_node, node);

    task_post(&ostimer);
}

// Assumed to be called in critical section
static void ostimer_remove(struct timer *timer) {
    // Remove timer from list of active time events
    list_node_remove(&timer->list_node);

    task_post(&ostimer);
}

void timer_init(struct timer *timer, void (*handler)(void), void *arg, uint32_t interval) {
    timer->handler         = handler;
    timer->arg             = arg;
    timer->interval        = interval;
    timer->expiration_time = 0;
    list_node_init(&timer->list_node);
}

void timer_start(struct timer *timer, uint32_t delay) {
    timer_start_with_expiration_time(timer, os_get_time() + delay);
}

void timer_start_with_expiration_time(struct timer *timer, os_time_t expiration_time) {
    ATOMIC_SECTION_ENTER {
        ostimer_remove(timer);
        timer->expiration_time = expiration_time;
        ostimer_insert(timer);
    }
    ATOMIC_SECTION_LEAVE
}

void timer_restart(struct timer *timer, uint32_t delay, uint32_t interval) {
    ATOMIC_SECTION_ENTER {
        timer_stop(timer);
        timer->interval = interval;
        timer_start(timer, delay);
    }
    ATOMIC_SECTION_LEAVE
}

void timer_stop(struct timer *timer) {
    ATOMIC_SECTION_ENTER {
        ostimer_remove(timer);
    }
    ATOMIC_SECTION_LEAVE
}

void *timer_argument(struct timer *timer) {
    return timer->arg;
}

bool timer_is_running(struct timer *timer) {
    bool result;
    ATOMIC_SECTION_ENTER {
        result = !list_node_is_empty(&timer->list_node);
    }
    ATOMIC_SECTION_LEAVE
    return result;
}

TASK(ostimer) {
    struct timer *timer;

    do {
        timer = NULL;

        ATOMIC_SECTION_ENTER {
            if (!list_node_is_empty(&timer_list)) {
                timer = GET_CONTAINER_OF(timer_list.next, struct timer, list_node);
                if (os_get_time() >= timer->expiration_time) {
                    ostimer_remove(timer);
                } else {
                    // Too early for this timer, set lltimer to give callback when it's time for this one.
                    lltimer_callback_on_counter_value(timer->expiration_time);
                    timer = NULL;
                }
            } else {
                // No timers left, cancel lltimer callback.
                lltimer_cancel_counter_callback();
            }
        }
        ATOMIC_SECTION_LEAVE

        if (timer != NULL) {
            current_timer = timer;
            timer->handler();
            current_timer = NULL;

            ATOMIC_SECTION_ENTER {
                if (!timer_is_running(timer)) {
                    if (timer->interval > 0) {
                        // Interval timer, restart timer
                        timer->expiration_time = timer->expiration_time + timer->interval;

                        ostimer_insert(timer);
                    }
                }
            }
            ATOMIC_SECTION_LEAVE
        }
    } while (timer != NULL);
}

void lltimer_callback(void) {
    task_post(&ostimer);
}

struct timer *timer_get_current(void) {
    return current_timer;
}

void *timer_get_current_argument(void) {
    assert(current_timer != NULL);
    return current_timer->arg;
}
