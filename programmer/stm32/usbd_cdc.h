#pragma once

#include "usbd_ioreq.h"

#define CDC_IN_EP 0x81 // EP1 for data IN
#define CDC_IN_EP_SIZE 64

#define CDC_OUT_EP 0x01 // EP1 for data OUT
#define CDC_OUT_EP_SIZE 64

#define CDC_CMD_EP 0x82 // EP2 for CDC commands
#define CDC_CMD_EP_SIZE 8

enum {
    CDC_SEND_ENCAPSULATED_COMMAND = 0x00,
    CDC_GET_ENCAPSULATED_RESPONSE = 0x01,
    CDC_SET_COMM_FEATURE          = 0x02,
    CDC_GET_COMM_FEATURE          = 0x03,
    CDC_CLEAR_COMM_FEATURE        = 0x04,
    CDC_SET_LINE_CODING           = 0x20,
    CDC_GET_LINE_CODING           = 0x21,
    CDC_SET_CONTROL_LINE_STATE    = 0x22,
    CDC_SEND_BREAK                = 0x23,
};

struct cdc_line_coding {
    uint32_t bitrate;
    uint8_t  format;
    uint8_t  paritytype;
    uint8_t  datatype;
};

struct cdc_interface {
    void (*init)(void);
    void (*deinit)(void);
    void (*control)(uint8_t cmd, uint8_t *buf, uint16_t length);
    void (*receive)(uint8_t *buf, uint32_t length);
    void (*transmit_done)(void);
};

#define CDC_UART_RX_BUFFER_SIZE (2048)

struct cdc_handle {
    uint8_t   ep0_data[CDC_IN_EP_SIZE];
    uint8_t   cmd_opcode;
    uint8_t   cmd_length;
    uint8_t   rx_buffer[CDC_OUT_EP_SIZE];
    __IO bool tx_busy;

    uint8_t uart_rx_buffer[CDC_UART_RX_BUFFER_SIZE];
};

extern const USBD_ClassTypeDef USBD_CDC;

void cdc_register_interface(USBD_HandleTypeDef *pdev, const struct cdc_interface *fops);
void cdc_receive_packet(USBD_HandleTypeDef *pdev);
bool cdc_transmit_packet(USBD_HandleTypeDef *pdev, uint8_t *buf, uint16_t length);
