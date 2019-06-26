/**
 * @file
 */

/** @ingroup lib
 * @{ */

#pragma once

#include <stdarg.h>
#include <stddef.h>

#ifdef MODULE_NAME
#    define MODULE_NAME_STR "[" MODULE_NAME "] "
#else
#    define MODULE_NAME_STR ""
#endif

#ifndef MODULE_TYPE
#    define MODULE_TYPE ""
#endif

// clang-format off
#define ANSI_ERROR  ANSI_BG_RED ANSI_WHITE

#define MODULE_TYPE_DRIVER  ANSI_GREEN
#define MODULE_TYPE_OS      ANSI_YELLOW
#define MODULE_TYPE_RADIO   ANSI_MAGENTA
#define MODULE_TYPE_NETWORK ANSI_CYAN
#define MODULE_TYPE_GAPP    ANSI_BOLD ANSI_BLUE

#define DBGF(...) printf(MODULE_TYPE MODULE_NAME_STR __VA_ARGS__)
#define DBGF2(...) printf(__VA_ARGS__)

#define ANSI_RESET            "\033[0m"
#define ANSI_BOLD             "\033[1m"

#define ANSI_CURSOR_HOME      "\033[H"
#define ANSI_CLEAR_SCREEN     "\033[2J"
#define ANSI_CLEAR_SCROLLBACK "\033[3J"

#define ANSI_BLACK            "\033[30m"
#define ANSI_RED              "\033[31m"
#define ANSI_GREEN            "\033[32m"
#define ANSI_YELLOW           "\033[33m"
#define ANSI_BLUE             "\033[34m"
#define ANSI_MAGENTA          "\033[35m"
#define ANSI_CYAN             "\033[36m"
#define ANSI_WHITE            "\033[37m"

#define ANSI_BG_BLACK         "\033[40m"
#define ANSI_BG_RED           "\033[41m"
#define ANSI_BG_GREEN         "\033[42m"
#define ANSI_BG_YELLOW        "\033[43m"
#define ANSI_BG_BLUE          "\033[44m"
#define ANSI_BG_MAGENTA       "\033[45m"
#define ANSI_BG_CYAN          "\033[46m"
#define ANSI_BG_WHITE         "\033[47m"
// clang-format on

/**
 * @brief      Clear RTT debug output screen
 */
void clear_screen(void);

/**
 * @brief      Print formatted string to RTT debug output
 *
 * @param      format     Format string
 * @param      ...        Arguments to be formatted
 *
 * @return     Number of characters produced
 */
int printf(const char *format, ...) __attribute__((format(printf, 1, 2)));

/**
 * @brief      Print formatted string to RTT debug output
 *
 * @param      format  Format string
 * @param      ap      Variable arguments list containing arguments to format
 *
 * @return     Number of characters produced
 */
int vprintf(const char *format, va_list ap);

/**
 * @brief      Generic handler of printf style strings. Will call callback handler for produced characters.
 *
 * @param      char_out  Callback handler called for each produced character
 * @param      context   User defined pointer passed to callback handler
 * @param      format    Printf format string
 * @param      ap        Variable arguments list containing arguments to format
 *
 * @return     Number of characters produced
 */
int printf_handler(void (*char_out)(void *, char), void *context, const char *format, va_list ap);

/**
 * @brief      Read data from host (non-blocking)
 *
 * @param      buf     Pointer to buffer to store data
 * @param      length  Maximum bytes to read
 *
 * @return     Bytes read (0 if no bytes available)
 */
size_t rtt_read(void *buf, size_t length);

/** @} */
