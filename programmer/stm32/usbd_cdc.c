#include "usbd_cdc.h"
#include "usbd_ctlreq.h"
#include "usb.h"

#define USB_CDC_CONFIG_DESC_SIZ (9 + /* CDC */ 9 + 5 + 5 + 4 + 5 + 7 + 9 + 7 + 7 /* Programmer */ + 9 + 7 + 7)

// USB CDC device Configuration Descriptor
static const alignas(4) uint8_t cdc_config_desc[USB_CDC_CONFIG_DESC_SIZ] = {
    // Configuration descriptor
    0x09,                        // bLength: Configuration Descriptor size
    USB_DESC_TYPE_CONFIGURATION, // bDescriptorType: Configuration
    USB_CDC_CONFIG_DESC_SIZ,     // wTotalLength:no of returned bytes
    0x00,                        //
    0x03,                        // bNumInterfaces: 3 interfaces
    0x01,                        // bConfigurationValue: Configuration value
    0x00,                        // iConfiguration: Index of string descriptor describing the configuration
    0x80,                        // bmAttributes: bus powered
    500 / 2,                     // MaxPower 0 mA

    // Interface descriptor
    0x09,                    // bLength: Interface Descriptor size
    USB_DESC_TYPE_INTERFACE, // bDescriptorType: Interface
    0x00,                    // bInterfaceNumber: Number of Interface
    0x00,                    // bAlternateSetting: Alternate setting
    0x01,                    // bNumEndpoints: One endpoints used
    0x02,                    // bInterfaceClass: Communication Interface Class
    0x02,                    // bInterfaceSubClass: Abstract Control Model
    0x01,                    // bInterfaceProtocol: Common AT commands
    0x00,                    // iInterface:

    // Class specific interface descriptor: Header Functional Descriptor
    0x05, // bLength: Endpoint Descriptor size
    0x24, // bDescriptorType: CS_INTERFACE
    0x00, // bDescriptorSubtype: Header Func Desc
    0x10, // bcdCDC: spec release number
    0x01, //

    // Class specific interface descriptor: Call Management Functional Descriptor
    0x05, // bFunctionLength
    0x24, // bDescriptorType: CS_INTERFACE
    0x01, // bDescriptorSubtype: Call Management Func Desc
    0x00, // bmCapabilities: D0+D1
    0x01, // bDataInterface: 1

    // Class specific interface descriptor: ACM Functional Descriptor
    0x04, // bFunctionLength
    0x24, // bDescriptorType: CS_INTERFACE
    0x02, // bDescriptorSubtype: Abstract Control Management desc
    0x02, // bmCapabilities

    // Class specific interface descriptor: Union Functional Descriptor
    0x05, // bFunctionLength
    0x24, // bDescriptorType: CS_INTERFACE
    0x06, // bDescriptorSubtype: Union func desc
    0x00, // bMasterInterface: Communication class interface
    0x01, // bSlaveInterface0: Data Class Interface

    // Endpoint 2 Descriptor
    0x07,                    // bLength: Endpoint Descriptor size
    USB_DESC_TYPE_ENDPOINT,  // bDescriptorType: Endpoint
    CDC_CMD_EP,              // bEndpointAddress
    0x03,                    // bmAttributes: Interrupt
    LOBYTE(CDC_CMD_EP_SIZE), // wMaxPacketSize:
    HIBYTE(CDC_CMD_EP_SIZE), //
    0x10,                    // bInterval:

    // Data class interface descriptor
    0x09,                    // bLength: Endpoint Descriptor size
    USB_DESC_TYPE_INTERFACE, // bDescriptorType:
    0x01,                    // bInterfaceNumber: Number of Interface
    0x00,                    // bAlternateSetting: Alternate setting
    0x02,                    // bNumEndpoints: Two endpoints used
    0x0A,                    // bInterfaceClass: CDC
    0x00,                    // bInterfaceSubClass:
    0x00,                    // bInterfaceProtocol:
    0x00,                    // iInterface:

    // Endpoint OUT Descriptor
    0x07,                    // bLength: Endpoint Descriptor size
    USB_DESC_TYPE_ENDPOINT,  // bDescriptorType: Endpoint
    CDC_OUT_EP,              // bEndpointAddress
    0x02,                    // bmAttributes: Bulk
    LOBYTE(CDC_OUT_EP_SIZE), // wMaxPacketSize:
    HIBYTE(CDC_OUT_EP_SIZE), //
    0x00,                    // bInterval: ignore for Bulk transfer

    // Endpoint IN Descriptor
    0x07,                   // bLength: Endpoint Descriptor size
    USB_DESC_TYPE_ENDPOINT, // bDescriptorType: Endpoint
    CDC_IN_EP,              // bEndpointAddress
    0x02,                   // bmAttributes: Bulk
    LOBYTE(CDC_IN_EP_SIZE), // wMaxPacketSize:
    HIBYTE(CDC_IN_EP_SIZE), //
    0x00,                   // bInterval: ignore for Bulk transfer

    // Extra programmer descriptors

    // Interface descriptor
    0x09,                    // bLength: Interface Descriptor size
    USB_DESC_TYPE_INTERFACE, // bDescriptorType: Interface descriptor type
    0x02,                    // bInterfaceNumber: Number of Interface
    0x00,                    // bAlternateSetting: Alternate setting
    0x02,                    // bNumEndpoints
    0xFF,                    // bInterfaceClass
    0x00,                    // bInterfaceSubClass
    0x00,                    // nInterfaceProtocol
    0,                       // iInterface: Index of string descriptor
                             //
    0x07,                    // bLength: Endpoint Descriptor size
    USB_DESC_TYPE_ENDPOINT,  // bDescriptorType:
    CMD_EPIN_ADDR,           // bEndpointAddress: Endpoint Address (IN)
    0x02,                    // bmAttributes: Bulk endpoint
    LOBYTE(CMD_EPIN_SIZE),   // wMaxPacketSize
    HIBYTE(CMD_EPIN_SIZE),   //
    0x00,                    // bInterval
                             //
    0x07,                    // bLength: Endpoint Descriptor size
    USB_DESC_TYPE_ENDPOINT,  // bDescriptorType:
    CMD_EPOUT_ADDR,          // bEndpointAddress: Endpoint Address (OUT)
    0x02,                    // bmAttributes: Bulk endpoint
    LOBYTE(CMD_EPOUT_SIZE),  // wMaxPacketSize
    HIBYTE(CMD_EPOUT_SIZE),  //
    0x00,                    // bInterval
};

