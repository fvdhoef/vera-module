#pragma once

#include "common.h"

#define IO_BANK(x) ((x) << 4)
#define IO_INVERT (1 << 8)

enum iobank {
    IOBANK_A = 0,
    IOBANK_B = 1,
    IOBANK_C = 2,
    IOBANK_D = 3,
    IOBANK_F = 5,
};

enum iospeed {
    IOSPEED_LOW    = 0, // max   2MHz (125ns rise/fall time)
    IOSPEED_MEDIUM = 1, // max  10MHz ( 25ns rise/fall time)
    IOSPEED_FAST   = 3  // max  50MHz (  5ns rise/fall time)
};

enum iomode {
    IOMODE_IN     = 0,
    IOMODE_OUT    = 1,
    IOMODE_ALT    = 2,
    IOMODE_ANALOG = 3
};

enum iopull {
    IOPULL_NONE = 0,
    IOPULL_UP   = 1,
    IOPULL_DOWN = 2
};

static inline GPIO_TypeDef *io_get_gpio_regs(uint32_t io) {
    return (GPIO_TypeDef *)(GPIOA_BASE + (((io >> 4) & 0xF) * 0x400));
}

static inline void io_set_mode(uint32_t io, enum iomode mode) {
    GPIO_TypeDef *gpio  = io_get_gpio_regs(io);
    int           shift = (io & 15) * 2;

    gpio->MODER =
        (gpio->MODER & ~(3 << shift)) |
        (mode & 3) << shift;
}

static inline enum iomode io_get_mode(uint32_t io) {
    GPIO_TypeDef *gpio  = io_get_gpio_regs(io);
    int           shift = (io & 15) * 2;
    return (enum iomode)((gpio->MODER >> shift) & 3);
}

static inline void io_set_opendrain(uint32_t io, bool val) {
    GPIO_TypeDef *gpio  = io_get_gpio_regs(io);
    int           shift = (io & 15);

    gpio->OTYPER = (uint16_t)(
        (gpio->OTYPER & ~(1 << shift)) |
        ((val ? 1 : 0) << shift));
}

static inline void io_set_outputspeed(uint32_t io, enum iospeed speed) {
    GPIO_TypeDef *gpio  = io_get_gpio_regs(io);
    int           shift = (io & 15) * 2;

    gpio->OSPEEDR =
        (gpio->OSPEEDR & ~(3 << shift)) |
        (speed << shift);
}

static inline void io_set_pullupdown(uint32_t io, enum iopull val) {
    GPIO_TypeDef *gpio  = io_get_gpio_regs(io);
    int           shift = (io & 15) * 2;

    gpio->PUPDR =
        (gpio->PUPDR & ~(3 << shift)) |
        ((val & 3) << shift);
}

static inline void io_out(uint32_t io, bool on) {
    GPIO_TypeDef *gpio    = io_get_gpio_regs(io);
    uint32_t      bitmask = (1 << (io & 15));

    if (io & IO_INVERT) {
        on = !on;
    }

    if (!on) {
        bitmask <<= 16;
    }
    gpio->BSRR = bitmask;
}

static inline bool io_in(uint32_t io) {
    GPIO_TypeDef *gpio    = io_get_gpio_regs(io);
    uint32_t      bitmask = (1 << (io & 15));

    bool val = (gpio->IDR & bitmask);

    if (io & IO_INVERT) {
        return !val;
    } else {
        return val;
    }
}

static inline void io_set_alternate_function(uint32_t io, int function) {
    GPIO_TypeDef *gpio = io_get_gpio_regs(io);

    int afr_idx = (io & 0xF) / 8;
    int shift   = (io & 7) * 4;

    gpio->AFR[afr_idx] =
        (gpio->AFR[afr_idx] & ~(0xF << shift)) |
        ((function & 0xF) << shift);
}
static inline clock_t io_clock_for_io(uint32_t io) {
    switch ((io >> 4) & 0xF) {
        case IOBANK_A: return CLK_GPIOA;
        case IOBANK_B: return CLK_GPIOB;
        case IOBANK_C: return CLK_GPIOC;
        case IOBANK_D: return CLK_GPIOD;
        case IOBANK_F: return CLK_GPIOF;
        default: return (clock_t)0;
    }
}

#define IO_DEFINE(name, bank, io, invert, mode, initial_value, is_opendrain, speed, pullupdown, function) \
    name = IO_BANK(bank) | (io) | (((invert)&1) << 8),

enum IO {
    __IO_ENUM_DUMMY, // Allow for empty iopins.h
#include "iopins.h"
};

#undef IO_DEFINE

static inline void io_config(uint32_t io, enum iomode mode, bool initial_value, bool is_opendrain, enum iospeed speed, enum iopull pullupdown, int function) {
    io_set_mode(io, mode);
    io_set_opendrain(io, is_opendrain);
    io_set_outputspeed(io, speed);
    io_set_pullupdown(io, pullupdown);
    io_set_alternate_function(io, function);
    io_out(io, initial_value);
}

static inline void io_configure_all_pins() {
#define IO_DEFINE(name, bank, io, invert, mode, initial_value, is_opendrain, speed, pullupdown, function) \
    clock_enable(io_clock_for_io(IO_BANK(bank)));                                                         \
    io_config(name, mode, initial_value, is_opendrain, speed, pullupdown, function);

#include "iopins.h"

#undef IO_DEFINE
}
