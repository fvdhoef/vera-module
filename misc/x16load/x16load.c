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
#include <libgen.h>

// #define SERIAL_PORT "/dev/ttyS5"
#define BAUDRATE 1000000

static int     serial_fd = -1;
struct termios old_serial_tio;

void sigint_handler(int s) {
    printf("Caught signal %d\n", s);
    exit(1);
}

void restore_settings(void) {
    tcdrain(serial_fd);

    if (serial_fd >= 0) {
        tcsetattr(serial_fd, TCSANOW, &old_serial_tio);
    }
    printf("Serial settings restored\n");
}

void init_serial(const char *serial_port) {
    atexit(restore_settings);

    printf("Opening %s @ %u bps\n", serial_port, BAUDRATE);

    // Open serial port
    serial_fd = open(serial_port, O_RDWR | O_NOCTTY | O_NONBLOCK); //O_EXLOCK
    if (serial_fd < 0) {
        perror(serial_port);
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

void x16_write(uint16_t addr, uint8_t data) {
    uint8_t buf[4];
    buf[0] = 1;
    buf[1] = addr & 0xff;
    buf[2] = addr >> 8;
    buf[3] = data;
    write(serial_fd, buf, 4);
}

uint8_t x16_read(uint16_t addr) {
    uint8_t buf[3];
    buf[0] = 2;
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

void x16_write_buf(uint16_t addr, const void *buf, size_t size) {
    const uint8_t *p = buf;

    if (size == 0) {
        return;
    }

    while (size > 0) {
        uint8_t cmd[256];
        int     idx = 0;
        while (idx + 4 + 3 < 256 && size > 0) {
            cmd[idx++] = 1;
            cmd[idx++] = addr & 0xff;
            cmd[idx++] = addr >> 8;
            cmd[idx++] = *(p++);
            addr++;
            size--;
        }

        // Add dummy read to check completion
        cmd[idx++] = 2;
        cmd[idx++] = 0;
        cmd[idx++] = 0;
        write(serial_fd, cmd, idx);

        // Wait completion
        int result;
        do {
            uint8_t tmp;
            result = read(serial_fd, &tmp, 1);
            if (result < 0) {
                perror("x16_write_buf");
                exit(1);
            }
        } while (result == 0);
    }
}

void x16_read_buf(uint16_t addr, void *buf, size_t size) {
    uint8_t *p = buf;

    if (size == 0) {
        return;
    }

    while (size > 0) {
        uint8_t cmd[256];
        int     idx   = 0;
        int     rdcnt = 0;
        while (idx + 3 < 256 && size > 0) {
            cmd[idx++] = 2;
            cmd[idx++] = addr & 0xff;
            cmd[idx++] = addr >> 8;
            addr++;
            rdcnt++;
            size--;
        }
        write(serial_fd, cmd, idx);

        while (rdcnt > 0) {
            int result = read(serial_fd, p, rdcnt);
            if (result < 0) {
                perror("read");
                exit(1);
            }
            rdcnt -= result;
            p += result;
        }
    }
}

void x16_jump(uint16_t addr) {
    uint8_t buf[3];
    buf[0] = 3;
    buf[1] = addr & 0xff;
    buf[2] = addr >> 8;
    write(serial_fd, buf, 3);
}

int main(int argc, char *const argv[]) {
    int         opt;
    bool        params_ok         = true;
    const char *serial_port       = "/dev/ttyS5";
    const char *upload_filepath   = NULL;
    const char *download_filepath = NULL;
    int         start             = -1;
    int         transfer_size     = -1;
    int         jmp_addr          = -1;

    while ((opt = getopt(argc, argv, "u:d:s:z:j:")) != -1) {
        switch (opt) {
            case 'p': serial_port = optarg; break;
            case 'u': upload_filepath = optarg; break;
            case 'd': download_filepath = optarg; break;
            case 's': start = strtoul(optarg, NULL, 0); break;
            case 'z': transfer_size = strtoul(optarg, NULL, 0); break;
            case 'j': jmp_addr = strtoul(optarg, NULL, 0); break;
            default: params_ok = false; break;
        }
    }

    bool do_upload   = (upload_filepath && start >= 0 && transfer_size < 0);
    bool do_download = (download_filepath && start >= 0 && transfer_size > 0);
    bool do_jmp      = jmp_addr >= 0;

    if (do_upload && do_download) {
        params_ok = false;
    }
    if (!(do_upload || do_download || do_jmp)) {
        params_ok = false;
    }

    if (!params_ok) { // || !filepath) {
        fprintf(stderr, "usage: %s [options]\n", basename(argv[0]));
        fprintf(stderr, "\n");
        fprintf(stderr, "  -p <serial_port> Serial port (currently: %s)\n", serial_port);
        fprintf(stderr, "  -u <filename>    Upload file to memory\n");
        fprintf(stderr, "  -d <filename>    Download memory to file\n");
        fprintf(stderr, "  -s <start>       Memory start address\n");
        fprintf(stderr, "  -z <size>        Download size\n");
        fprintf(stderr, "  -j <addr>        Jump to address (performed as last action)\n");
        fprintf(stderr, "\n");
        exit(1);
    }

    signal(SIGINT, sigint_handler);
    init_serial(serial_port);

    if (do_upload) {
        FILE *f = fopen(upload_filepath, "rb");
        if (!f) {
            perror(upload_filepath);
            exit(1);
        }

        fseek(f, 0, SEEK_END);
        size_t size = ftell(f);
        fseek(f, 0, SEEK_SET);

        uint8_t *buf = malloc(size);
        fread(buf, size, 1, f);
        fclose(f);

        printf("Uploading %zu bytes from %s to 0x%X...\n", size, upload_filepath, start);
        x16_write_buf(start, buf, size);
        printf("Done\n");

        free(buf);
    }

    if (do_download) {
        FILE *f = fopen(download_filepath, "wb");
        if (!f) {
            perror(download_filepath);
            exit(1);
        }

        uint8_t *buf = malloc(transfer_size);
        printf("Downloading %u bytes from 0x%X to %s...\n", transfer_size, start, download_filepath);
        x16_read_buf(start, buf, transfer_size);
        fwrite(buf, transfer_size, 1, f);
        free(buf);
        fclose(f);
        printf("Done\n");
    }

    if (do_jmp) {
        x16_jump(jmp_addr);
    }
    return 0;
}
