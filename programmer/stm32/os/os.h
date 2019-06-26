/**
 * @file
 */

/**
 * @defgroup os Operating System
 * @brief The simple cooperative multitasking system.
 */

#pragma once

#include "common.h"
#include "list_node.h"
#include "task.h"
#include "lltimer.h"
#include "timer.h"

/**
 * @brief      Get current OS time. This is the number of system ticks since
 *             start of the software.
 * @ingroup    os
 *
 * @return     Current OS time.
 */
static inline os_time_t os_get_time(void) {
    return lltimer_get_counter_value();
}