static uint8_t cdc_init(USBD_HandleTypeDef *pdev, uint8_t cfgidx) {
    USBD_LL_OpenEP(pdev, CDC_IN_EP, USBD_EP_TYPE_BULK, CDC_IN_EP_SIZE);
    USBD_LL_OpenEP(pdev, CDC_OUT_EP, USBD_EP_TYPE_BULK, CDC_OUT_EP_SIZE);
    USBD_LL_OpenEP(pdev, CDC_CMD_EP, USBD_EP_TYPE_INTR, CDC_CMD_EP_SIZE);

    pdev->pClassData = USBD_malloc(sizeof(struct cdc_handle));
    assert(pdev->pClassData != NULL);
    struct cdc_handle *hcdc = (struct cdc_handle *)pdev->pClassData;

    // Init physical Interface components
    struct cdc_interface *cdcif = (struct cdc_interface *)pdev->pUserData;
    cdcif->init();

    // Init Xfer states
    hcdc->tx_busy = false;

    // Prepare Out endpoint to receive next packet
    USBD_LL_PrepareReceive(pdev, CDC_OUT_EP, hcdc->rx_buffer, CDC_OUT_EP_SIZE);

    programmer_init(pdev, cfgidx);
    return 0;
}

static uint8_t cdc_deinit(USBD_HandleTypeDef *pdev, uint8_t cfgidx) {
    USBD_LL_CloseEP(pdev, CDC_IN_EP);
    USBD_LL_CloseEP(pdev, CDC_OUT_EP);
    USBD_LL_CloseEP(pdev, CDC_CMD_EP);

    // Deinit physical interface components
    struct cdc_interface *cdcif = (struct cdc_interface *)pdev->pUserData;
    cdcif->deinit();
    USBD_free(pdev->pClassData);
    pdev->pClassData = NULL;

    programmer_deinit(pdev, cfgidx);
    return 0;
}

