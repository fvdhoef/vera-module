#include <stdio.h>
#include <stdint.h>
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

void restore_settings(void) {
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

void bus_vwrite2(uint32_t addr, const uint8_t *data, size_t length) {
    if (length == 0) {
        return;
    }

    uint8_t buf[512];
    buf[0] = 5;
    buf[1] = (addr >> 16) & 0xff;
    buf[2] = (addr >> 8) & 0xff;
    buf[3] = (addr >> 0) & 0xff;
    buf[4] = length & 0xFF;
    for (int i = 0; i < (int)length; i++) {
        buf[5 + i] = data[i];
    }
    write(serial_fd, buf, 5 + length);
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

int main(int argc, const char **argv) {
    (void)argc;
    (void)argv;

    signal(SIGINT, sigint_handler);
    init_serial();

    // bus_vwrite2(0x200000, buf, 256);

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

    bus_vwrite(0x040000, 0x0A);
    bus_vwrite(0x040001, 0);

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

    for (int i = 0; i < 257; i++) {
        bus_vwrite(0x040006, i & 0xff);
        // bus_vwrite(0x040007, i >> 8);
        // bus_vwrite(0x040008, i & 0xff);
        // bus_vwrite(0x040009, i >> 8);

        while ((bus_read(0x8007) & 1) == 0) {
        }
        bus_write(0x8007, 1);
    }

    // bus_write(0x8000, 0x00);
    // bus_write(0x8001, 0x00);
    // bus_write(0x8002, 0x00);

    // bus_write(0x8003, 5);

    // printf("%02x\n", bus_read(0x8000));
    // printf("%02x\n", bus_read(0x8001));
    // printf("%02x\n", bus_read(0x8002));
    // printf("%02x\n", bus_read(0x8003));

    usleep(10000);

    return 0;
}
