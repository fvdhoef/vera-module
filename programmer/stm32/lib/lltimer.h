#pragma once

#include "common.h"

#define TICKS_PER_SECOND (10000)
#define MS_TO_TICKS(x) ((x)*10)

void     lltimer_init(void);
uint64_t lltimer_get_counter_value(void);
void     lltimer_cancel_counter_callback(void);
void     lltimer_callback_on_counter_value(uint64_t value);

// Implemented by OS
extern void lltimer_callback(void);
