/**
 * @file
 */
#pragma once

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdalign.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#include "config.h"
#include "mcu.h"

/**
 * @brief      OS time type. The time is expressed in system ticks.
 * @ingroup    os
 */
typedef uint64_t os_time_t;

/**
 * @brief      Memory barrier. The compiler will refetch any register-cached
 *             variables after this.
 * @ingroup    lib
 */
static inline void __membar(void) {
    __asm__ __volatile__("" ::
                             : "memory");
}

/**
 * @brief      Enter atomic section. Should be closed with ATOMIC_SECTION_LEAVE.
 *             Interrupts are disabled during the atomic section. Interrupt
 *             state is restored after closing the atomic section with
 *             ATOMIC_SECTION_LEAVE.
 * @ingroup    lib
 */
#define ATOMIC_SECTION_ENTER              \
    {                                     \
        __DSB();                          \
        uint32_t __atomic;                \
        __asm volatile("mrs %0, primask"  \
                       : "=r"(__atomic)); \
        __asm volatile("cpsid i");

/**
 * @brief      Leave atomic section. Should be preceeded by accompanying with
 *             ATOMIC_SECTION_ENTER. Interrupt state is restored after closing
 *             the atomic section to the same state it was before entering the
 *             atomic section.
 * @ingroup    lib
 */
#define ATOMIC_SECTION_LEAVE                           \
    __asm volatile("msr primask, %0" ::"r"(__atomic)); \
    __DSB();                                           \
    }

/**
 * @brief      Get number of elements in array
 * @ingroup    lib
 *
 * @param      x     Array
 *
 * @return     Number of elements in array
 */
#define NUM_ARRAY_ELEMENTS(x) (sizeof((x)) / sizeof((x)[0]))
