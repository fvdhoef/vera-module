#include "rtt.h"
#include <stdint.h>
#include "lib.h"

enum {
    FLAG_ZERO_PADDING   = (1 << 0),
    FLAG_LEFT_JUSTIFIED = (1 << 1),
    FLAG_LONG_INT       = (1 << 2),
    FLAG_LONG_LONG_INT  = (1 << 3),
    FLAG_NEGATIVE       = (1 << 4),
};

static inline bool isdigit(char c) {
    return c >= '0' && c <= '9';
}

static inline char tolower(char c) {
    if (c >= 'A' && c <= 'Z') {
        return c - 'A' + 'a';
    } else {
        return c;
    }
}

static int string_out(const char *str, void (*char_out)(void *, char), void *context, int flags, int field_width) {
    int outlen = 0;

    int str_length = 0;
    while (str[str_length] != '\0') {
        str_length++;
    }

    if (!(flags & FLAG_LEFT_JUSTIFIED)) {
        while (str_length++ < field_width) {
            char_out(context, ' ');
            outlen++;
        }
    }

    while (*str != '\0') {
        char_out(context, *(str++));
        outlen++;
    }

    while (str_length++ < field_width) {
        char_out(context, ' ');
        outlen++;
    }
    return outlen;
}

int printf_handler(void (*char_out)(void *, char), void *context, const char *format, va_list ap) {
    int outlen = 0;

    while (1) {
        char c = *(format++);
        if (c == '\0') {
            // End of string
            break;
        }

        if (c != '%') {
            // Non escape character
            char_out(context, c);
            outlen++;
            continue;
        }

        int flags       = 0;
        int field_width = 0;

        c = *(format++);

        if (c == '0') {
            // Flag: '0' padding
            flags = FLAG_ZERO_PADDING;
            c     = *(format++);
        } else if (c == '-') {
            // Flag: left justified
            flags = FLAG_LEFT_JUSTIFIED;
            c     = *(format++);
        }

        while (isdigit(c)) {
            // Field width
            field_width = field_width * 10 + c - '0';
            c           = *(format++);
        }

        if (c == 'l' || c == 'L') {
            // Prefix: Size is long int
            flags |= FLAG_LONG_INT;
            c = *(format++);

            if (c == 'l' || c == 'L') {
                flags &= ~FLAG_LONG_INT;
                flags |= FLAG_LONG_LONG_INT;
                c = *(format++);
            }
        } else if (c == 'z') {
            // Prefix: size_t
            c = *(format++);
        }

        if (c == '\0') {
            // End of string
            break;
        }

        char conv_specifier = tolower(c);
        int  radix;

        switch (conv_specifier) {
            case 'c': {
                // Character
                char char_buf[2];
                char_buf[0] = (char)va_arg(ap, int);
                char_buf[1] = '\0';
                outlen += string_out(char_buf, char_out, context, flags, field_width);
                continue;
            }

            case 's': {
                // String
                const char *str = va_arg(ap, const char *);
                if (str) {
                    outlen += string_out(str, char_out, context, flags, field_width);
                } else {
                    outlen += string_out("(null)", char_out, context, flags, field_width);
                }
                continue;
            }

            case 'o':
                radix = 8;
                break; // Octal
            case 'd':
                radix = 10;
                break; // Signed decimal
            case 'u':
                radix = 10;
                break; // Unsigned decimal
            case 'x':
                radix = 16;
                break; // Hexadecimal

            case 'p': {
                char_out(context, '0');
                char_out(context, 'x');
                outlen += 2;
                flags       = FLAG_ZERO_PADDING;
                field_width = 8;

                radix = 16;
                break;
            }

            default: {
                // Unknown type (pass-through)
                char_out(context, c);
                outlen++;
                continue;
            }
        }

        // Get an argument and put it in numeral
        uint64_t value;
        if (flags & FLAG_LONG_INT) {
            if (conv_specifier == 'd') {
                long val = va_arg(ap, long);
                if (val < 0) {
                    val = -val;
                    flags |= FLAG_NEGATIVE;
                }
                value = val;
            } else {
                value = va_arg(ap, unsigned long);
            }

        } else if (flags & FLAG_LONG_LONG_INT) {
            if (conv_specifier == 'd') {
                long long val = va_arg(ap, long long);
                if (val < 0) {
                    val = -val;
                    flags |= FLAG_NEGATIVE;
                }
                value = val;
            } else {
                value = va_arg(ap, unsigned long long);
            }

        } else {
            if (conv_specifier == 'd') {
                int val = va_arg(ap, int);
                if (val < 0) {
                    val = -val;
                    flags |= FLAG_NEGATIVE;
                }
                value = val;
            } else {
                value = va_arg(ap, unsigned int);
            }
        }

        int  i = 0;
        char str[32];
        do {
            char digit = (char)(value % radix);
            value /= radix;
            if (digit > 9) {
                digit = (digit - 10) + (c == 'x' ? 'a' : 'A');
            } else {
                digit += '0';
            }
            str[i++] = digit;
        } while (value != 0);

        if (flags & FLAG_NEGATIVE) {
            str[i++] = '-';
        }

        int  j       = i;
        char padChar = (flags & FLAG_ZERO_PADDING) ? '0' : ' ';

        if ((flags & FLAG_LEFT_JUSTIFIED) == 0) {
            while (j++ < field_width) {
                char_out(context, padChar);
                outlen++;
            }
        }

        do {
            char_out(context, str[--i]);
            outlen++;
        } while (i);

        while (j++ < field_width) {
            char_out(context, ' ');
            outlen++;
        }
    }
    return outlen;
}

