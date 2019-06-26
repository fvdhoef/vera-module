#pragma once

#include "common.h"

enum clock_bus {
    CLKBUS_AHB  = 0x100,
    CLKBUS_APB1 = 0x200,
    CLKBUS_APB2 = 0x300,
};

#define CLK_IS_TIMER 0x1000

enum clock {
    CLK_DMA   = CLKBUS_AHB | 0,
    CLK_SRAM  = CLKBUS_AHB | 2,
    CLK_FLITF = CLKBUS_AHB | 4,
    CLK_CRC   = CLKBUS_AHB | 6,
    CLK_GPIOA = CLKBUS_AHB | 17,
    CLK_GPIOB = CLKBUS_AHB | 18,
    CLK_GPIOC = CLKBUS_AHB | 19,
    CLK_GPIOD = CLKBUS_AHB | 20,
    CLK_GPIOF = CLKBUS_AHB | 22,

    CLK_TIM3   = CLKBUS_APB1 | 1 | CLK_IS_TIMER,
    CLK_TIM6   = CLKBUS_APB1 | 4 | CLK_IS_TIMER,
    CLK_TIM7   = CLKBUS_APB1 | 5 | CLK_IS_TIMER,
    CLK_TIM14  = CLKBUS_APB1 | 8 | CLK_IS_TIMER,
    CLK_WWDG   = CLKBUS_APB1 | 11,
    CLK_SPI2   = CLKBUS_APB1 | 14,
    CLK_USART2 = CLKBUS_APB1 | 17,
    CLK_USART3 = CLKBUS_APB1 | 18,
    CLK_USART4 = CLKBUS_APB1 | 19,
    CLK_USART5 = CLKBUS_APB1 | 20,
    CLK_I2C1   = CLKBUS_APB1 | 21,
    CLK_I2C2   = CLKBUS_APB1 | 22,
    CLK_USB    = CLKBUS_APB1 | 23,
    CLK_PWR    = CLKBUS_APB1 | 28,

    CLK_SYSCFG = CLKBUS_APB2 | 0,
    CLK_USART6 = CLKBUS_APB2 | 5,
    CLK_ADC    = CLKBUS_APB2 | 9,
    CLK_TIM1   = CLKBUS_APB2 | 11 | CLK_IS_TIMER,
    CLK_SPI1   = CLKBUS_APB2 | 12,
    CLK_USART1 = CLKBUS_APB2 | 14,
    CLK_TIM15  = CLKBUS_APB2 | 16 | CLK_IS_TIMER,
    CLK_TIM16  = CLKBUS_APB2 | 17 | CLK_IS_TIMER,
    CLK_TIM17  = CLKBUS_APB2 | 18 | CLK_IS_TIMER,
    CLK_DBGMCU = CLKBUS_APB2 | 22,
};

void     clock_init(void);
void     clock_enable(enum clock clk);
void     clock_disable(enum clock clk);
uint32_t clock_get_frequency(enum clock clk);
