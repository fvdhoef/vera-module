#include "lib.h"
#include "usb.h"
#include "flash.h"
#include "unistd.h"

#ifndef __APPLE__
#include <libgen.h>
#else
const char *basename(const char *argv0) {
    const char *p = argv0, *p2 = p;
    while (*p++) {
        if (*p == '/') {
            p2 = p + 1;
        }
    }
    return p2;
}
#endif

void upload_fpga(const char *filepath) {
    FILE *f = fopen(filepath, "rb");
    if (!f) {
        perror(filepath);
        exit(EXIT_FAILURE);
    }

    fseek(f, 0, SEEK_END);
    unsigned size = ftell(f);
    fseek(f, 0, SEEK_SET);

    uint8_t *image = malloc(size);
    fread(image, size, 1, f);
    fclose(f);

    // hexdump(image, size);

    spi_set_mode(SPI_MODE_FPGA);
    printf("CDONE before: %u\n", get_cdone());

    spi_transfer(image, NULL, size);

    uint8_t dummy[100];
    memset(dummy, 0, sizeof(dummy));
    spi_transfer(dummy, NULL, sizeof(dummy));

    spi_set_mode(SPI_MODE_NONE);

    printf("CDONE after: %u\n", get_cdone());

    free(image);
}

#define IMAGE_RECORD_SIZE 32

void generate_flash_image_record(uint8_t record[IMAGE_RECORD_SIZE], uint32_t boot_address) {
    memset(record, 0, IMAGE_RECORD_SIZE);
    uint8_t *p = record;

    //preamble
    *p++ = 0x7E;
    *p++ = 0xAA;
    *p++ = 0x99;
    *p++ = 0x7E;

    *p++ = 9 << 4 | 2; // payload (boot)
    *p++ = 0;          // disable warm boot
    *p++ = 0;

    *p++ = 4 << 4 | 4; // set boot address
    *p++ = 0x03;
    *p++ = (uint8_t)(boot_address >> 16);
    *p++ = (uint8_t)(boot_address >> 8);
    *p++ = (uint8_t)(boot_address >> 0);

    *p++ = 8 << 4 | 2; // set bank offset
    *p++ = 0x00;
    *p++ = 0x00;

    *p++ = 0 << 4 | 1; // payload
    *p++ = 8;          // payload = reboot

    while (p < record + IMAGE_RECORD_SIZE) {
        *p++ += 0x00;
    }
}

enum image_record {
    IMAGE_RECORD_POR = 0, // PoR image when not using coldboot mode
    IMAGE_RECORD_0,
    IMAGE_RECORD_1,
    IMAGE_RECORD_2,
    IMAGE_RECORD_3,
    IMAGE_RECORD_NUM,
};

void upload_fpga_image(int index, const char *filepath, bool power_on_reset) {
    spi_set_mode(SPI_MODE_FLASH);

    const struct flash_info *flash_info = flash_detect();
    if (flash_info == NULL) {
        fprintf(stderr, "flash not detected\n");
        exit(EXIT_FAILURE);
    }

    printf("flash: %s\n", flash_info->name);

#if 0
    flash_test(flash_info);
    return;
#endif

    size_t fpga_image_size = 0x1A000;
    fpga_image_size += (flash_info->sector_size - 1);
    fpga_image_size -= (fpga_image_size % flash_info->sector_size);

    FILE *f = fopen(filepath, "rb");
    if (!f) {
        perror(filepath);
        exit(EXIT_FAILURE);
    }

    fseek(f, 0, SEEK_END);
    unsigned size = ftell(f);
    fseek(f, 0, SEEK_SET);

    uint8_t *image = malloc(size);
    fread(image, size, 1, f);
    fclose(f);

    uint32_t boot_address = 0;
    if (index < 0) {
        printf("flashing image data @ 0x%X\n", boot_address);
        flash_write(flash_info, boot_address, image, size);
        flash_flush(flash_info);
    } else if (index < 4) {
        boot_address = flash_info->sector_size + index * fpga_image_size;
        printf("flashing image data @ 0x%X\n", boot_address);
        flash_write(flash_info, boot_address, image, size);
        flash_flush(flash_info);

        printf("current image records:\n");
        uint8_t records[IMAGE_RECORD_NUM][IMAGE_RECORD_SIZE];
        flash_read(0, records, IMAGE_RECORD_SIZE * IMAGE_RECORD_NUM);

        generate_flash_image_record(records[IMAGE_RECORD_0 + index], boot_address);
        if (power_on_reset) {
            generate_flash_image_record(records[IMAGE_RECORD_POR], boot_address);
        }

        // print updated records
        for (unsigned i = 0; i < IMAGE_RECORD_NUM; i++) {
            if (records[i][0] != 0x7E || records[i][1] != 0xAA || records[i][2] != 0x99 || records[i][3] != 0x7E) {
                memset(records[i], 0xFF, IMAGE_RECORD_SIZE);
            }
            printf("image #%d boot address 0x%X\n", i - 1, records[i][9] << 16 | records[i][10] << 8 | records[i][11] << 0);
        }

        printf("flashing image records\n");
        flash_write(flash_info, 0, records, IMAGE_RECORD_SIZE * IMAGE_RECORD_NUM);
        flash_flush(flash_info);
    }

    printf("verifying image data\n");
    if (flash_compare(boot_address, image, size) != 0) {
        printf("flash verification error!\n");
    }

    free(image);
}

