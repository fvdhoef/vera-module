#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <fcntl.h>
#include <termios.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>

#define SERIAL_PORT "/dev/ttyS4"
#define BAUDRATE 19200

static int     serial_fd = -1;
struct termios old_serial_tio;

uint8_t bus_read(uint16_t addr);

void restore_settings(void) {
    bus_read(0x8000);

    if (serial_fd >= 0) {
        tcsetattr(serial_fd, TCSANOW, &old_serial_tio);
    }
    printf("Settings restored\n");
}

void init_serial(void) {
    atexit(restore_settings);

    printf("Opening %s @ %u bps\n", SERIAL_PORT, BAUDRATE);

    // Open serial port
    serial_fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NONBLOCK); //O_EXLOCK
    if (serial_fd < 0) {
        perror(SERIAL_PORT);
        exit(1);
    }

    // Get old terminal io settings
    memset(&old_serial_tio, 0, sizeof(old_serial_tio));
    tcgetattr(serial_fd, &old_serial_tio);

    // Set new serial io settings
    struct termios new_serial_tio;
    memcpy(&new_serial_tio, &old_serial_tio, sizeof(new_serial_tio));

    if (cfsetspeed(&new_serial_tio, BAUDRATE) < 0) {
        perror("cfsetspeed");
        exit(1);
    }
    new_serial_tio.c_cflag &= ~(CSIZE | PARENB | PARODD | CSTOPB | CRTSCTS);
    new_serial_tio.c_cflag |= CS8 | CLOCAL | CREAD;
    new_serial_tio.c_iflag &= ~(IGNBRK | IXON | IXOFF | IXANY);
    new_serial_tio.c_lflag     = 0;
    new_serial_tio.c_oflag     = 0;
    new_serial_tio.c_cc[VMIN]  = 0;
    new_serial_tio.c_cc[VTIME] = 0;
    if (tcsetattr(serial_fd, TCSANOW, &new_serial_tio)) {
        perror("tcsetattr");
        exit(1);
    }

    // Make serial port blocking
    if (fcntl(serial_fd, F_SETFL, fcntl(serial_fd, F_GETFL) & ~O_NONBLOCK) < 0) {
        perror("fcntl");
        exit(1);
    }
}

void bus_write(uint16_t addr, uint8_t data) {
    uint8_t buf[4];
    buf[0] = 2;
    buf[1] = addr & 0xff;
    buf[2] = addr >> 8;
    buf[3] = data;
    write(serial_fd, buf, 4);
}

void bus_vwrite(uint32_t addr, uint8_t data) {
    uint8_t buf[5];
    buf[0] = 4;
    buf[1] = (addr >> 16) & 0xff;
    buf[2] = (addr >> 8) & 0xff;
    buf[3] = (addr >> 0) & 0xff;
    buf[4] = data;
    write(serial_fd, buf, 5);
}

uint8_t bus_vread(uint32_t addr) {
    uint8_t buf[4];
    buf[0] = 3;
    buf[1] = (addr >> 16) & 0xff;
    buf[2] = (addr >> 8) & 0xff;
    buf[3] = (addr >> 0) & 0xff;
    write(serial_fd, buf, 4);

    int result;
    do {
        result = read(serial_fd, buf, 1);
        if (result < 0) {
            perror("read");
            exit(1);
        }
    } while (result == 0);

    return buf[0];
}

void bus_vwrite2(uint32_t addr, const uint8_t *data, size_t length) {
    while (length) {
        size_t len = length;
        if (len > 256) {
            len = 256;
        }

        printf("Writing to 0x%x, length: %lu\n", addr, len);

        uint8_t buf[512];
        buf[0] = 5;
        buf[1] = 0x10 | ((addr >> 16) & 0x0f);
        buf[2] = (addr >> 8) & 0xff;
        buf[3] = (addr >> 0) & 0xff;
        buf[4] = len & 0xFF;
        for (int i = 0; i < (int)len; i++) {
            buf[5 + i] = *(data++);
        }
        write(serial_fd, buf, 5 + len);

        addr += len;
        length -= len;
    }
}

uint8_t bus_read(uint16_t addr) {
    uint8_t buf[3];
    buf[0] = 1;
    buf[1] = addr & 0xff;
    buf[2] = addr >> 8;
    write(serial_fd, buf, 3);

    int result;
    do {
        result = read(serial_fd, buf, 1);
        if (result < 0) {
            perror("read");
            exit(1);
        }
    } while (result == 0);

    return buf[0];
}

void sigint_handler(int s) {
    printf("Caught signal %d\n", s);
    exit(1);
}

void set_tile_base(uint32_t p) {
    bus_vwrite(0x40004, (p >> 2) & 0xFF);
    bus_vwrite(0x40005, (p >> 10) & 0xFF);
}

