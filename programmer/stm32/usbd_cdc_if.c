#include "usbd_cdc_if.h"
#include "lib.h"

static void cdc_if_init(void);
static void cdc_if_deinit(void);
static void cdc_if_control(uint8_t cmd, uint8_t *buf, uint16_t length);
static void cdc_if_receive(uint8_t *buf, uint32_t length);
static void cdc_if_transmit_done(void);

const struct cdc_interface cdc_fops = {
    .init          = cdc_if_init,
    .deinit        = cdc_if_deinit,
    .control       = cdc_if_control,
    .receive       = cdc_if_receive,
    .transmit_done = cdc_if_transmit_done,
};

struct cdc_line_coding line_coding = {
    .bitrate    = 6000000, // baud rate
    .format     = 0x00,    // stopbits: 0=1 bit, 1=1.5 bits, 2=2 bits
    .paritytype = 0x00,    // parity: 0=None, 1=Odd, 2=Even, 3=Mark, 4=Space
    .datatype   = 0x08     // databits: [5, 6, 7, 8, 16]
};

extern USBD_HandleTypeDef usbd_device;

TIMER(uart_check) {
    struct cdc_handle *hcdc      = (struct cdc_handle *)usbd_device.pClassData;
    unsigned           cndtr     = DMA1_Channel5->CNDTR;
    unsigned           write_idx = sizeof(hcdc->uart_rx_buffer) - cndtr;
    static uint16_t    read_idx  = 0;

    if (read_idx == write_idx) {
        return;
    }

    if (read_idx > write_idx) {
        if (cdc_transmit_packet(&usbd_device, hcdc->uart_rx_buffer + read_idx, sizeof(hcdc->uart_rx_buffer) - read_idx)) {
            read_idx = 0;
        }
    } else {
        if (cdc_transmit_packet(&usbd_device, hcdc->uart_rx_buffer + read_idx, write_idx - read_idx)) {
            read_idx = write_idx;
        }
    }
}

static void uart_init2(void) {
    // stop TX/RX DMA and UART
    DMA1_Channel4->CCR = 0;
    DMA1_Channel5->CCR = 0;
    USART2->CR1        = 0;
    uint32_t cr1       = USART_CR1_OVER8 | USART_CR1_TE | USART_CR1_RE | USART_CR1_UE;

    if (line_coding.bitrate != 0) {
        if (USART2->CR1 & USART_CR1_OVER8) { // oversampling by 8
            uint16_t USARTDIV = SYSCLK_FREQ * 2 / line_coding.bitrate;
            USART2->BRR       = (USARTDIV & 0xFFF0) | ((USARTDIV & 0xF) >> 1);
        } else { // oversampling by 16
            uint16_t USARTDIV = SYSCLK_FREQ / line_coding.bitrate;
            USART2->BRR       = USARTDIV;
        }
    }

    switch (line_coding.datatype) {
        case 7: cr1 |= USART_CR1_M1; break;
        default:
        case 8: break;
        case 9: cr1 |= USART_CR1_M0; break;
    }

    switch (line_coding.paritytype) {
        default:
        case 0: break;                                      // None
        case 1: cr1 |= USART_CR1_PCE | USART_CR1_PS; break; // Odd
        case 2: cr1 |= USART_CR1_PCE; break;                // Even
        case 3: break;                                      // Mark. not available
        case 4: break;                                      // Space. not available
    }

    switch (line_coding.format) {
        case 1: USART2->CR2 = 0; break;
        case 2: USART2->CR2 = USART_CR2_STOP_1; break;
        default: USART2->CR2 = 0; break;
    }

    // restart UART and RX DMA
    USART2->CR1        = cr1;
    DMA1_Channel5->CCR = DMA_CCR_MINC | DMA_CCR_CIRC | DMA_CCR_EN; // DMA channel 5 configuration register
}

