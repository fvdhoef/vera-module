#pragma once

#include "lib.h"

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
    CMD_MASS_ERASE        = 0xFF,
};

void usb_init(void);

enum spi_mode {
    SPI_MODE_NONE,
    SPI_MODE_FPGA_BOOT,
    SPI_MODE_FPGA,
    SPI_MODE_FLASH,
};

void spi_set_mode(enum spi_mode mode);
void spi_select(bool on);
void spi_transfer(const void *tx_buf, void *rx_buf, size_t length);

bool get_cdone(void);

void start_mass_erase(void);