enum layer_mode {
    MODE_TILE_1BPP_16COL_FG_BG = 0,
    MODE_TILE_1BPP_256COL_FG,
    MODE_TILE_2BPP,
    MODE_TILE_4BPP,
    MODE_TILE_8BPP,
    MODE_BITMAP_2BPP,
    MODE_BITMAP_4BPP,
    MODE_BITMAP_8BPP,
};

void set_video_mode(enum layer_mode mode) {
    bus_vwrite(0x40000, (bus_vread(0x40000) & 0x1F) | (mode << 5));
}
void set_video_scale(uint8_t vscale, uint8_t hscale) {
    bus_vwrite(0x40000, (bus_vread(0x40000) & 0xE1) | (((vscale - 1) & 3) << 3) | (((hscale - 1) & 3) << 1));
}

void set_tile_size(uint8_t width, uint8_t height) {
    bus_vwrite(0x40001, (bus_vread(0x40001) & 0xCF) | (width ? 0x10 : 0) | (height ? 0x20 : 0));
}

void layer1_enable(bool enable) {
    bus_vwrite(0x40000, (bus_vread(0x40000) & 0xFE) | (enable ? 1 : 0));
}

void test_8bpp_tile_mode(void) {
    set_video_mode(MODE_TILE_8BPP);
    layer1_enable(true);
    set_tile_base(0x10000);
    set_tile_size(1, 1);
    // set_video_scale(1, 1);

    // return;

#if 1
    bus_vwrite(0x040006, 0);
    bus_vwrite(0x040007, 0);
    bus_vwrite(0x040008, 0);
    bus_vwrite(0x040009, 0);

    // uint8_t buf[64], buf2[64];
    // for (int i = 0; i < 32; i++) {
    //     buf[i * 2 + 0] = i;
    //     buf[i * 2 + 1] = 0x00;
    // }

    // bus_vwrite2(0, buf, sizeof(buf));
    // bus_vwrite2(64, buf2, sizeof(buf2));
    // bus_vwrite(128, 0);
    // bus_vwrite(129, 0);

    {
        FILE *f = fopen("../tileconv/tiles.bin", "rb");
        fseek(f, 0, SEEK_END);
        size_t size = ftell(f);
        fseek(f, 0, SEEK_SET);
        uint8_t *tiles = (uint8_t *)malloc(size);
        fread(tiles, size, 1, f);
        fclose(f);
        bus_vwrite2(0x10000, tiles, size);
        free(tiles);
    }
    {
        FILE *  f = fopen("../tileconv/palette.bin", "rb");
        uint8_t palette[512];
        fread(palette, 512, 1, f);
        fclose(f);
        bus_vwrite2(0x40200, palette, 512);
    }

    // clang-format off
    uint16_t tilemap[32*32] = {
        0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x06, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x07, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x09, 0x0A, 0x07, 0x08, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x02, 0x00, 0x00, 0x06, 0x06, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x09, 0x0A, 0x09, 0x0A, 0x00, 0x00, 0x40B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x09, 0x0A, 0x09, 0x0A, 0x0D, 0x00, 0x40C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
        0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
        0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
        0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
        0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x0D, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    };
    // clang-format on

    bus_vwrite2(0, (const uint8_t *)tilemap, sizeof(tilemap));

    // uint8_t tiledata_2bpp[] = {0x03, 0xC0, 0x0F, 0xF0, 0x3C, 0x3C, 0x3F, 0xFC, 0x3C, 0x3C, 0x3C, 0x3C, 0x3C, 0x3C, 0x00, 0x00};
    // bus_vwrite2(0x10000, tiledata_2bpp, sizeof(tiledata_2bpp));

    // bus_vwrite2(128, buf, sizeof(buf));
    // bus_vwrite2(192, buf, sizeof(buf));
    // bus_vwrite2(256, buf, sizeof(buf));
#endif

#if 0
    for (int i = 0; i <= 512; i++) {
        bus_vwrite(0x040006, i & 0xff);
        bus_vwrite(0x040007, i >> 8);
        usleep(16400);
    }

    for (int i = 0; i <= 512; i++) {
        bus_vwrite(0x040008, i & 0xff);
        bus_vwrite(0x040009, i >> 8);
        usleep(16400);
    }
#endif
}