static void uart_init(void) {
    struct cdc_handle *hcdc = (struct cdc_handle *)usbd_device.pClassData;

    clock_enable(CLK_USART2);
    clock_enable(CLK_DMA);

    // DMA channel 5: USART2_RX
    DMA1_Channel5->CNDTR = sizeof(hcdc->uart_rx_buffer);    // DMA channel 5 number of data register
    DMA1_Channel5->CPAR  = (uintptr_t)&USART2->RDR;         // DMA channel 5 peripheral address register
    DMA1_Channel5->CMAR  = (uintptr_t)hcdc->uart_rx_buffer; // DMA channel 5 memory address register
    //DMA1_Channel5->CCR   = DMA_CCR_MINC | DMA_CCR_CIRC | DMA_CCR_EN; // DMA channel 5 configuration register

    USART2->CR3 = USART_CR3_OVRDIS | USART_CR3_DMAR | USART_CR3_DMAT; // USART Control register 3
    // USART2->CR1 = USART_CR1_OVER8 | USART_CR1_TE | USART_CR1_RE | USART_CR1_UE; // USART Control register 1
    uart_init2();

    NVIC_SetPriority(DMA1_Channel4_5_IRQn, 2);
    NVIC_EnableIRQ(DMA1_Channel4_5_IRQn);

    timer_restart(&uart_check, MS_TO_TICKS(100), MS_TO_TICKS(1));
}

static void uart_deinit(void) {
    timer_stop(&uart_check);
}

static void cdc_if_init(void) {
    printf("cdc_if_init\n");
    uart_init();
}

static void cdc_if_deinit(void) {
    printf("cdc_if_deinit\n");
    uart_deinit();
}

static void cdc_if_control(uint8_t cmd, uint8_t *pbuf, uint16_t length) {
    // printf("cdc_if_control: 0x%02x\n", cmd);
    switch (cmd) {
        case CDC_SEND_ENCAPSULATED_COMMAND: break;
        case CDC_GET_ENCAPSULATED_RESPONSE: break;
        case CDC_SET_COMM_FEATURE: break;
        case CDC_GET_COMM_FEATURE: break;
        case CDC_CLEAR_COMM_FEATURE: break;

        case CDC_SET_LINE_CODING:
            line_coding.bitrate    = (uint32_t)(pbuf[0] | (pbuf[1] << 8) | (pbuf[2] << 16) | (pbuf[3] << 24));
            line_coding.format     = pbuf[4];
            line_coding.paritytype = pbuf[5];
            line_coding.datatype   = pbuf[6];
            uart_init2();
            printf("CDC_SET_LINE_CODING  bitrate: %lu\n", line_coding.bitrate);
            break;

        case CDC_GET_LINE_CODING:
            pbuf[0] = (uint8_t)(line_coding.bitrate);
            pbuf[1] = (uint8_t)(line_coding.bitrate >> 8);
            pbuf[2] = (uint8_t)(line_coding.bitrate >> 16);
            pbuf[3] = (uint8_t)(line_coding.bitrate >> 24);
            pbuf[4] = line_coding.format;
            pbuf[5] = line_coding.paritytype;
            pbuf[6] = line_coding.datatype;
            break;

        case CDC_SET_CONTROL_LINE_STATE: break;
        case CDC_SEND_BREAK: break;
        default: break;
    }
}

TASK(uart_tx_done) {
    cdc_receive_packet(&usbd_device);
}

void dma1_channel4_5_irq_handler(void) {
    // printf("dma1_channel4_5_irq_handler\n");
    DMA1->IFCR = DMA_IFCR_CGIF4;
    task_post(&uart_tx_done);
}

static void cdc_if_receive(uint8_t *buf, uint32_t length) {
    // printf("cdc_if_receive: %u\n", length);

    if (length == 0) {
        cdc_receive_packet(&usbd_device);
        return;
    }

    // DMA channel 4: USART2_TX
    DMA1_Channel4->CCR = 0;
    DMA1->IFCR         = DMA_IFCR_CGIF4;

    DMA1_Channel4->CNDTR = length;                                                 // DMA channel 4 number of data register
    DMA1_Channel4->CPAR  = (uintptr_t)&USART2->TDR;                                // DMA channel 4 peripheral address register
    DMA1_Channel4->CMAR  = (uintptr_t)buf;                                         // DMA channel 4 memory address register
    DMA1_Channel4->CCR   = DMA_CCR_DIR | DMA_CCR_MINC | DMA_CCR_TCIE | DMA_CCR_EN; // DMA channel 4 configuration register
}

static void cdc_if_transmit_done(void) {
}
