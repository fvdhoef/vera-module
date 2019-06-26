#include "spi.h"
#include "lib.h"

#define USE_DMA 1

static bool          spi_active   = false;
static enum spi_mode current_mode = SPI_MODE_NONE;

static void spi_tx_bit_bang(const void *tx_buf, size_t length);

static void spi_init(void) {
    if (spi_active) {
        return;
    }

    io_set_mode(IO_SPI_SCK, IOMODE_ALT);
    io_set_mode(IO_SPI_MOSI, IOMODE_ALT);
    io_set_mode(IO_SPI_MISO, IOMODE_ALT);
    io_out(IO_FPGA_SSEL, 0);
    io_set_mode(IO_FPGA_SSEL, IOMODE_OUT);

    clock_enable(CLK_SPI1);
    unsigned freq = clock_get_frequency(CLK_SPI1);
    uint16_t br   = 0;
    printf("Selected SPI clock frequency: %u\n", freq / (2 << br));

    SPI1->CR1 = (br << 3) | SPI_CR1_SSM | SPI_CR1_SSI | SPI_CR1_MSTR;
    SPI1->CR2 = SPI_CR2_FRXTH | (7 << SPI_CR2_DS_Pos);
#if USE_DMA
    SPI1->CR2 |= SPI_CR2_TXDMAEN | SPI_CR2_RXDMAEN;
#endif
    SPI1->CR1 |= SPI_CR1_SPE;

    spi_active = true;
}

static void spi_deinit(void) {
    if (!spi_active) {
        return;
    }

    while ((SPI1->SR & SPI_SR_FTLVL_Msk) != 0) {
    }
    while ((SPI1->SR & SPI_SR_BSY) != 0) {
    }
    SPI1->CR1 &= ~SPI_CR1_SPE;
    while ((SPI1->SR & SPI_SR_FRLVL) != 0) {
        *((volatile uint8_t *)&SPI1->DR);
    }
    clock_disable(CLK_SPI1);

    io_set_mode(IO_SPI_SCK, IOMODE_IN);
    io_set_mode(IO_SPI_MOSI, IOMODE_IN);
    io_set_mode(IO_SPI_MISO, IOMODE_IN);

    spi_active = false;
    printf("spi_deinit\n");
}

void spi_set_mode(enum spi_mode mode) {
    current_mode = mode;

    switch (mode) {
        default: break;
        case SPI_MODE_NONE:
            spi_deinit();

            printf("SPI_MODE_NONE\n");

            io_set_mode(IO_SPI_SCK, IOMODE_IN);
            io_set_mode(IO_SPI_MISO, IOMODE_IN);
            io_set_mode(IO_SPI_MOSI, IOMODE_IN);
            io_set_mode(IO_FPGA_SSEL, IOMODE_IN);
            break;

        case SPI_MODE_FPGA_BOOT:
            spi_deinit();

            printf("SPI_MODE_FPGA_BOOT\n");

            io_out(IO_FPGA_RESET, 1);
            io_set_mode(IO_SPI_SCK, IOMODE_IN);
            io_set_mode(IO_SPI_MISO, IOMODE_IN);
            io_set_mode(IO_SPI_MOSI, IOMODE_IN);
            io_set_mode(IO_FPGA_SSEL, IOMODE_IN);
            udelay(2);
            io_out(IO_FPGA_RESET, 0);
            break;

        case SPI_MODE_FPGA:
            spi_deinit();

            printf("SPI_MODE_FPGA\n");

            io_out(IO_FPGA_RESET, 1);
            io_out(IO_SPI_SCK, 0);
            io_out(IO_SPI_MISO, 0);
            io_out(IO_SPI_MOSI, 0);

            io_set_mode(IO_SPI_SCK, IOMODE_OUT);
            io_set_mode(IO_SPI_MISO, IOMODE_OUT); // MISO line is used to slave configure FPGA
            io_set_mode(IO_SPI_MOSI, IOMODE_IN);
            io_out(IO_FPGA_SSEL, 1);
            io_set_mode(IO_FPGA_SSEL, IOMODE_OUT);

            udelay(2);
            io_out(IO_FPGA_RESET, 0);
            udelay(2);
            break;

        case SPI_MODE_FLASH:
            io_out(IO_FPGA_RESET, 1);
            spi_init();

            udelay(2);

            {
                spi_select(1);
                uint8_t cmd = 0xAB;
                spi_transfer(&cmd, NULL, 1);
                spi_select(0);
            }

            udelay(2);
            printf("SPI_MODE_FLASH\n");

            break;
    }
}

void spi_select(bool on) {
    if (current_mode == SPI_MODE_FLASH) {
        // printf("FPGA_SSEL: %d\n", on);
        io_out(IO_FPGA_SSEL, on);
        udelay(2);
    }
}