void flash_write_file(const char *filepath, unsigned start) {
    spi_set_mode(SPI_MODE_FLASH);

    const struct flash_info *flash_info = flash_detect();
    if (flash_info == NULL) {
        fprintf(stderr, "flash not detected\n");
        exit(EXIT_FAILURE);
    }

    printf("flash: %s\n", flash_info->name);

    FILE *f = fopen(filepath, "rb");
    if (f == NULL) {
        fprintf(stderr, "File not found: '%s'\n", filepath);
        exit(EXIT_FAILURE);
    }
    fseek(f, 0, SEEK_END);
    unsigned size = ftell(f);
    fseek(f, 0, SEEK_SET);

    unsigned end = start + size;
    if (start >= flash_info->size || end >= flash_info->size) {
        fprintf(stderr, "Given memory area out of range.\n");
        exit(EXIT_FAILURE);
    }

    uint8_t  data[4096];
    unsigned todo = size;
    while (todo > 0) {
        fflush(stdout);
        unsigned t = todo > 4096 ? 4096 : todo;
        fread(data, t, 1, f);
        flash_write(flash_info, start, data, t);
        // hexdump(data, t);
        start += t;
        todo -= t;
        printf("\rwriting %u%%", 100 - (todo * 100 / size));
    }
    printf("\n");
    flash_flush(flash_info);
    fclose(f);
    return;
}

void flash_dump(const char *filepath, unsigned start, unsigned size) {
    spi_set_mode(SPI_MODE_FLASH);

    const struct flash_info *flash_info = flash_detect();
    if (flash_info == NULL) {
        fprintf(stderr, "flash not detected\n");
        exit(EXIT_FAILURE);
    }

    printf("flash: %s\n", flash_info->name);

    if (size == (unsigned)-1) {
        size = flash_info->size - start;
    }
    unsigned end = start + size;
    if (end < start || start > flash_info->size || end > flash_info->size) {
        fprintf(stderr, "Given memory area out of range. %u..%u\n", start, end);
        exit(EXIT_FAILURE);
    }

    FILE *fdump = fopen(filepath, "wb");
    if (fdump == NULL) {
        fprintf(stderr, "Could not create file: '%s'\n", filepath);
        exit(EXIT_FAILURE);
    }
    uint8_t  data[4096];
    unsigned todo = size;
    while (todo > 0) {
        fflush(stdout);
        unsigned t = todo > 4096 ? 4096 : todo;
        flash_read(start, data, t);
        // hexdump(data, t);
        fwrite(data, t, 1, fdump);
        start += t;
        todo -= t;
        printf("\rdumping %u%%", 100 - (todo * 100 / size));
    }
    printf("\n");
    fclose(fdump);
    return;
}

int main(int argc, char *const argv[]) {
    int         opt;
    bool        params_ok         = true;
    const char *filepath          = NULL;
    int         fpga_image_index  = 0;
    const char *filepath0         = NULL;
    const char *fileflashwrite    = NULL;
    const char *fileflashdump     = NULL;
    bool        fpga_boot_flash   = false;
    bool        mass_erase        = false;
    unsigned    start             = 0;
    unsigned    size              = (unsigned)-1;

    while ((opt = getopt(argc, argv, "F:i:I:U:D:s:z:B!")) != -1) {
        switch (opt) {
            case 'F': filepath = optarg; break;
            case 'i': fpga_image_index = atoi(optarg); break;
            case 'I': filepath0 = optarg; break;
            case 'U': fileflashwrite = optarg; break;
            case 'D': fileflashdump = optarg; break;
            case 's': start = strtoul(optarg, NULL, 0); break;
            case 'z': size = strtoul(optarg, NULL, 0); break;
            case 'B': fpga_boot_flash = true; break;
            case '!': mass_erase = true; break;
            default: params_ok = false; break;
        }
    }

    if (!params_ok) { // || !filepath) {
        fprintf(stderr, "usage: %s [options]\n", basename(argv[0]));
        fprintf(stderr, "\n");
        fprintf(stderr, "  -F <filename>  Program FPGA (volatile)\n");
        fprintf(stderr, "  -i <index>     Select FPGA image index. (0..3). default=0\n");
        fprintf(stderr, "  -I <filename>  Program FPGA image to flash\n");
        fprintf(stderr, "  -U <filename>  Write flash\n");
        fprintf(stderr, "  -D <filename>  Dump flash\n");
        fprintf(stderr, "  -s <start>     Write/dump start address\n");
        fprintf(stderr, "  -z <size>      Dump size\n");
        fprintf(stderr, "  -B             Reset FPGA and boot from flash\n");
        fprintf(stderr, "  -!             Erase microcontroller of programmer and return to USB DFU (CAUTION!)\n");
        fprintf(stderr, "\n");
        exit(1);
    }

    usb_init();
    spi_set_mode(SPI_MODE_NONE);

    if (mass_erase) {
        start_mass_erase();
    }

    if (filepath != NULL) {
        upload_fpga(filepath);
    }

    if (filepath0 != NULL) {
        upload_fpga_image(fpga_image_index, filepath0, fpga_image_index == 0);
    }

    if (fileflashwrite != NULL) {
        flash_write_file(fileflashwrite, start);
    }

    if (fileflashdump != NULL) {
        flash_dump(fileflashdump, start, size);
    }

    if (fpga_boot_flash) {
        spi_set_mode(SPI_MODE_FPGA_BOOT);
    }

    return 0;
}
