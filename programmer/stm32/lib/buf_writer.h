/**
 * @file
 */

/**
 * @defgroup   bufwriter Buffer writer
 * @brief      Safely write to (packed) data buffers.
 * @ingroup    lib
 * @{
 */

#pragma once

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

/**
 * @brief      Buffer writer control structure
 */
struct buf_writer {
    uint8_t *buf;  ///< Pointer to buffer
    size_t   size; ///< Size of buffer
    uint8_t *p;    ///< Current location in buffer
};

/**
 * @brief      Initialize buffer writer structure
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      buf   Pointer to buffer
 * @param      size  Size of buffer
 */
static inline void buf_writer_init(struct buf_writer *bw, void *buf, size_t size) {
    bw->buf  = (uint8_t *)buf;
    bw->size = size;
    bw->p    = bw->buf;
}

/**
 * @brief      Reset write pointer back to start of buffer
 *
 * @param      bw    Pointer to struct buf_writer structure
 */
static inline void buf_writer_rewind(struct buf_writer *bw) {
    bw->p = (uint8_t *)bw->buf;
}

/**
 * @brief      Try to write specified amount of bytes to buffer
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      src   Pointer to source buffer
 * @param      size  Amount of bytes to write
 *
 * @return     true on success, false if not enough free bytes available in
 *             buffer
 */
static inline bool buf_writer_try_add_bytes(struct buf_writer *bw, const void *src, size_t size) {
    if (bw->p - bw->buf + size <= bw->size) {
        memcpy(bw->p, src, size);
        bw->p += size;
        return true;
    } else {
        return false;
    }
}

/**
 * @brief      Try to move write pointer up by specified amount of bytes. Should
 *             be called after manually adding bytes to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      size  Amount of bytes to move write pointer
 *
 * @return     true on success, false if not enough free bytes available in
 *             buffer
 */
static inline bool buf_writer_try_added_bytes(struct buf_writer *bw, size_t size) {
    if (bw->p - bw->buf + size <= bw->size) {
        bw->p += size;
        return true;
    } else {
        return false;
    }
}

/**
 * @brief      Write specified amount of bytes to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      src   Pointer to source buffer
 * @param      size  Amount of bytes to write
 */
static inline void buf_writer_add_bytes(struct buf_writer *bw, const void *src, size_t size) {
    bool ok = buf_writer_try_add_bytes(bw, src, size);
    (void)ok;
    assert(ok);
}

/**
 * @brief      Move write pointer up by specified amount of bytes. Assert on
 *             failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      size  Amount of bytes to move write pointer
 */
static inline void buf_writer_added_bytes(struct buf_writer *bw, size_t size) {
    bool ok = buf_writer_try_added_bytes(bw, size);
    (void)ok;
    assert(ok);
}

/**
 * @brief      Get pointer to start of buffer
 *
 * @param      bw    Pointer to struct buf_writer structure
 *
 * @return     Pointer to start of buffer
 */
static inline void *buf_writer_get_data(struct buf_writer *bw) {
    return bw->buf;
}

/**
 * @brief      Get pointer to current position in buffer
 *
 * @param      bw    Pointer to struct buf_writer structure
 *
 * @return     Pointer to current position in buffer
 */
static inline void *buf_writer_get_current(struct buf_writer *bw) {
    return bw->p;
}

/**
 * @brief      Get current offset in buffer
 *
 * @param      bw    Pointer to struct buf_writer structure
 *
 * @return     Current offset in buffer
 */
static inline size_t buf_writer_get_offset(struct buf_writer *bw) {
    return bw->p - bw->buf;
}

/**
 * @brief      Set offset in buffer. Asserts on failure.
 *
 * @param      bw      Pointer to struct buf_writer structure
 * @param      offset  New offset
 */
static inline void buf_writer_set_offset(struct buf_writer *bw, size_t offset) {
    assert(offset <= bw->size);
    bw->p = bw->buf + offset;
}

/**
 * @brief      Get remaining bytes available in buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 *
 * @return     Remaining bytes available in buffer
 */
static inline size_t buf_writer_get_remaining(struct buf_writer *bw) {
    return bw->size - buf_writer_get_offset(bw);
}

/**
 * @brief      Set new buffer size. Asserts on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      size  New buffer size.
 */
static inline void buf_writer_set_buffer_size(struct buf_writer *bw, size_t size) {
    assert(size >= buf_writer_get_offset(bw));
    bw->size = size;
}

/**
 * @brief      Write 8-bit unsigned value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_u8(struct buf_writer *bw, uint8_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 16-bit unsigned value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_u16(struct buf_writer *bw, uint16_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 32-bit unsigned value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_u32(struct buf_writer *bw, uint32_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 48-bit unsigned value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_u48(struct buf_writer *bw, uint64_t val) {
    buf_writer_add_bytes(bw, &val, 6);
}

/**
 * @brief      Write 64-bit unsigned value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_u64(struct buf_writer *bw, uint64_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 8-bit signed value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_s8(struct buf_writer *bw, int8_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 16-bit signed value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_s16(struct buf_writer *bw, int16_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 32-bit signed value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_s32(struct buf_writer *bw, int32_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 64-bit signed value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_s64(struct buf_writer *bw, int64_t val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 32-bit floating point value to buffer. Assert on failure.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 */
static inline void buf_writer_add_f32(struct buf_writer *bw, float val) {
    buf_writer_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 8-bit unsigned value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_u8(struct buf_writer *bw, uint8_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 16-bit unsigned value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_u16(struct buf_writer *bw, uint16_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 32-bit unsigned value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_u32(struct buf_writer *bw, uint32_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 48-bit unsigned value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_u48(struct buf_writer *bw, uint64_t val) {
    return buf_writer_try_add_bytes(bw, &val, 6);
}

/**
 * @brief      Write 64-bit unsigned value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_u64(struct buf_writer *bw, uint64_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 8-bit signed value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_s8(struct buf_writer *bw, int8_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 16-bit signed value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_s16(struct buf_writer *bw, int16_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 32-bit signed value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_s32(struct buf_writer *bw, int32_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 64-bit signed value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_s64(struct buf_writer *bw, int64_t val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/**
 * @brief      Write 32-bit floating point value to buffer.
 *
 * @param      bw    Pointer to struct buf_writer structure
 * @param      val   Value to write
 *
 * @return     true on success, false if not enough bytes available in buffer
 */
static inline bool buf_writer_try_add_f32(struct buf_writer *bw, float val) {
    return buf_writer_try_add_bytes(bw, &val, sizeof(val));
}

/** @} */