#if USE_DMA
void spi_transfer(const void *tx_buf, void *rx_buf, size_t length) {
    if (length == 0) {
        return;
    }
    if (!spi_active) {
        if (tx_buf) {
            spi_tx_bit_bang(tx_buf, length);
        }
        return;
    }

    uint8_t rx_dummy;
    uint8_t tx_dummy = 0xff;

    DMA1->IFCR = DMA_IFCR_CGIF2 | DMA_IFCR_CGIF3;

    // DMA channel 2: SPI1_RX
    DMA1_Channel2->CNDTR = length;                       // Number of data register
    DMA1_Channel2->CPAR  = (uintptr_t)&SPI1->DR;         // Peripheral address register
    if (rx_buf) {                                        //
        DMA1_Channel2->CMAR = (uintptr_t)rx_buf;         // Memory address register
        DMA1_Channel2->CCR  = DMA_CCR_MINC | DMA_CCR_EN; // Configuration register
    } else {                                             //
        DMA1_Channel2->CMAR = (uintptr_t)&rx_dummy;      // Memory address register
        DMA1_Channel2->CCR  = DMA_CCR_EN;                // Configuration register
    }

    // DMA channel 3: SPI1_TX
    DMA1_Channel3->CNDTR = length;                                     // Number of data register
    DMA1_Channel3->CPAR  = (uintptr_t)&SPI1->DR;                       // Peripheral address register
    if (tx_buf) {                                                      //
        DMA1_Channel3->CMAR = (uintptr_t)tx_buf;                       // Memory address register
        DMA1_Channel3->CCR  = DMA_CCR_MINC | DMA_CCR_DIR | DMA_CCR_EN; // Configuration register
    } else {                                                           //
        DMA1_Channel3->CMAR = (uintptr_t)&tx_dummy;                    // Memory address register
        DMA1_Channel3->CCR  = DMA_CCR_DIR | DMA_CCR_EN;                // Configuration register
    }

    while ((DMA1->ISR & (DMA_ISR_TCIF2 | DMA_ISR_TCIF3)) != (DMA_ISR_TCIF2 | DMA_ISR_TCIF3)) {
    }

    DMA1_Channel2->CCR &= ~DMA_CCR_EN;
    DMA1_Channel3->CCR &= ~DMA_CCR_EN;
    DMA1->IFCR = DMA_IFCR_CGIF2 | DMA_IFCR_CGIF3;
}
#else
void spi_transfer(const void *tx_buf, void *rx_buf, size_t length) {
    if (length == 0) {
        return;
    }

    if (spi_active) {
        // printf("spi_transfer: %u\n", length);

        uint8_t *      rx_buf8 = (uint8_t *)rx_buf;
        const uint8_t *tx_buf8 = (const uint8_t *)tx_buf;

        if (tx_buf8 && rx_buf8) {
            while (length--) {
                while ((SPI1->SR & SPI_SR_TXE) == 0) {
                }
                *((volatile uint8_t *)&SPI1->DR) = *(tx_buf8++);

                while ((SPI1->SR & SPI_SR_RXNE) == 0) {
                }
                *(rx_buf8++) = *((volatile uint8_t *)&SPI1->DR);
            }

        } else if (tx_buf8) {
            while (length--) {
                while ((SPI1->SR & SPI_SR_TXE) == 0) {
                }
                *((volatile uint8_t *)&SPI1->DR) = *(tx_buf8++);

                while ((SPI1->SR & SPI_SR_RXNE) == 0) {
                }
                *((volatile uint8_t *)&SPI1->DR);
            }

        } else if (rx_buf8) {
            while (length--) {
                while ((SPI1->SR & SPI_SR_TXE) == 0) {
                }
                *((volatile uint8_t *)&SPI1->DR) = 0xFF;

                while ((SPI1->SR & SPI_SR_RXNE) == 0) {
                }
                *(rx_buf8++) = *((volatile uint8_t *)&SPI1->DR);
            }

        } else {
            while (length--) {
                while ((SPI1->SR & SPI_SR_TXE) == 0) {
                }
                *((volatile uint8_t *)&SPI1->DR) = 0xFF;

                while ((SPI1->SR & SPI_SR_RXNE) == 0) {
                }
                *((volatile uint8_t *)&SPI1->DR);
            }
        }

    } else {
        if (tx_buf) {
            spi_tx_bit_bang(tx_buf, length);
        }
    }
}
#endif

#pragma GCC optimize("O3")

void spi_tx_bit_bang(const void *tx_buf, size_t length) {
    // printf("spi_tx_bit_bang: %u\n", length);
    if (length == 0) {
        return;
    }
    const uint8_t *tx_buf8 = (const uint8_t *)tx_buf;

    while (length--) {
        uint8_t data = *(tx_buf8++);
        for (unsigned i = 0; i < 8; i++) {
            io_out(IO_SPI_SCK, 0);
            io_out(IO_SPI_MISO, (data & (1 << (7 - i))) != 0);
            io_out(IO_SPI_SCK, 1);
        }
    }
}
