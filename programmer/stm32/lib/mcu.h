#pragma once

#include "stm32f070x6.h"

#define SYSCLK_FREQ (48000000)
#define NUM_MCU_INTERRUPTS (32)

static inline void udelay(uint32_t dt) {
    uint32_t count = (dt * (SYSCLK_FREQ / 1000000)) / 4;
    if (count) {
        __asm__ __volatile__("1: sub %0, %0, #1; beq 2f; b 1b; 2:"
                             : "+r"(count));
    }
}
