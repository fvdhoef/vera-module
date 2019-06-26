#pragma once

#include "common.h"

/* Common Config */
#define USBD_MAX_NUM_INTERFACES 3
#define USBD_MAX_NUM_CONFIGURATION 1
#define USBD_MAX_STR_DESC_SIZ 128
#define USBD_SUPPORT_USER_STRING 0
#define USBD_SELF_POWERED 0

#define USBD_ErrLog(...)

#define MSC_MEDIA_PACKET 2048

#define MAX_STATIC_ALLOC_SIZE 2560

void *USBD_static_malloc(uint32_t size);
void  USBD_static_free(void *p);

#define USBD_malloc (uint32_t *)USBD_static_malloc
#define USBD_free USBD_static_free
