/**
 * @file
 */

/**
 * @defgroup ostimer OS Timer
 * @ingroup os
 * @brief Allows scheduling callbacks in the future.
 * @{
 */

#pragma once

#include "common.h"
#include "list_node.h"

/**
 * @brief      OS Timer control structure
 */
struct timer {
    void (*handler)(void);            ///< Callback function called at timer expiry
    void *           arg;             ///< User defined argument that can be retrieved by handler function
    struct list_node list_node;       ///< List node to keep track of timers
    uint32_t         interval;        ///< Timer interval in system ticks
    os_time_t        expiration_time; ///< Absolute expiration time in system ticks
};

/**
 * @brief      Initialize OS Timer object
 *
 * @param      timer     Pointer to timer object
 * @param      handler   Callback to be called at timer expiry
 * @param      arg       Argument that can be retrieved by handler
 * @param      interval  Timer interval in system ticks (use 0 to for
 *                       non-recurring timer mode)
 */
void timer_init(struct timer *timer, void (*handler)(void), void *arg, uint32_t interval);

/**
 * @brief      Start timer with relative first expiry time
 *
 * @param      timer  Pointer to timer object
 * @param      delay  Time in system tick until first callback, after this the
 *                    interval set by timer_init() will be used.
 */
void timer_start(struct timer *timer, uint32_t delay);

/**
 * @brief      Start timer with absolute first expiry time
 *
 * @param      timer            Pointer to timer object
 * @param      expiration_time  Absolute time of first callback, after this the
 *                              interval set by timer_init() will be used.
 */
void timer_start_with_expiration_time(struct timer *timer, os_time_t expiration_time);

/**
 * @brief      Restart timer with relative first expiry time and new interval
 *
 * @param      timer     Pointer to timer object
 * @param      delay     Time in system tick until first callback, after this
 *                       the interval set by interval will be used.
 * @param      interval  Timer interval in system ticks (use 0 to for
 *                       non-recurring timer mode)
 */
void timer_restart(struct timer *timer, uint32_t delay, uint32_t interval);

/**
 * @brief      Stop timer
 *
 * @param      timer  Pointer to timer object
 */
void timer_stop(struct timer *timer);

/**
 * @brief      Get argument for timer
 *
 * @param      timer  Pointer to timer object
 *
 * @return     Argument specified at timer initialization (timer_init()).
 */
void *timer_argument(struct timer *timer);

/**
 * @brief      Check if timer is running
 *
 * @param      timer  Pointer to timer object
 *
 * @return     true if timer is running, false if timer is stopped
 */
bool timer_is_running(struct timer *timer);

/**
 * @brief      Get current timer.
 * @details    This will only produce a non-NULL result if called from within the context of a timer handler.
 *
 * @return     Current timer or NULL if called from outside timer handler context.
 */
struct timer *timer_get_current(void);

/**
 * @brief      Get argument for current timer.
 *
 * @return     Argument for current timer.
 */
void *timer_get_current_argument(void);

/**
 * @brief      Forward declare static ostimer
 *
 * @param      name  Name of timer
 */
#define TIMER_DECL(name) \
    static struct timer name

/**
 * @brief      Forward declare non-static ostimer
 *
 * @param      name  Name of timer
 */
#define TIMER_NONSTATIC_DECL(name) \
    extern struct timer name

/**
 * @brief      Define ostimer handler. This macro will implicitly also define a static struct timer object.
 *
 * @param      name  Name of timer
 */
#define TIMER(name)                                                                                                                                                                  \
    static void         timer_handler_##name(void);                                                                                                                                  \
    static struct timer name = {.handler = timer_handler_##name, .arg = NULL, .list_node = {.prev = &name.list_node, .next = &name.list_node}, .interval = 0, .expiration_time = 0}; \
    static void         timer_handler_##name(void)

/**
 * @brief      Define ostimer handler. This macro will implicitly also define a non-static struct timer object.
 *
 * @param      name  Name of timer
 */
#define TIMER_NONSTATIC(name)                                                                                                                                                 \
    static void  timer_handler_##name(void);                                                                                                                                  \
    struct timer name = {.handler = timer_handler_##name, .arg = NULL, .list_node = {.prev = &name.list_node, .next = &name.list_node}, .interval = 0, .expiration_time = 0}; \
    static void  timer_handler_##name(void)

/**
 * @brief      Initialize specified timer
 *
 * @param      name      Name of timer
 * @param      arg       The argument, see timer_init().
 * @param      interval  The interval, see timer_init().
 */
#define TIMER_INIT(name, arg, interval) \
    timer_init(&name, timer_handler_##name, arg, interval)

/** @} */
