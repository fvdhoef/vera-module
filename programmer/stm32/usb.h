#pragma once

#include "lib.h"
#include "usbd_core.h"

#define CMD_EPIN_ADDR (0x83)
#define CMD_EPIN_SIZE (64)
#define CMD_EPOUT_ADDR (0x04)
#define CMD_EPOUT_SIZE (64)

void usb_init();
void usb_send_buffer(void *buf, unsigned size);

extern void usb_handle_cmd_packet(struct buf_reader *br);

uint8_t programmer_init(struct _USBD_HandleTypeDef *pdev, uint8_t cfgidx);
uint8_t programmer_deinit(struct _USBD_HandleTypeDef *pdev, uint8_t cfgidx);
uint8_t programmer_data_in(struct _USBD_HandleTypeDef *pdev, uint8_t epnum);
uint8_t programmer_data_out(struct _USBD_HandleTypeDef *pdev, uint8_t epnum);