void test_stuff(void) {

    // {
    //     uint8_t fontbuf[4096];
    //     FILE *  f = fopen("../font8x16.bin", "rb");
    //     if (!f) {
    //         perror("fopen");
    //         exit(1);
    //     }
    //     if (fread(fontbuf, 4096, 1, f) != 1) {
    //         perror("fread");
    //         exit(1);
    //     }
    //     fclose(f);

    //     bus_vwrite2(fontloc, fontbuf, 4096);
    // }

    // bus_vwrite(0x40004, (fontloc >> 2) & 0xFF);
    // bus_vwrite(0x40005, (fontloc >> 10) & 0xFF);

    // exit(0);

    // for (int i=0; i<16; i++) {
    //     bus_write(0x0300 +i, 0xF0 + i);
    // }

    // for (int i=0; i<16 ;i++) {
    //     printf("%02x ", bus_read(0x0300 + i));
    // }
    // printf("\n");

    // bus_write(0x8000, 0);
    // bus_write(0x8001, 0);
    // bus_write(0x8002, 0);
    // bus_write(0x8003, 2);

    // for (int i=0; i<256; i++) {
    //     bus_vwrite(2*i, i);
    //     bus_vwrite(2*i+1, 0x61);
    // }
    // for (int i=0; i<768; i++) {
    //     bus_vwrite(512 + 2*i, 32);
    //     bus_vwrite(512 + 2*i+1, 0x6E);
    // }
#if 0
    uint32_t fontloc = 0x10000;

    bus_vwrite(0x040000, 0);
    bus_vwrite(0x040001, (1 << 5));

    {
        uint8_t fontbuf[4096];
        FILE *  f = fopen("../font8x16.bin", "rb");
        if (!f) {
            perror("fopen");
            exit(1);
        }
        if (fread(fontbuf, 4096, 1, f) != 1) {
            perror("fread");
            exit(1);
        }
        fclose(f);
        bus_vwrite2(fontloc, fontbuf, 4096);
    }
    set_tile_base(0x10000);

    for (int i = 0; i <= 256; i++) {
        bus_vwrite(0x040006, i & 0xff);
        bus_vwrite(0x040007, i >> 8);

        // while ((bus_read(0x8007) & 1) == 0) {
        // }
        // bus_write(0x8007, 1);
        usleep(16400);
    }

    for (int i = 0; i <= 512; i++) {
        bus_vwrite(0x040008, i & 0xff);
        bus_vwrite(0x040009, i >> 8);

        usleep(16400);
    }

    exit(0);
#endif
#if 0
    bus_vwrite(0x040000, 0x0A);

    uint8_t buf[256];
    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = i;
        buf[i * 2 + 1] = 0x61;
    }
    bus_vwrite2(0x100000, buf, 256);

    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 128 + i;
        buf[i * 2 + 1] = 0x61;
    }
    bus_vwrite2(0x100100, buf, 256);

    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 32;
        buf[i * 2 + 1] = 0x51;
    }
    bus_vwrite2(0x100200, buf, 256);
    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 32;
        buf[i * 2 + 1] = 0x41;
    }
    bus_vwrite2(0x100300, buf, 256);
    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 32;
        buf[i * 2 + 1] = 0x31;
    }
    bus_vwrite2(0x100400, buf, 256);
    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 32;
        buf[i * 2 + 1] = 0x21;
    }
    bus_vwrite2(0x100500, buf, 256);
    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 32;
        buf[i * 2 + 1] = 0x71;
    }
    bus_vwrite2(0x100600, buf, 256);
    for (int i = 0; i < 128; i++) {
        buf[i * 2 + 0] = 32;
        buf[i * 2 + 1] = 0x81;
    }
    bus_vwrite2(0x100700, buf, 256);

    bus_vwrite(0x040008, 0);

    for (int i = 0; i <= 256; i++) {
        bus_vwrite(0x040006, i & 0xff);
        bus_vwrite(0x040007, i >> 8);
        usleep(16400);
    }

    for (int i = 0; i <= 256; i++) {
        bus_vwrite(0x040008, i & 0xff);
        bus_vwrite(0x040009, i >> 8);
        usleep(16400);
    }
#endif
}

void test_8bpp_bitmap_mode(void) {
    set_tile_base(0);
    set_video_mode(MODE_BITMAP_8BPP);
    set_video_scale(2, 2);
    layer1_enable(true);

    set_tile_size(0, 0);

    // return;

    bus_vwrite(0x40006, 80);
    bus_vwrite(0x40007, 0);

    {
        FILE *  f = fopen("../imgconv/palette.bin", "rb");
        uint8_t palette[512];
        fread(palette, 512, 1, f);
        fclose(f);
        bus_vwrite2(0x40200, palette, 512);
    }
    {
        FILE *f = fopen("../imgconv/image.bin", "rb");
        fseek(f, 0, SEEK_END);
        size_t size = ftell(f);
        fseek(f, 0, SEEK_SET);
        uint8_t *image = (uint8_t *)malloc(size);
        fread(image, size, 1, f);
        fclose(f);

        printf("Uploading %lu bytes\n", size);
        bus_vwrite2(0, (const uint8_t *)image, size);
        free(image);
    }
}

