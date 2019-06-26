#include "lltimer.h"
#include "lib.h"

static uint32_t      upper_bits     = 0;
static uint64_t      callback_value = -1ULL;
static volatile bool initialized    = false;

#define CALLBACK_MINIMUM_OFFSET (10)

void lltimer_init(void) {
    clock_enable(CLK_TIM14);
    uint32_t clkfreq = clock_get_frequency(CLK_TIM14);

    uint32_t prescaler = (clkfreq / TICKS_PER_SECOND);
    assert(prescaler < 65536);

    TIM14->CR1   = 0;
    TIM14->PSC   = prescaler - 1;
    TIM14->CNT   = 0;
    TIM14->ARR   = 65535;
    TIM14->DIER  = TIM_DIER_UIE;
    TIM14->CCMR1 = (1 << 4);
    TIM14->CCER  = 0;
    TIM14->EGR   = TIM_EGR_UG; // Force update event to ensure prescaler is used
    TIM14->CR1 |= TIM_CR1_CEN;
    TIM14->SR = 0;

    NVIC_SetPriority(TIM14_IRQn, 3);
    NVIC_EnableIRQ(TIM14_IRQn);

    initialized = true;
}

uint64_t lltimer_get_counter_value(void) {
    if (!initialized) {
        return 0;
    }

    uint64_t total_cnt;

    ATOMIC_SECTION_ENTER {
        uint16_t cnt2, sr2;
        uint16_t cnt = TIM14->CNT;
        uint16_t sr  = TIM14->SR;
        do {
            cnt2 = cnt;
            sr2  = sr;
            cnt  = TIM14->CNT;
            sr   = TIM14->SR;
        } while (cnt != cnt2 || sr != sr2);

        if (sr & TIM_SR_UIF) {
            upper_bits++;
            TIM14->SR = ~TIM_SR_UIF;
        }

        total_cnt = ((uint64_t)upper_bits << 16) | cnt;
    }
    ATOMIC_SECTION_LEAVE

    return total_cnt;
}

void lltimer_cancel_counter_callback(void) {
    ATOMIC_SECTION_ENTER {
        TIM14->DIER &= ~TIM_DIER_CC1IE;
    }
    ATOMIC_SECTION_LEAVE
}

static inline void set_compare_value(void) {
    TIM14->DIER &= ~TIM_DIER_CC1IE;

    uint64_t current_value   = lltimer_get_counter_value();
    uint64_t callback_value2 = callback_value;

    if (callback_value2 < current_value + CALLBACK_MINIMUM_OFFSET) {
        // Callback value too soon, push it a bit into the future.
        callback_value2 = current_value + CALLBACK_MINIMUM_OFFSET;
    }

    uint64_t diff = callback_value2 - current_value;
    if (diff < 65536) {
        TIM14->CCR1 = callback_value2 & 0xFFFF;
        TIM14->SR   = ~TIM_SR_CC1IF;
        TIM14->DIER |= TIM_DIER_CC1IE;
    }
}

void lltimer_callback_on_counter_value(uint64_t value) {
    ATOMIC_SECTION_ENTER {
        callback_value = value;
        set_compare_value();
    }
    ATOMIC_SECTION_LEAVE
}

void tim14_irq_handler(void) {
    bool do_callback = false;

    ATOMIC_SECTION_ENTER {
        uint16_t sr = TIM14->SR;
        TIM14->SR   = 0;

        bool cc_enabled = (TIM14->DIER & TIM_DIER_CC1IE) != 0;

        if (sr & TIM_SR_UIF) {
            upper_bits++;

            // Check if it is time to set the compare register to trigger a callback
            if (!cc_enabled) {
                set_compare_value();
            }
        }
        if (cc_enabled && (sr & TIM_SR_CC1IF) != 0) {
            TIM14->DIER &= ~TIM_DIER_CC1IE;
            do_callback = true;
        }
    }
    ATOMIC_SECTION_LEAVE

    if (do_callback) {
        lltimer_callback();
    }
}