static uint8_t cdc_setup(USBD_HandleTypeDef *pdev, USBD_SetupReqTypedef *req) {
    struct cdc_handle *   hcdc  = (struct cdc_handle *)pdev->pClassData;
    struct cdc_interface *cdcif = (struct cdc_interface *)pdev->pUserData;

    static uint8_t ifalt = 0;

    switch (req->bmRequest & USB_REQ_TYPE_MASK) {
        case USB_REQ_TYPE_CLASS:
            if (req->wLength) {
                if (req->bmRequest & 0x80) {
                    cdcif->control(req->bRequest, (uint8_t *)hcdc->ep0_data, req->wLength);
                    USBD_CtlSendData(pdev, (uint8_t *)hcdc->ep0_data, req->wLength);
                } else {
                    hcdc->cmd_opcode = req->bRequest;
                    hcdc->cmd_length = req->wLength;
                    USBD_CtlPrepareRx(pdev, (uint8_t *)hcdc->ep0_data, req->wLength);
                }

            } else {
                cdcif->control(req->bRequest, (uint8_t *)req, 0);
            }
            break;

        case USB_REQ_TYPE_STANDARD:
            switch (req->bRequest) {
                case USB_REQ_GET_INTERFACE:
                    USBD_CtlSendData(pdev, &ifalt, 1);
                    break;

                case USB_REQ_SET_INTERFACE:
                    break;
            }

        default:
            break;
    }
    return USBD_OK;
}

static uint8_t cdc_data_in(USBD_HandleTypeDef *pdev, uint8_t epnum) {
    epnum &= 0xF;

    // printf("cdc_data_in %02x\n", epnum);

    if (epnum == (CDC_IN_EP & 0xF)) {
        struct cdc_handle *hcdc = (struct cdc_handle *)pdev->pClassData;
        hcdc->tx_busy           = false;

        struct cdc_interface *cdcif = (struct cdc_interface *)pdev->pUserData;
        cdcif->transmit_done();

    } else {
        return programmer_data_in(pdev, epnum);
    }
    return USBD_OK;
}

static uint8_t cdc_data_out(USBD_HandleTypeDef *pdev, uint8_t epnum) {
    struct cdc_interface *cdcif = (struct cdc_interface *)pdev->pUserData;

    epnum &= 0xF;

    // printf("cdc_data_out %02x\n", epnum);

    if (epnum == (CDC_IN_EP & 0xF)) {
        struct cdc_handle *hcdc = (struct cdc_handle *)pdev->pClassData;

        // Get the received data length
        uint32_t rx_length = USBD_LL_GetRxDataSize(pdev, epnum);
        cdcif->receive(hcdc->rx_buffer, rx_length);
    } else {
        return programmer_data_out(pdev, epnum);
    }
    return USBD_OK;
}

static uint8_t cdc_ep0_rx_ready(USBD_HandleTypeDef *pdev) {
    struct cdc_handle *   hcdc  = (struct cdc_handle *)pdev->pClassData;
    struct cdc_interface *cdcif = (struct cdc_interface *)pdev->pUserData;

    if (hcdc->cmd_opcode != 0xFF) {
        cdcif->control(hcdc->cmd_opcode, (uint8_t *)hcdc->ep0_data, hcdc->cmd_length);
        hcdc->cmd_opcode = 0xFF;
    }
    return USBD_OK;
}

static const uint8_t *cdc_get_cfg_desc(uint16_t *length) {
    *length = sizeof(cdc_config_desc);
    return cdc_config_desc;
}

void cdc_register_interface(USBD_HandleTypeDef *pdev, const struct cdc_interface *fops) {
    pdev->pUserData = (void *)fops;
}

bool cdc_transmit_packet(USBD_HandleTypeDef *pdev, uint8_t *buf, uint16_t length) {
    struct cdc_handle *hcdc = (struct cdc_handle *)pdev->pClassData;
    if (hcdc->tx_busy) {
        return false;
    }

    hcdc->tx_busy = true;
    USBD_LL_Transmit(pdev, CDC_IN_EP, buf, length);
    return true;
}

void cdc_receive_packet(USBD_HandleTypeDef *pdev) {
    struct cdc_handle *hcdc = (struct cdc_handle *)pdev->pClassData;

    // Prepare OUT endpoint to receive next packet
    USBD_LL_PrepareReceive(pdev, CDC_OUT_EP, hcdc->rx_buffer, sizeof(hcdc->rx_buffer));
}

// CDC interface class callbacks structure
const USBD_ClassTypeDef USBD_CDC = {
    .Init                          = cdc_init,
    .DeInit                        = cdc_deinit,
    .Setup                         = cdc_setup,
    .EP0_TxSent                    = NULL,
    .EP0_RxReady                   = cdc_ep0_rx_ready,
    .DataIn                        = cdc_data_in,
    .DataOut                       = cdc_data_out,
    .SOF                           = NULL,
    .IsoINIncomplete               = NULL,
    .IsoOUTIncomplete              = NULL,
    .GetHSConfigDescriptor         = cdc_get_cfg_desc,
    .GetFSConfigDescriptor         = cdc_get_cfg_desc,
    .GetOtherSpeedConfigDescriptor = cdc_get_cfg_desc,
    .GetDeviceQualifierDescriptor  = NULL,
};
