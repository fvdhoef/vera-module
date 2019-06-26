#include "lib.h"
#include "usb.h"
#include "spi.h"
#include "buf_reader.h"
#include "flash.h"

enum {
    CMD_SPI_MODE_NONE      = 0x20,
    CMD_SPI_MODE_FPGA_BOOT = 0x21,
    CMD_SPI_MODE_FPGA      = 0x22,
    CMD_SPI_MODE_FLASH     = 0x23,

    CMD_GET_CDONE = 0x28,

    CMD_SPI_SHIFT_TX    = 0x30,
    CMD_SPI_SHIFT_RX    = 0x31,
    CMD_SPI_SHIFT_TX_RX = 0x32,

    CMD_SPI_CHIP_SELECT   = 0x33,
    CMD_SPI_CHIP_DESELECT = 0x34,

    CMD_MASS_STORAGE_MODE = 0x40,

    CMD_MASS_ERASE = 0xFF,
};

static uint8_t spi_result[64];

TIMER(self_destruct_timer) {
    flash_mass_erase();
}

void usb_handle_cmd_packet(struct buf_reader *br) {
    switch (buf_reader_get_u8(br)) {
        case CMD_SPI_MODE_NONE: spi_set_mode(SPI_MODE_NONE); break;
        case CMD_SPI_MODE_FPGA_BOOT: spi_set_mode(SPI_MODE_FPGA_BOOT); break;
        case CMD_SPI_MODE_FPGA: spi_set_mode(SPI_MODE_FPGA); break;
        case CMD_SPI_MODE_FLASH: spi_set_mode(SPI_MODE_FLASH); break;

        case CMD_GET_CDONE:
            spi_result[0] = io_in(IO_FPGA_CDONE);
            usb_send_buffer(spi_result, 1);
            break;

        case CMD_SPI_CHIP_SELECT: spi_select(true); break;
        case CMD_SPI_CHIP_DESELECT: spi_select(false); break;

        case CMD_SPI_SHIFT_TX: {
            uint8_t length;
            if (!buf_reader_try_get_u8(br, &length)) {
                return;
            }
            if (buf_reader_get_remaining(br) < length) {
                return;
            }
            spi_transfer(buf_reader_get_current(br), NULL, length);
            break;
        }

        case CMD_SPI_SHIFT_RX: {
            uint8_t length;
            if (!buf_reader_try_get_u8(br, &length)) {
                return;
            }
            if (length > sizeof(spi_result)) {
                return;
            }

            spi_transfer(NULL, spi_result, length);
            usb_send_buffer(spi_result, length);
            break;
        }

        case CMD_SPI_SHIFT_TX_RX: {
            uint8_t length;
            if (!buf_reader_try_get_u8(br, &length)) {
                return;
            }
            if (buf_reader_get_remaining(br) < length || length > sizeof(spi_result)) {
                return;
            }
            spi_transfer(buf_reader_get_current(br), spi_result, length);
            usb_send_buffer(spi_result, length);
            break;
        }

        case CMD_MASS_ERASE: {
            usb_send_buffer("T-1", 3);
            timer_start(&self_destruct_timer, MS_TO_TICKS(1000));
            break;
        }
    }
}

#define STACK_FILL_VALUE (0xDEC0ADDE)

TIMER(stack_check) {
    extern uint32_t _sstack, _estack;

    uint32_t stack_usage = (uintptr_t)&_estack - (uintptr_t)&_sstack;

    // Fill stack area
    uint32_t *p = &_sstack;
    while (stack_usage) {
        if (*(p++) != STACK_FILL_VALUE) {
            break;
        }
        stack_usage -= 4;
    }

    printf("stack_usage: %lu\n", stack_usage);
}

int main(void) {
    clear_screen();
    printf(ANSI_BOLD "iCE40 UltraPlus programmer\n" ANSI_RESET);

    clock_init();
    clock_enable(CLK_DMA);

    // map main flash at 0, so interrupt vectors are correct
    SYSCFG->CFGR1 &= ~3;

    io_configure_all_pins();

    lltimer_init();

    // Stack usage checking
    {
        extern uint32_t _sstack;

        // Fill stack area
        uint32_t *p     = &_sstack;
        uint32_t *p_end = (uint32_t *)__get_MSP();

        while (p != p_end) {
            *(p++) = STACK_FILL_VALUE;
        }
    }
    timer_restart(&stack_check, 0, MS_TO_TICKS(2000));

    spi_set_mode(SPI_MODE_FPGA_BOOT);
    usb_init();
    printf("Done.\n");

    // timer_restart(&uart_check, 0, MS_TO_TICKS(1));
    task_run();
    return 0;
}
