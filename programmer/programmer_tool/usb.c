#include "usb.h"
#include <libusb.h>

#define CMD_EPIN_ADDR (0x83)
#define CMD_EPOUT_ADDR (0x04)

static libusb_context *      ctx    = NULL;
static libusb_device_handle *handle = NULL;

void usb_init(void) {
    int result;
    result = libusb_init(&ctx);
    if (result != 0) {
        fprintf(stderr, "error initializing libusb\n");
        exit(EXIT_FAILURE);
    }

    handle = libusb_open_device_with_vid_pid(ctx, 0xc0de, 0xbabe);
    if (handle == NULL) {
        fprintf(stderr, "error opening device\n");
        exit(EXIT_FAILURE);
    }

    if (libusb_claim_interface(handle, 2) != 0) {
        fprintf(stderr, "error claiming usb interface!\n");
        exit(EXIT_FAILURE);
    }
}

void spi_set_mode(enum spi_mode mode) {
    uint8_t cmd = 0;

    switch (mode) {
        case SPI_MODE_NONE: cmd = CMD_SPI_MODE_NONE; break;
        case SPI_MODE_FPGA_BOOT: cmd = CMD_SPI_MODE_FPGA_BOOT; break;
        case SPI_MODE_FPGA: cmd = CMD_SPI_MODE_FPGA; break;
        case SPI_MODE_FLASH: cmd = CMD_SPI_MODE_FLASH; break;
    }
    int transferred = 0;
    libusb_bulk_transfer(handle, CMD_EPOUT_ADDR, &cmd, 1, &transferred, 0);
    if (transferred != 1) {
        fprintf(stderr, "spi_select - transferred != 1 (%d)\n", transferred);
        exit(EXIT_FAILURE);
    }
}

void spi_select(bool on) {
    uint8_t cmd         = on ? CMD_SPI_CHIP_SELECT : CMD_SPI_CHIP_DESELECT;
    int     transferred = 0;
    libusb_bulk_transfer(handle, CMD_EPOUT_ADDR, &cmd, 1, &transferred, 0);
    if (transferred != 1) {
        fprintf(stderr, "spi_select - transferred != 1 (%d)\n", transferred);
        exit(EXIT_FAILURE);
    }
}

void spi_transfer(const void *tx_buf, void *rx_buf, size_t length) {
    uint8_t  cmd[64];
    unsigned cmdlen = 0;

    unsigned       remaining = length;
    uint8_t *      rx_buf8   = (uint8_t *)rx_buf;
    const uint8_t *tx_buf8   = (const uint8_t *)tx_buf;

    while (remaining > 0) {
        unsigned xfer_size = remaining;
        cmdlen             = 0;

        if (tx_buf8 && rx_buf8) {
            cmd[cmdlen++] = CMD_SPI_SHIFT_TX_RX;
        } else if (tx_buf8) {
            cmd[cmdlen++] = CMD_SPI_SHIFT_TX;
        } else if (rx_buf8) {
            cmd[cmdlen++] = CMD_SPI_SHIFT_RX;
        } else {
            // No transfer needed
            return;
        }

        if (tx_buf8) {
            if (xfer_size > 62)
                xfer_size = 62;
        } else {
            if (xfer_size > 64)
                xfer_size = 64;
        }
        cmd[cmdlen++] = xfer_size;

        if (tx_buf8) {
            memcpy(&cmd[cmdlen], tx_buf8, xfer_size);
            tx_buf8 += xfer_size;
            cmdlen += xfer_size;
        }

        int transferred = 0;
        libusb_bulk_transfer(handle, CMD_EPOUT_ADDR, cmd, cmdlen, &transferred, 0);
        if (transferred != (int)cmdlen) {
            fprintf(stderr, "spi_transfer - tx transferred != %d (%d)\n", cmdlen, transferred);
            exit(EXIT_FAILURE);
        }

        if (rx_buf8) {
            libusb_bulk_transfer(handle, CMD_EPIN_ADDR, rx_buf8, xfer_size, &transferred, 0);
            if (transferred != (int)xfer_size) {
                fprintf(stderr, "spi_transfer - rx transferred != %d (%d)\n", xfer_size, transferred);
                exit(EXIT_FAILURE);
            }
            rx_buf8 += xfer_size;
        }

        remaining -= xfer_size;
    }
}

bool get_cdone(void) {
    int     transferred = 0;
    uint8_t cmd         = CMD_GET_CDONE;
    libusb_bulk_transfer(handle, CMD_EPOUT_ADDR, &cmd, 1, &transferred, 0);

    uint8_t result = 0;
    libusb_bulk_transfer(handle, CMD_EPIN_ADDR, &result, 1, &transferred, 0);

    return result != 0;
}

void start_mass_erase(void) {
    int     transferred = 0;
    uint8_t cmd         = CMD_MASS_ERASE;
    libusb_bulk_transfer(handle, CMD_EPOUT_ADDR, &cmd, 1, &transferred, 0);
}
