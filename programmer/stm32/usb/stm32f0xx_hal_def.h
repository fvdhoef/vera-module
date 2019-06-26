#pragma once

typedef enum {
    HAL_OK      = 0x00U,
    HAL_ERROR   = 0x01U,
    HAL_BUSY    = 0x02U,
    HAL_TIMEOUT = 0x03U
} HAL_StatusTypeDef;

typedef enum {
    HAL_UNLOCKED = 0x00U,
    HAL_LOCKED   = 0x01U
} HAL_LockTypeDef;

#define __HAL_LOCK(__HANDLE__)                  \
    do {                                        \
        if ((__HANDLE__)->Lock == HAL_LOCKED) { \
            return HAL_BUSY;                    \
        } else {                                \
            (__HANDLE__)->Lock = HAL_LOCKED;    \
        }                                       \
    } while (0)

#define __HAL_UNLOCK(__HANDLE__)           \
    do {                                   \
        (__HANDLE__)->Lock = HAL_UNLOCKED; \
    } while (0)

#ifndef __weak
#    define __weak __attribute__((weak))
#endif /* __weak */

#define UNUSED(x) ((void)(x))
