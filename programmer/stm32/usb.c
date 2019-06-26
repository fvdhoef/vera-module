#include "usb.h"
#include "lib.h"
#include "usbd_core.h"
#include "usbd_conf.h"
#include "stm32f0xx_hal_pcd.h"
#include "usbd_cdc.h"
#include "usbd_cdc_if.h"

USBD_HandleTypeDef usbd_device;

TASK_DECL(handle_cmd_packet_task);

#define USBD_VID 0xC0DE
#define USBD_PID 0xBABE

#define USBD_LANGID_STRING 0x409
#define USBD_MANUFACTURER_STRING "Frank van den Hoef"
#define USBD_PRODUCT_FS_STRING "iCE40 UltraPlus Programmer"
#define USBD_CONFIGURATION_STRING "Config"
#define USBD_INTERFACE_STRING "Interface"

static const uint8_t device_descriptor[USB_LEN_DEV_DESC] = {
    0x12,                      // bLength
    USB_DESC_TYPE_DEVICE,      // bDescriptorType
    0x00,                      // bcdUSB
    0x02,                      //
    0x00,                      // bDeviceClass
    0x00,                      // bDeviceSubClass
    0x00,                      // bDeviceProtocol
    USB_MAX_EP0_SIZE,          // bMaxPacketSize
    LOBYTE(USBD_VID),          // idVendor
    HIBYTE(USBD_VID),          // idVendor
    LOBYTE(USBD_PID),          // idProduct
    HIBYTE(USBD_PID),          // idProduct
    0x00,                      // bcdDevice rel. 1.00
    0x01,                      //
    USBD_IDX_MFC_STR,          // Index of manufacturer string
    USBD_IDX_PRODUCT_STR,      // Index of product string
    USBD_IDX_SERIAL_STR,       // Index of serial number string
    USBD_MAX_NUM_CONFIGURATION // bNumConfigurations
};

static const uint8_t usbd_langiddesc[USB_LEN_LANGID_STR_DESC] = {
    USB_LEN_LANGID_STR_DESC,
    USB_DESC_TYPE_STRING,
    LOBYTE(USBD_LANGID_STRING),
    HIBYTE(USBD_LANGID_STRING),
};

static alignas(2) uint8_t usbd_str_desc[USBD_MAX_STR_DESC_SIZ];
static void int_to_unicode(uint32_t value, uint8_t *pbuf, uint8_t len);

static const uint8_t *programmer_device_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    *length = sizeof(device_descriptor);
    return device_descriptor;
}

static uint8_t *programmer_langid_str_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    *length = sizeof(usbd_langiddesc);
    return (uint8_t *)usbd_langiddesc;
}

static uint8_t *programmer_product_str_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    USBD_GetString((uint8_t *)USBD_PRODUCT_FS_STRING, usbd_str_desc, length);
    return usbd_str_desc;
}

static uint8_t *programmer_manufacturer_str_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    USBD_GetString((uint8_t *)USBD_MANUFACTURER_STRING, usbd_str_desc, length);
    return usbd_str_desc;
}

static void int_to_unicode(uint32_t value, uint8_t *pbuf, uint8_t len) {
    for (unsigned idx = 0; idx < len; idx++) {
        if (((value >> 28)) < 0xA) {
            pbuf[2 * idx] = (value >> 28) + '0';
        } else {
            pbuf[2 * idx] = (value >> 28) + 'A' - 10;
        }

        value             = value << 4;
        pbuf[2 * idx + 1] = 0;
    }
}

static uint8_t *programmer_serial_str_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    usbd_str_desc[1] = USB_DESC_TYPE_STRING;

    volatile uint32_t *uid = (volatile uint32_t *)UID_BASE;

    unsigned size = 2;
    int_to_unicode(uid[0], &usbd_str_desc[size], 8);
    size += 2 * 8;
    int_to_unicode(uid[1], &usbd_str_desc[size], 8);
    size += 2 * 8;
    int_to_unicode(uid[2], &usbd_str_desc[size], 8);
    size += 2 * 8;

    usbd_str_desc[0] = size;
    *length          = size;
    return usbd_str_desc;
}

static uint8_t *programmer_config_str_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    USBD_GetString((uint8_t *)USBD_CONFIGURATION_STRING, usbd_str_desc, length);
    return usbd_str_desc;
}

static uint8_t *programmer_interface_str_descriptor(USBD_SpeedTypeDef speed, uint16_t *length) {
    USBD_GetString((uint8_t *)USBD_INTERFACE_STRING, usbd_str_desc, length);
    return usbd_str_desc;
}

