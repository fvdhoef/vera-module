#pragma once

#include "common.h"
#include <stdint.h>

enum spi_mode {
    SPI_MODE_NONE,
    SPI_MODE_FPGA_BOOT,
    SPI_MODE_FPGA,
    SPI_MODE_FLASH,
};

void spi_set_mode(enum spi_mode mode);
void spi_select(bool on);
void spi_transfer(const void *tx_buf, void *rx_buf, size_t length);