int printf(const char *format, ...) {
    static volatile bool busy = false;
    if (busy) {
        // Don't allow nested printfs
        return 0;
    }
    busy = true;

    va_list ap;
    va_start(ap, format);
    int result = vprintf(format, ap);
    va_end(ap);

    busy = false;
    return result;
}

#ifndef DOXYGEN_SKIP

// Description for a circular buffer (also called "ring buffer") which is used as up-buffer (T->H)
struct segger_rtt_buffer_up {
    const char *      name;         // Optional name. Standard names so far are: "Terminal", "SysView", "J-Scope_t4i4"
    char *            buffer;       // Pointer to start of buffer
    unsigned          buffer_size;  // Buffer size in bytes. Note that one byte is lost, as this implementation does not fill up the buffer in order to avoid the problem of being unable to distinguish between full and empty.
    unsigned          write_offset; // Position of next item to be written by either target.
    volatile unsigned read_offset;  // Position of next item to be read by host. Must be volatile since it may be modified by host.
    unsigned          flags;        // Contains configuration flags
};

// Description for a circular buffer (also called "ring buffer") which is used as down-buffer (H->T)
struct segger_rtt_buffer_down {
    const char *      name;         // Optional name. Standard names so far are: "Terminal", "SysView", "J-Scope_t4i4"
    char *            buffer;       // Pointer to start of buffer
    unsigned          buffer_size;  // Buffer size in bytes. Note that one byte is lost, as this implementation does not fill up the buffer in order to avoid the problem of being unable to distinguish between full and empty.
    volatile unsigned write_offset; // Position of next item to be written by host. Must be volatile since it may be modified by host.
    unsigned          read_offset;  // Position of next item to be read by target (down-buffer).
    unsigned          flags;        // Contains configuration flags
};

// RTT control block which describes the number of buffers available as well as the configuration for each buffer
struct segger_rtt_cb {
    char                          id[16];           // Initialized to "SEGGER RTT"
    int                           max_up_buffers;   // Initialized to SEGGER_RTT_NUM_UP_BUFFERS (type. 2)
    int                           max_down_buffers; // Initialized to SEGGER_RTT_NUM_DOWN_BUFFERS (type. 2)
    struct segger_rtt_buffer_up   up;               // Up buffer, transferring information up from target via debug probe to host
    struct segger_rtt_buffer_down down;             // Down buffer, transferring information down from host via debug probe to target
};

static struct segger_rtt_cb segger_rtt; // Initialized by bootcode to zero

#    ifndef RTT_BUFFER_SIZE
#        define RTT_BUFFER_SIZE 1024
#    endif

static char rtt_up_buffer[RTT_BUFFER_SIZE];
static char rtt_down_buffer[4];

static void rtt_init(void) {
    if (segger_rtt.id[0] == 0) {
        // memset(&segger_rtt, 0, sizeof(segger_rtt));
        segger_rtt.max_up_buffers   = 1;
        segger_rtt.max_down_buffers = 1;
        segger_rtt.up.buffer        = rtt_up_buffer;
        segger_rtt.up.buffer_size   = sizeof(rtt_up_buffer);
        segger_rtt.down.buffer      = rtt_down_buffer;
        segger_rtt.down.buffer_size = sizeof(rtt_down_buffer);

        segger_rtt.id[0] = 'S';
        segger_rtt.id[1] = 'E';
        segger_rtt.id[2] = 'G';
        segger_rtt.id[3] = 'G';
        segger_rtt.id[4] = 'E';
        segger_rtt.id[5] = 'R';
        segger_rtt.id[6] = ' ';
        segger_rtt.id[7] = 'R';
        segger_rtt.id[8] = 'T';
        segger_rtt.id[9] = 'T';
    }
}