void set_active_area(unsigned x, unsigned y, unsigned w, unsigned h) {
    unsigned x2 = x + w;
    unsigned y2 = y + h;

    bus_vwrite(0x40044, x & 0xFF);
    bus_vwrite(0x40045, x2 & 0xFF);
    bus_vwrite(0x40046, y & 0xFF);
    bus_vwrite(0x40047, y2 & 0xFF);
    bus_vwrite(0x40048, (((y2 >> 8) & 1) << 5) | (((y >> 8) & 1) << 4) | (((x2 >> 8) & 3) << 2) | (((x >> 8) & 3) << 0));
}

struct sprite_entry {
    int      x;
    int      y;
    int      z;
    bool     hflip;
    bool     vflip;
    unsigned collision_mask;
    unsigned palette_offset;
    bool     mode;
    unsigned width;
    unsigned height;
    unsigned address;
};

void set_sprite(unsigned idx, struct sprite_entry *entry) {
    unsigned offset = 0x40800 + 8 * idx;

    bus_vwrite(offset + 0, (entry->address >> 5) & 0xFF);
    bus_vwrite(offset + 1, (entry->mode ? (1 << 7) : 0) | ((entry->address >> 13) & 0xF));
    bus_vwrite(offset + 2, entry->x & 0xFF);
    bus_vwrite(offset + 3, ((entry->x >> 8) & 3));
    bus_vwrite(offset + 4, entry->y & 0xFF);
    bus_vwrite(offset + 5, ((entry->y >> 8) & 3));
    bus_vwrite(offset + 6, ((entry->collision_mask & 0xF) << 4) | ((entry->z & 3) << 2) | (entry->vflip ? 0x02 : 0) | (entry->hflip ? 0x01 : 0));
    bus_vwrite(offset + 7, ((entry->height & 3) << 6) | ((entry->width & 3) << 4) | (entry->palette_offset & 0xF));
}

int main(int argc, const char **argv) {
    (void)argc;
    (void)argv;

    signal(SIGINT, sigint_handler);
    init_serial();

    bool vga = true;

    bus_vwrite(0x40040, vga ? 1 : 2);

    if (vga) {
        bus_vwrite(0x40041, 64);
        bus_vwrite(0x40042, 64);
        set_active_area(0, 0, 640, 480);
    } else {
        bus_vwrite(0x40041, 144 / 2);
        bus_vwrite(0x40042, 144 / 2);
        set_active_area(23, 24, 569, 429);
    }

    bus_vwrite(0x40043, 6);

    // return;
#if 1

    // for (int i = 255; i >= 0; i++) {
    //     bus_vwrite(0x40041, i);
    //     bus_vwrite(0x40042, i);
    //     usleep(50000);
    // }
    // return;

    // bus_write(0x8005, 0x80);
    // usleep(100000);

    // test_8bpp_bitmap_mode();

    test_8bpp_tile_mode();
    // return;

    bus_vwrite(0x40020, 1);

    unsigned offset = (0x10000 + (11 * 16 * 16)) / 4;

    uint8_t reg3 = (1 << 6) | (2 << 4) | (3 << 2) | (1 << 1);

    struct sprite_entry entry;
    memset(&entry, 0, sizeof(entry));

    entry.x       = 50;
    entry.y       = 130;
    entry.z       = 2;
    entry.mode    = true;
    entry.width   = 1;
    entry.height  = 2;
    entry.address = 0x10000 + (11 * 16 * 16);

    entry.hflip = 0;
    entry.vflip = 0;

    // entry.z = 0;

    int idx = 0;
    int y   = 20;
    do {
        for (int i = 0; i < 25 && idx < 128; i++, idx += 1) {
            entry.x = i * 16;
            entry.y = y;
            // entry.z = 2; //(i % 3) + 1;

            set_sprite(idx, &entry);
            // entry.z = 0;
            // return;
        }

        // entry.z = 0;
        // entry.vflip = !entry.vflip;
        y += 20;
    } while (idx < 128);

    return;
#endif
    for (int i = 0; i <= 512; i++) {
        bus_vwrite(0x040006, i & 0xff);
        bus_vwrite(0x040007, i >> 8);
        // usleep(16400);
    }

    // for (int i = 256; i >= -16; i--) {

    //     // entry.x = i + 30;
    //     // entry.y = 10;
    //     // set_sprite(1, &entry);

    //     // entry.x = i + 60;
    //     // entry.y = 10;
    //     // set_sprite(2, &entry);
    // }

    // for (int i=0; i<6; i++) {
    //     printf("%u: %02x\n", i, bus_vread(0x40800 + i));
    // }

    // for (int i=350; i>=-64; i--) {
    //     bus_vwrite(0x40800, i & 0xFF);
    //     bus_vwrite(0x40801, ((unsigned)(i >> 8) & 3));

    //     usleep(10000);
    // }

    // set_video_mode(MODE_TILE_1BPP_16COL_FG_BG);
    // set_video_scale(1, 1);
    // set_tile_size(1, 1);
    // layer1_enable(true);

    return 0;
}
