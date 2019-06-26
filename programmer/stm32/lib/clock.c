#include "clock.h"
#include "io.h"

void clock_init(void) {
    clock_enable(CLK_PWR);
    clock_enable(CLK_SYSCFG);

    // Configure flash (1 waitstate)
    FLASH->ACR = FLASH_ACR_PRFTBE | FLASH_ACR_LATENCY;

    // Enable HSE (24MHz external clock) and wait for it to be ready
    RCC->CR |= RCC_CR_HSEBYP | RCC_CR_HSEON;
    while ((RCC->CR & RCC_CR_HSERDY) == 0) {
    }

    // HCLK = SYSCLK/1, PCLK2 = HCLK/1, PCLK1 = HCLK/1
    RCC->CFGR = RCC_CFGR_HPRE_DIV1 | RCC_CFGR_PPRE_DIV1;

    // Configure PLL
    RCC->CFGR |= RCC_CFGR_PLLMUL6 | RCC_CFGR_PLLSRC_HSE_PREDIV;
    RCC->CFGR2 = RCC_CFGR2_PREDIV_DIV3;
    RCC->CR |= RCC_CR_PLLON;
    while ((RCC->CR & RCC_CR_PLLRDY) == 0) {
    }

    // Select PLL as system clock source
    RCC->CFGR = (RCC->CFGR & ~RCC_CFGR_SW) | RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_PLL) {
    }
}

void clock_enable(enum clock clk) {
    uint32_t bus = clk & 0xF00;
    uint32_t bit = 1 << (clk & 0xFF);
    switch (bus) {
        case CLKBUS_AHB: RCC->AHBENR |= bit; break;
        case CLKBUS_APB1: RCC->APB1ENR |= bit; break;
        case CLKBUS_APB2: RCC->APB2ENR |= bit; break;
    }
}

void clock_disable(enum clock clk) {
    uint32_t bus = clk & 0xF00;
    uint32_t bit = 1 << (clk & 0xFF);
    switch (bus) {
        case CLKBUS_AHB: RCC->AHBENR &= ~bit; break;
        case CLKBUS_APB1: RCC->APB1ENR &= ~bit; break;
        case CLKBUS_APB2: RCC->APB2ENR &= ~bit; break;
    }
}

uint32_t clock_get_frequency(enum clock clk) {
    uint32_t frequency = 0;

    uint32_t cfgr = RCC->CFGR;

    int      hpre          = (cfgr >> 4) & 0xF;
    uint32_t ahb_prescaler = (hpre & 8) ? (2 << (hpre & 7)) : 1;

    uint32_t bus      = clk & 0xF00;
    bool     is_timer = (clk & CLK_IS_TIMER) != 0;

    switch (bus) {
        case CLKBUS_AHB: {
            frequency = SYSCLK_FREQ / ahb_prescaler;
            break;
        }

        case CLKBUS_APB1: {
            int      ppre1          = (cfgr >> 8) & 0x7;
            uint32_t apb1_prescaler = (ppre1 & 4) ? (2 << (ppre1 & 3)) : 1;

            frequency = SYSCLK_FREQ / (ahb_prescaler * apb1_prescaler);

            if ((ppre1 & 4) != 0 && is_timer) {
                // When APB prescaler == 1, timer clocks are multiplied by 2
                frequency *= 2;
            }
            break;
        }

        case CLKBUS_APB2: {
            int      ppre2          = (cfgr >> 11) & 0x7;
            uint32_t apb2_prescaler = (ppre2 & 4) ? (2 << (ppre2 & 3)) : 1;

            frequency = SYSCLK_FREQ / (ahb_prescaler * apb2_prescaler);

            if ((ppre2 & 4) != 0 && is_timer) {
                // When APB prescaler == 1, timer clocks are multiplied by 2
                frequency *= 2;
            }
            break;
        }
    }
    return frequency;
}
