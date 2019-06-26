#include "common.h"
#include "mcu.h"

void reset_handler(void);
void main(void);

extern uint32_t _estack;

#ifndef STACK_SIZE
#    define STACK_SIZE 4096
#    warning STACK_SIZE not defined, defaulting to 4096 bytes
#endif

// stack
__attribute__((section(".stack_area"))) uint8_t stack_area[STACK_SIZE];

void __not_implemented(void) {
    while (1) {
    }
}

void nmi_handler(void) __attribute__((weak, alias("__not_implemented")));
void hardfault_handler(void) __attribute__((weak, alias("__not_implemented")));
void svc_handler(void) __attribute__((weak, alias("__not_implemented")));
void pendsv_handler(void) __attribute__((weak, alias("__not_implemented")));
void systick_handler(void) __attribute__((weak, alias("__not_implemented")));
void wwdg_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void rtc_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void flash_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void rcc_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void exti0_1_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void exti2_3_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void exti4_15_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void dma1_channel1_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void dma1_channel2_3_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void dma1_channel4_5_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void adc1_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void tim1_brk_up_trg_com_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void tim1_cc_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void tim3_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void tim14_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void tim16_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void tim17_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void i2c1_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void spi1_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void usart1_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void usart2_irq_handler(void) __attribute__((weak, alias("__not_implemented")));
void usb_irq_handler(void) __attribute__((weak, alias("__not_implemented")));

// vector table
__attribute__((section(".vectors"))) const void *vector_table[] = {
    // Configure Initial Stack Pointer, using linker-generated symbols
    (void *)(&_estack),
    (void *)(uintptr_t)reset_handler,
    (void *)(uintptr_t)nmi_handler,       // -14: Non Maskable Interrupt
    (void *)(uintptr_t)hardfault_handler, // -13: Cortex-M0 Hard Fault Interrupt
    (void *)(uintptr_t)__not_implemented, // -12
    (void *)(uintptr_t)__not_implemented, // -11
    (void *)(uintptr_t)__not_implemented, // -10
    (void *)(uintptr_t)__not_implemented, // -9
    (void *)(uintptr_t)__not_implemented, // -8
    (void *)(uintptr_t)__not_implemented, // -7
    (void *)(uintptr_t)__not_implemented, // -6
    (void *)(uintptr_t)svc_handler,       // -5: Cortex-M0 SV Call Interrupt
    (void *)(uintptr_t)__not_implemented, // -4
    (void *)(uintptr_t)__not_implemented, // -3
    (void *)(uintptr_t)pendsv_handler,    // -2: Cortex-M0 Pend SV Interrupt
    (void *)(uintptr_t)systick_handler,   // -1: Cortex-M0 System Tick Interrupt

    // STM32F0 specific interrupt numbers
    (void *)(uintptr_t)wwdg_irq_handler,                // 0: Window WatchDog Interrupt
    (void *)(uintptr_t)__not_implemented,               // 1
    (void *)(uintptr_t)rtc_irq_handler,                 // 2: RTC Interrupt through EXTI Lines 17, 19 and 20
    (void *)(uintptr_t)flash_irq_handler,               // 3: FLASH global Interrupt
    (void *)(uintptr_t)rcc_irq_handler,                 // 4: RCC global Interrupt
    (void *)(uintptr_t)exti0_1_irq_handler,             // 5: EXTI Line 0 and 1 Interrupt
    (void *)(uintptr_t)exti2_3_irq_handler,             // 6: EXTI Line 2 and 3 Interrupt
    (void *)(uintptr_t)exti4_15_irq_handler,            // 7: EXTI Line 4 to 15 Interrupt
    (void *)(uintptr_t)__not_implemented,               // 8
    (void *)(uintptr_t)dma1_channel1_irq_handler,       // 9: DMA1 Channel 1 Interrupt
    (void *)(uintptr_t)dma1_channel2_3_irq_handler,     // 10: DMA1 Channel 2 and Channel 3 Interrupt
    (void *)(uintptr_t)dma1_channel4_5_irq_handler,     // 11: DMA1 Channel 4 and Channel 5 Interrupt
    (void *)(uintptr_t)adc1_irq_handler,                // 12: ADC1 Interrupt
    (void *)(uintptr_t)tim1_brk_up_trg_com_irq_handler, // 13: TIM1 Break, Update, Trigger and Commutation Interrupt
    (void *)(uintptr_t)tim1_cc_irq_handler,             // 14: TIM1 Capture Compare Interrupt
    (void *)(uintptr_t)__not_implemented,               // 15
    (void *)(uintptr_t)tim3_irq_handler,                // 16: TIM3 global Interrupt
    (void *)(uintptr_t)__not_implemented,               // 17
    (void *)(uintptr_t)__not_implemented,               // 18
    (void *)(uintptr_t)tim14_irq_handler,               // 19: TIM14 global Interrupt
    (void *)(uintptr_t)__not_implemented,               // 20
    (void *)(uintptr_t)tim16_irq_handler,               // 21: TIM16 global Interrupt
    (void *)(uintptr_t)tim17_irq_handler,               // 22: TIM17 global Interrupt
    (void *)(uintptr_t)i2c1_irq_handler,                // 23: I2C1 Event Interrupt & EXTI Line23 Interrupt (I2C1 wakeup)
    (void *)(uintptr_t)__not_implemented,               // 24
    (void *)(uintptr_t)spi1_irq_handler,                // 25: SPI1 global Interrupt
    (void *)(uintptr_t)__not_implemented,               // 26
    (void *)(uintptr_t)usart1_irq_handler,              // 27: USART1 global Interrupt & EXTI Line25 Interrupt (USART1 wakeup)
    (void *)(uintptr_t)usart2_irq_handler,              // 28: USART2 global Interrupt
    (void *)(uintptr_t)__not_implemented,               // 29
    (void *)(uintptr_t)__not_implemented,               // 30
    (void *)(uintptr_t)usb_irq_handler,                 // 31: USB global Interrupt  & EXTI Line18 Interrupt
};

/**
 * @brief      This is the first code called at reset
 */
void reset_handler(void) {
    extern uint32_t _etext, _srelocate, _erelocate, _bss, _ebss;

    // Initialize the relocate segment
    uint32_t *src = &_etext;
    uint32_t *dst = &_srelocate;
    if (src != dst) {
        while (dst < &_erelocate) {
            *(dst++) = *(src++);
        }
    }

    // Clear the BSS segment
    dst = &_bss;
    while (dst < &_ebss) {
        *(dst++) = 0;
    }

    // Start main function
    main();

    // Loop forever
    while (1) {
    }
}

/**
 * @brief      Dummy for: Terminate the calling process
 *
 * @param      status  The status
 */
void _exit(int status) {
    (void)status;
    while (1) {
    }
}

/**
 * @brief      Dummy for: Register a function to be called on exit
 *
 * @param      func  The function
 *
 * @return     0 if successful, otherwise -1
 */
int atexit(void (*func)(void)) {
    (void)func;
    return 0;
}
