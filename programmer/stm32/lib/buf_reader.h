/**
 * @file
 */

/**
 * @defgroup   bufreader Buffer reader
 * @brief      Safely read from (packed) data buffers.
 * @ingroup    lib
 * @{
 */

#pragma once

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

/**
 * @brief      Buffer reader control structure
 */
struct buf_reader {
    const uint8_t *buf;  ///< Pointer to buffer
    size_t         size; ///< Size of buffer
    const uint8_t *p;    ///< Current location in buffer
};

/**
 * @brief      Initialize buffer reader structure
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      buf   Pointer to buffer
 * @param      size  Size of buffer
 */
static inline void buf_reader_init(struct buf_reader *br, const void *buf, size_t size) {
    br->buf  = (const uint8_t *)buf;
    br->size = size;
    br->p    = br->buf;
}

/**
 * @brief      Try to read specified amount of bytes from buffer reader
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      dst   Pointer to destination buffer
 * @param      size  Amount of bytes to read
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_reader_try_get_bytes(struct buf_reader *br, void *dst, size_t size) {
    if (br->p - br->buf + size <= br->size) {
        memcpy(dst, br->p, size);
        br->p += size;
        return true;
    } else {
        return false;
    }
}

/**
 * @brief      Try to skip specified amount of bytes
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      size  Amount of bytes to skip
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_skip_bytes(struct buf_reader *br, size_t size) {
    if (br->p - br->buf + size <= br->size) {
        br->p += size;
        return true;
    } else {
        return false;
    }
}

/**
 * @brief      Seek to specified offset.
 *
 * @param      br      Pointer to struct buf_reader structure
 * @param      offset  The offset
 */
static inline bool buf_reader_try_seek(struct buf_reader *br, size_t offset) {
    if (offset > br->size) {
        return false;
    }
    br->p = (const uint8_t *)((uintptr_t)br->buf + offset);
    return true;
}

/**
 * @brief      Read specified amount of bytes from buffer reader. Assert on
 *             failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      dst   Pointer to destination buffer
 * @param      size  Amount of bytes to read
 */
static inline void buf_reader_get_bytes(struct buf_reader *br, void *dst, size_t size) {
    bool ok = buf_reader_try_get_bytes(br, dst, size);
    (void)ok;
    assert(ok);
}

/**
 * @brief      Seek to specified offset. Assert on failure.
 *
 * @param      br      Pointer to struct buf_reader structure
 * @param      offset  The offset
 */
static inline void buf_reader_seek(struct buf_reader *br, size_t offset) {
    bool ok = buf_reader_try_seek(br, offset);
    (void)ok;
    assert(ok);
}

/**
 * @brief      Skip specified amount of bytes. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      size  The size
 */
static inline void buf_reader_skip_bytes(struct buf_reader *br, size_t size) {
    bool ok = buf_reader_try_skip_bytes(br, size);
    (void)ok;
    assert(ok);
}

/**
 * @brief      Get pointer to buffer managed by buffer reader.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Pointer to buffer
 */
static inline const void *buf_reader_get_data(struct buf_reader *br) {
    return br->buf;
}

/**
 * @brief      Get pointer to current offset.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Pointer to current offset in buffer
 */
static inline const void *buf_reader_get_current(struct buf_reader *br) {
    return br->p;
}

/**
 * @brief      Get current offset.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Current offset in buffer.
 */
static inline size_t buf_reader_get_offset(struct buf_reader *br) {
    return br->p - br->buf;
}

/**
 * @brief      Get remaining bytes in buffer
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Remaining bytes in buffer
 */
static inline size_t buf_reader_get_remaining(struct buf_reader *br) {
    return br->size - buf_reader_get_offset(br);
}

/**
 * @brief      Get buffer size
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Size of buffer managed by buffer reader
 */
static inline size_t buf_reader_get_buffer_size(struct buf_reader *br) {
    return br->size;
}

/**
 * @brief      Set offset back to 0
 *
 * @param      br    Pointer to struct buf_reader structure
 */
static inline void buf_reader_rewind(struct buf_reader *br) {
    br->p = br->buf;
}

/**
 * @brief      Re-init buffer reader at current offset and current remaining
 *             bytes
 *
 * @param      br    Pointer to struct buf_reader structure
 */
static inline void buf_reader_reinit(struct buf_reader *br) {
    br->size = buf_reader_get_remaining(br);
    br->buf  = br->p;
}

/**
 * @brief      Read 8-bit unsigned value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline uint8_t buf_reader_get_u8(struct buf_reader *br) {
    uint8_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 16-bit unsigned value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline uint16_t buf_reader_get_u16(struct buf_reader *br) {
    uint16_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 32-bit unsigned value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline uint32_t buf_reader_get_u32(struct buf_reader *br) {
    uint32_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 48-bit unsigned value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline uint64_t buf_reader_get_u48(struct buf_reader *br) {
    uint64_t val = 0;
    buf_reader_get_bytes(br, &val, 6);
    return val;
}

/**
 * @brief      Read 64-bit unsigned value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline uint64_t buf_reader_get_u64(struct buf_reader *br) {
    uint64_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 8-bit signed value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline int8_t buf_reader_get_s8(struct buf_reader *br) {
    int8_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 16-bit signed value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline int16_t buf_reader_get_s16(struct buf_reader *br) {
    int16_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 32-bit signed value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline int32_t buf_reader_get_s32(struct buf_reader *br) {
    int32_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 64-bit signed value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline int64_t buf_reader_get_s64(struct buf_reader *br) {
    int64_t val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 32-bit floating point value from buffer. Assert on failure.
 *
 * @param      br    Pointer to struct buf_reader structure
 *
 * @return     Resulting value
 */
static inline float buf_reader_get_f32(struct buf_reader *br) {
    float val;
    buf_reader_get_bytes(br, &val, sizeof(val));
    return val;
}

/**
 * @brief      Read 8-bit unsigned value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_u8(struct buf_reader *br, uint8_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 16-bit unsigned value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_u16(struct buf_reader *br, uint16_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 32-bit unsigned value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_u32(struct buf_reader *br, uint32_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 48-bit unsigned value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_u48(struct buf_reader *br, uint64_t *val) {
    *val = 0;
    return buf_reader_try_get_bytes(br, val, 6);
}

/**
 * @brief      Read 64-bit unsigned value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_u64(struct buf_reader *br, uint64_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 8-bit signed value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_s8(struct buf_reader *br, int8_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 16-bit signed value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_s16(struct buf_reader *br, int16_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 32-bit signed value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_s32(struct buf_reader *br, int32_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 64-bit signed value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_s64(struct buf_reader *br, int64_t *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/**
 * @brief      Read 32-bit floating point value from buffer.
 *
 * @param      br    Pointer to struct buf_reader structure
 * @param      val   Pointer to buffer receiving value
 *
 * @return     true on success, false if not enough bytes available in buffer
 *             reader
 */
static inline bool buf_reader_try_get_f32(struct buf_reader *br, float *val) {
    return buf_reader_try_get_bytes(br, val, sizeof(*val));
}

/** @} */
