/**
 * @file
 */

/**
 * @defgroup task OS Task
 * @ingroup os
 * @brief Allows running multiple tasks on the system
 * @{
 */
#pragma once

#include "common.h"
#include "list_node.h"

/**
 * @brief      Task control structure (don't manipulate directly)
 */
struct task {
    void (*handler)(void);      ///< Task handler callback
    void *           arg;       ///< User defined argument that can be retrieved by handler function
    struct list_node list_node; ///< List node to keep track of tasks
    volatile bool    posted;    ///< True when task is posted
};

/**
 * @brief      Initialize task object
 *
 * @param      task      Task object
 * @param      handler   Task handler
 * @param      arg       Argument that can be retrieved by handler
 */
void task_init(struct task *task, void (*handler)(void), void *arg);

/**
 * @brief      Post task for execution
 *
 * @param      task          Task to be posted
 */
void task_post(struct task *task);

/**
 * @brief      Get current task.
 *
 * @return     Current task
 */
struct task *task_get_current(void);

/**
 * @brief      Get argument for current task.
 *
 * @return     Argument for current task
 */
void *task_get_current_argument(void);

/**
 * @brief      Task loop. Not to be called from user code.
 * @details    This function never returns. It will loop over the list of posted
 *             tasks. For each task in the list it will remove the task from the
 *             list and execute it. When no more tasks are available to run, the
 *             system will go into low power mode.
 */
void task_run(void);

/**
 * @brief      Forward declare static task.
 *
 * @param      name  Name of task
 */
#define TASK_DECL(name) \
    static struct task name

/**
 * @brief      Forward declare non-static task.
 *
 * @param      name  Name of task.
 */
#define TASK_NONSTATIC_DECL(name) \
    extern struct task name

/**
 * @brief      Define task handler. This macro will implicitly also define and initialize a static struct task object.
 *
 * @param      name  Name of task.
 */
#define TASK(name)                                                                                                                                             \
    static void        task_handler_##name(void);                                                                                                              \
    static struct task name = {.handler = task_handler_##name, .arg = NULL, .list_node = {.prev = &name.list_node, .next = &name.list_node}, .posted = false}; \
    static void        task_handler_##name(void)

/**
 * @brief      Define task handler. This macro will implicitly also define and initialize a non-static struct task object.
 *
 * @param      name  Name of task.
 */
#define TASK_NONSTATIC(name)                                                                                                                            \
    static void task_handler_##name(void);                                                                                                              \
    struct task name = {.handler = task_handler_##name, .arg = NULL, .list_node = {.prev = &name.list_node, .next = &name.list_node}, .posted = false}; \
    static void task_handler_##name(void)

/** @} */
