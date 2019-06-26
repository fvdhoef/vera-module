#include "lib.h"
#include "flash.h"

__attribute__((section(".ramcode"))) static bool flash_wait_for_last_operation() {
    uint32_t timeout = 0x000B0000;
    do {
        bool ready = ((FLASH->SR & FLASH_SR_BSY) == 0); // && ((FLASH->SR & (uint32_t)FLASH_SR_WRPERR) == 0) && ((FLASH->SR & (uint32_t)(FLASH_SR_PGERR)) == 0));
        if (ready) {
            break;
        }
        if (--timeout == 0) {
            break;
        }
    } while (true);
    return (timeout != 0);
}

__attribute__((section(".ramcode"))) bool flash_mass_erase(void) {
    __disable_irq();

    FLASH->ACR = 0;

    bool status = flash_wait_for_last_operation();
    if (status) {
        if ((FLASH->CR & FLASH_CR_LOCK) != 0) {
            FLASH->KEYR = FLASH_KEY1;
            FLASH->KEYR = FLASH_KEY2;
        }

        FLASH->CR |= FLASH_CR_MER;
        FLASH->CR |= FLASH_CR_STRT;
        status = flash_wait_for_last_operation();
        FLASH->CR &= ~FLASH_CR_MER;

        FLASH->CR |= FLASH_CR_LOCK;

        FLASH->CR |= FLASH_CR_OBL_LAUNCH;

        NVIC_SystemReset();
    }
    return false;
}