static void rtt_write_bytes(const void *buf, size_t size) {
    const uint8_t *p = buf;

    // Determine free space in ring buffer
    unsigned read_offset  = segger_rtt.up.read_offset;
    unsigned write_offset = segger_rtt.up.write_offset;
    {
        unsigned buf_remaining;
        if (read_offset <= write_offset) {
            buf_remaining = segger_rtt.up.buffer_size - 1u - write_offset + read_offset;
        } else {
            buf_remaining = read_offset - write_offset - 1u;
        }

        if (size > buf_remaining) {
            size = buf_remaining;
        }
    }

    unsigned remaining = segger_rtt.up.buffer_size - write_offset;
    if (size <= remaining) {
        // All data fits before wrap around
        memcpy(segger_rtt.up.buffer + write_offset, p, size);
        segger_rtt.up.write_offset = write_offset + size;
    } else {
        // We reach the end of the buffer, so need to wrap around
        memcpy(segger_rtt.up.buffer + write_offset, p, remaining);
        unsigned bytes_to_copy = size - remaining;
        memcpy(segger_rtt.up.buffer, p + remaining, bytes_to_copy);
        segger_rtt.up.write_offset = bytes_to_copy;
    }
}

size_t rtt_read(void *buf, size_t length) {
    rtt_init();

    uint8_t *buffer       = buf;
    unsigned read_offset  = segger_rtt.down.read_offset;
    unsigned write_offset = segger_rtt.down.write_offset;
    unsigned remaining    = 0;
    unsigned bytes_read   = 0;

    // Read from current read position to wrap-around of buffer, first
    if (read_offset > write_offset) {
        remaining = segger_rtt.down.buffer_size - read_offset;
        if (remaining > length) {
            remaining = length;
        }
        memcpy(buffer, segger_rtt.down.buffer + read_offset, remaining);
        bytes_read += remaining;
        buffer += remaining;
        length -= remaining;
        read_offset += remaining;

        // Handle wrap-around of buffer
        if (read_offset == segger_rtt.down.buffer_size) {
            read_offset = 0;
        }
    }

    // Read remaining items of buffer
    remaining = write_offset - read_offset;
    if (remaining > length) {
        remaining = length;
    }
    if (remaining > 0) {
        memcpy(buffer, segger_rtt.down.buffer + read_offset, remaining);
        bytes_read += remaining;
        buffer += remaining;
        length -= remaining;
        read_offset += remaining;
    }
    if (bytes_read) {
        segger_rtt.down.read_offset = read_offset;
    }
    return bytes_read;
}

static char     tmpbuf[64];
static unsigned tmpbuf_cnt  = 0;
static bool     is_new_line = true;
static char     current_time_str[32];

static const char *get_current_time_str(void) {
    os_time_t time = os_get_time();

    time /= 10;
    unsigned frac = time % 1000;
    time /= 1000;

    char *p = &current_time_str[sizeof(current_time_str)];
    *(--p)  = '\0';

    for (int i = 0; i < 3; i++) {
        *(--p) = '0' + (frac % 10);
        frac /= 10;
    }
    *(--p) = '.';
    do {
        *(--p) = '0' + (time % 10);
        time /= 10;
    } while (time > 0);

    while (p > &current_time_str[sizeof(current_time_str) - 1 - 8]) {
        *(--p) = ' ';
    }
    return p;
}

static void output_tmpbuf(void) {
    if (tmpbuf_cnt == 0) {
        return;
    }
    rtt_write_bytes(tmpbuf, tmpbuf_cnt);
    tmpbuf_cnt = 0;
}

static void printf_char_itm(void *context, char c) {
    (void)context;

    if (is_new_line) {
        output_tmpbuf();

        tmpbuf[tmpbuf_cnt++] = '\033';
        tmpbuf[tmpbuf_cnt++] = '[';
        tmpbuf[tmpbuf_cnt++] = '0';
        tmpbuf[tmpbuf_cnt++] = 'm';

        tmpbuf[tmpbuf_cnt++] = '[';
        const char *p        = get_current_time_str();
        while (*p != 0) {
            tmpbuf[tmpbuf_cnt++] = *(p++);
        }
        tmpbuf[tmpbuf_cnt++] = ']';

        tmpbuf[tmpbuf_cnt++] = ' ';

        is_new_line = false;
    }

    tmpbuf[tmpbuf_cnt++] = c;
    if (c == '\n') {
        is_new_line = true;
    }

    if (tmpbuf_cnt == sizeof(tmpbuf)) {
        output_tmpbuf();
    }
}

#endif

int vprintf(const char *format, va_list ap) {
    rtt_init();

    int result = printf_handler(printf_char_itm, NULL, format, ap);
    if (tmpbuf_cnt > 0) {
        output_tmpbuf();
    }
    return result;
}

void clear_screen(void) {
    rtt_init();
    const char *clrscr = ANSI_RESET ANSI_CURSOR_HOME ANSI_CLEAR_SCREEN ANSI_CLEAR_SCROLLBACK;
    rtt_write_bytes(clrscr, strlen(clrscr));
    is_new_line = true;
    tmpbuf_cnt  = 0;
}
