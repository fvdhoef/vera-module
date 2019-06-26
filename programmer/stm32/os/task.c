#include "task.h"
#include "lib.h"

LIST_NODE(posted_tasks);
static struct task *current_task;

void task_init(struct task *task, void (*handler)(void), void *arg) {
    task->handler = handler;
    task->arg     = arg;
    task->posted  = false;
    list_node_init(&task->list_node);
}

void task_post(struct task *task) {
    ATOMIC_SECTION_ENTER {
        if (!task->posted) {
            task->posted = true;
            list_node_remove(&task->list_node);
            list_node_insert(&task->list_node, posted_tasks.prev);
        }
    }
    ATOMIC_SECTION_LEAVE
}

static void suspend_cpu(void) {
    // Suspend and wait for interrupt
    __WFI();
}

void task_run(void) {
    while (1) {
        // Get next task from posted task list
        struct task *task = NULL;
        ATOMIC_SECTION_ENTER {
            if (!list_node_is_empty(&posted_tasks)) {
                task = GET_CONTAINER_OF(posted_tasks.next, struct task, list_node);
                list_node_remove(&task->list_node);
                task->posted = false;
            }

            if (task == NULL) {
                // No active task, suspend
                suspend_cpu();
            }
        }
        ATOMIC_SECTION_LEAVE

        // Run task
        if (task != NULL) {
            current_task = task;
            task->handler();
            current_task = NULL;
        }
    }
}

struct task *task_get_current(void) {
    return current_task;
}

void *task_get_current_argument(void) {
    assert(current_task != NULL);
    return current_task->arg;
}