static const USBD_DescriptorsTypeDef programmer_desc = {
    .GetDeviceDescriptor           = programmer_device_descriptor,
    .GetLangIDStrDescriptor        = programmer_langid_str_descriptor,
    .GetManufacturerStrDescriptor  = programmer_manufacturer_str_descriptor,
    .GetProductStrDescriptor       = programmer_product_str_descriptor,
    .GetSerialStrDescriptor        = programmer_serial_str_descriptor,
    .GetConfigurationStrDescriptor = programmer_config_str_descriptor,
    .GetInterfaceStrDescriptor     = programmer_interface_str_descriptor,
};

static alignas(2) uint8_t cmd_rx_buf[64];
static volatile unsigned cmd_rx_buf_size  = 0;
static volatile bool     cmd_rx_buf_ready = false;

uint8_t programmer_init(struct _USBD_HandleTypeDef *pdev, uint8_t cfgidx) {
    printf("programmer_init\n");
    USBD_LL_OpenEP(pdev, CMD_EPIN_ADDR, USBD_EP_TYPE_BULK, CMD_EPIN_SIZE);
    USBD_LL_OpenEP(pdev, CMD_EPOUT_ADDR, USBD_EP_TYPE_BULK, CMD_EPOUT_SIZE);
    USBD_LL_PrepareReceive(pdev, CMD_EPOUT_ADDR, cmd_rx_buf, sizeof(cmd_rx_buf));

    return USBD_OK;
}

uint8_t programmer_deinit(struct _USBD_HandleTypeDef *pdev, uint8_t cfgidx) {
    printf("programmer_deinit\n");
    return USBD_OK;
}

uint8_t programmer_data_in(struct _USBD_HandleTypeDef *pdev, uint8_t epnum) {
    // printf("programmer_data_in\n");
    return USBD_OK;
}

uint8_t programmer_data_out(struct _USBD_HandleTypeDef *pdev, uint8_t epnum) {
    unsigned size = USBD_LL_GetRxDataSize(pdev, epnum);

    printf("programmer_data_out: 0x%02x  %u\n", epnum, size);

    if (epnum == (CMD_EPOUT_ADDR & 0xF)) {
        cmd_rx_buf_size  = size;
        cmd_rx_buf_ready = true;
        task_post(&handle_cmd_packet_task);
    }
    return USBD_OK;
}

void usb_init() {
    USBD_Init(&usbd_device, &programmer_desc, 0);

    PCD_HandleTypeDef *hpcd   = (PCD_HandleTypeDef *)usbd_device.pData;
    unsigned           offset = 0x40;
    HAL_PCDEx_PMAConfig(hpcd, 0x00, PCD_SNG_BUF, offset);
    offset += 64;
    HAL_PCDEx_PMAConfig(hpcd, 0x80, PCD_SNG_BUF, offset);
    offset += 64;

    // CDC
    HAL_PCDEx_PMAConfig(hpcd, CDC_IN_EP, PCD_SNG_BUF, offset);
    offset += CDC_IN_EP_SIZE;

    HAL_PCDEx_PMAConfig(hpcd, CDC_OUT_EP, PCD_SNG_BUF, offset);
    offset += CDC_OUT_EP_SIZE;

    HAL_PCDEx_PMAConfig(hpcd, CDC_CMD_EP, PCD_SNG_BUF, offset);
    offset += CDC_CMD_EP_SIZE;

    // Programmer
    HAL_PCDEx_PMAConfig(hpcd, CMD_EPIN_ADDR, PCD_SNG_BUF, offset);
    offset += CMD_EPIN_SIZE;

    HAL_PCDEx_PMAConfig(hpcd, CMD_EPOUT_ADDR, PCD_SNG_BUF, offset);
    offset += CMD_EPOUT_SIZE;

    USBD_RegisterClass(&usbd_device, &USBD_CDC);
    cdc_register_interface(&usbd_device, &cdc_fops);

    USBD_Start(&usbd_device);
}

TASK(handle_cmd_packet_task) {
    if (!cmd_rx_buf_ready) {
        return;
    }

    if (cmd_rx_buf_size) {
        struct buf_reader br;
        buf_reader_init(&br, cmd_rx_buf, cmd_rx_buf_size);
        usb_handle_cmd_packet(&br);
    }

    cmd_rx_buf_ready = false;
    USBD_LL_PrepareReceive(&usbd_device, CMD_EPOUT_ADDR, cmd_rx_buf, sizeof(cmd_rx_buf));
}

void usb_send_buffer(void *buf, unsigned size) {
    USBD_LL_Transmit(&usbd_device, CMD_EPIN_ADDR, buf, size);
}
