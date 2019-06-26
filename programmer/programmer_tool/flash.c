#include <stdio.h>
#include <string.h>
#include "usb.h"
#include "flash.h"
#include <unistd.h>

#if 0
#    pragma GCC diagnostic ignored "-Wpedantic"
#    define dprintf(...) printf(__VA_ARGS__)
#    define assert(ok) ({ bool _ok = (ok); if (!_ok) printf("Assertion failed at %s:%u (%s)\n", __FILE__, __LINE__, #ok); })
#else
#    define dprintf(...)
#    define assert(...)
#endif

#define PROGRAM_BITS // experimental

enum flash_commands {
    JEDEC_ID                 = 0x9F,
    VOLATILE_SR_WRITE_ENABLE = 0x50,
    WRITE_ENABLE             = 0x06,
    READ_DATA                = 0x03,
    FAST_READ                = 0x0B, // one dummy byte before data
    WRITE_DISABLE            = 0x04,
    READ_STATUS_REGISTER_1   = 0x05,
    READ_UNIQUE_ID           = 0x4B,
    CHIP_ERASE               = 0xC7, // or 0x60
    ENABLE_RESET             = 0x66,
    RESET_DEVICE             = 0x99,
    PAGE_PROGRAM             = 0x02,
    SECTOR_ERASE_4KB         = 0x20,
    BLOCK_ERASE_32KB         = 0x52,
    BLOCK_ERASE_64KB         = 0xD8,
};

enum flash_status_register_1_flags {
    STATUS_REGISTER_PROTECT = 0x80,
    SECTOR_PROTECT          = 0x40,
    TOP_BOTTOM_PROTECT      = 0x20,
    BLOCK_PROTECT_BITS      = 0x8C,
    WRITEENABLE_LATCH       = 0x02,
    ERASE_WRITE_IN_PROGRESS = 0x01,
};

const struct flash_info *flash_detect() {
    uint8_t buf[] = {JEDEC_ID, 0, 0, 0};
    spi_select(1);
    spi_transfer(buf, buf, sizeof(buf));
    spi_select(0);
    // hexdump(buf, sizeof(buf));
    if (buf[1] == 0xEF && buf[2] == 0x40 && buf[3] == 0x15) {
        static struct flash_info i = {.name = "W25Q16JV", .size = 0x200000, .sector_size = 4096, .page_size = 256};
        // .block_size = 32768,
        return &i;
    }
    return NULL;
}

enum flash_status_register_1_flags flash_status_register_1() {
    uint8_t buf[] = {READ_STATUS_REGISTER_1, 0};
    spi_select(1);
    spi_transfer(buf, buf, sizeof(buf));
    spi_select(0);
    return buf[1];
}

void flash_wait() {
    while ((flash_status_register_1() & ERASE_WRITE_IN_PROGRESS) != 0) {
        usleep(10000);
    }
}

#define MAX_SECTOR_SIZE 4096
unsigned flash_cache_sector_index = (unsigned)-1;
uint8_t  flash_cache_sector_data[MAX_SECTOR_SIZE];
bool     flash_cache_sector_erase = false;
#ifdef PROGRAM_BITS
uint8_t flash_cache_sector_prog[MAX_SECTOR_SIZE];
// bool flash_cache_page_todo[256]; // need to program? at least 4096 / 256
#endif
unsigned flash_cache_begin = MAX_SECTOR_SIZE;
unsigned flash_cache_end   = 0;

void flash_read(unsigned address, void *data, unsigned size) {
    dprintf("flash_read(%u, %p, %u)\n", address, data, size);
    uint8_t buf[] = {FAST_READ, address >> 16, address >> 8, address >> 0, 0xFF};
    spi_select(1);
    spi_transfer(buf, NULL, sizeof(buf));
    spi_transfer(NULL, data, size);
    spi_select(0);
}

int flash_compare(unsigned address, const void *data, unsigned size) {
    dprintf("flash_read(%u, %p, %u)\n", address, data, size);
    while (size > 0) {
        uint8_t buf[] = {FAST_READ, address >> 16, address >> 8, address >> 0, 0xFF};
        spi_select(1);
        spi_transfer(buf, NULL, sizeof(buf));
        uint8_t  cmpbuf[4096];
        unsigned s = size > 4096 ? 4096 : size;
        spi_transfer(NULL, cmpbuf, s);
        spi_select(0);
        if (memcmp(cmpbuf, data, s) != 0) {
            dprintf("mismatch at offset %u\n", address);
            return -1;
        }
        data = (const uint8_t *)data + s;
        address += s;
        size -= s;
    }
    return 0;
}

static void flash_cache_dirty(unsigned sector_address, unsigned sector_begin, unsigned sector_end) {
    //dprintf("[%u,%u] += [%u,%u]\n", flash_cache_begin, flash_cache_end, sector_begin, sector_end);

    if (sector_begin > flash_cache_end) {
        // read between flash_cache_end and sector_begin
        flash_read(sector_address + flash_cache_end, flash_cache_sector_data + flash_cache_end, sector_begin - flash_cache_end);
        flash_cache_end = sector_begin;
#ifdef PROGRAM_BITS
        memset(flash_cache_sector_prog + flash_cache_end, 0xFF, sector_begin - flash_cache_end);
#endif
    }
    if (sector_end < flash_cache_begin) {
        // read between sector_end and flash_cache_begin
        flash_read(sector_address + sector_end, flash_cache_sector_data + sector_end, flash_cache_begin - sector_end);
        flash_cache_begin = sector_end;
#ifdef PROGRAM_BITS
        memset(flash_cache_sector_prog + sector_end, 0xFF, flash_cache_begin - sector_end);
#endif
    }

    if (sector_begin < flash_cache_begin)
        flash_cache_begin = sector_begin;
    if (sector_end > flash_cache_end)
        flash_cache_end = sector_end;
    //printf("-> [%u,%u]\n", flash_cache_begin, flash_cache_end);
}

static void flash_erase_sector(const struct flash_info *flash_info, unsigned sector_address) {
    dprintf("flash_erase_sector(%u)\n", sector_address);

    {
        uint8_t buf[] = {WRITE_ENABLE};
        spi_select(1);
        spi_transfer(buf, NULL, sizeof(buf));
        spi_select(0);
    }

    if (flash_info->sector_size == 4096) {
        uint8_t buf[] = {SECTOR_ERASE_4KB, sector_address >> 16, sector_address >> 8, sector_address >> 0};
        spi_select(1);
        spi_transfer(buf, NULL, sizeof(buf));
        spi_select(0);
    }

    flash_wait();
}

static void flash_cache_program_pages(const struct flash_info *flash_info, unsigned sector_address) {
    dprintf("flash_cache_program_pages(%u) offset %u to %u\n", sector_address, flash_cache_begin, flash_cache_end);
    // hexdump(flash_cache_sector_data, MAX_SECTOR_SIZE);

    assert((flash_cache_begin % flash_info->page_size) == 0);
    assert((flash_cache_end % flash_info->page_size) == 0);
    assert(flash_cache_end <= flash_info->sector_size);
    assert(flash_cache_begin <= flash_cache_end);

    for (unsigned offset = flash_cache_begin; offset < flash_cache_end; offset += flash_info->page_size) {
#ifdef PROGRAM_BITS
        bool changed = false;
        for (unsigned i = offset; i < offset + flash_info->page_size; i += 8) {
            if (*(uint64_t *)(&flash_cache_sector_prog[i]) != (uint64_t)-1) {
                changed = true;
                break;
            }
        }
        //if (!flash_cache_page_todo[offset / flash_info->page_size]) {
        if (!changed) {
            dprintf("page offset %u not changed\n", offset);
            continue;
        }
#endif
        dprintf("page offset %u CHANGED!\n", offset);

        {
            uint8_t buf[] = {WRITE_ENABLE};
            spi_select(1);
            spi_transfer(buf, NULL, sizeof(buf));
            spi_select(0);
        }

        {
            unsigned address = sector_address + offset;
            uint8_t  buf[]   = {PAGE_PROGRAM, address >> 16, address >> 8, address >> 0};
            spi_select(1);
            spi_transfer(buf, NULL, sizeof(buf));
#ifdef PROGRAM_BITS
            spi_transfer(flash_cache_sector_prog + offset, NULL, flash_info->page_size);
#else
            spi_transfer(flash_cache_sector_data + offset, NULL, flash_info->page_size);
#endif
            spi_select(0);
        }

        flash_wait();
    }
}

static unsigned flash_cache_set_sector(const struct flash_info *flash_info, unsigned address) {
    unsigned new_sector_index   = address / flash_info->sector_size;
    unsigned new_sector_address = new_sector_index * flash_info->sector_size;
    if (new_sector_index != flash_cache_sector_index) {
        if (flash_cache_begin < flash_cache_end) { // contain data?
            assert(flash_cache_sector_index < flash_info->size / flash_info->sector_size);
            unsigned flash_cache_sector_address = flash_cache_sector_index * flash_info->sector_size;
            if (flash_cache_sector_erase) {
                // read rest of data
                flash_cache_dirty(flash_cache_sector_address, 0, flash_cache_begin);
                flash_cache_dirty(flash_cache_sector_address, flash_cache_end, flash_info->sector_size);
                // memset(flash_cache_page_todo, 0xFF, sizeof(flash_cache_page_todo)); // hmz
                flash_erase_sector(flash_info, flash_cache_sector_address);
#ifdef PROGRAM_BITS
                memcpy(flash_cache_sector_prog, flash_cache_sector_data, sizeof(flash_cache_sector_prog));
#endif
                flash_cache_program_pages(flash_info, flash_cache_sector_address);
            } else {
                // only read for certain pages
                unsigned b = flash_cache_begin - (flash_cache_begin % flash_info->page_size);
                unsigned e = flash_cache_end + flash_info->page_size - 1;
                e -= e % flash_info->page_size;
                flash_cache_dirty(flash_cache_sector_address, b, flash_cache_begin);
                flash_cache_dirty(flash_cache_sector_address, flash_cache_end, e);
                flash_cache_program_pages(flash_info, flash_cache_sector_address);
            }
        }
        flash_cache_begin        = MAX_SECTOR_SIZE;
        flash_cache_end          = 0;
        flash_cache_sector_index = new_sector_index;
        flash_cache_sector_erase = false;
        // printf("flash_cache_sector_index %u\n", flash_cache_sector_index);
#ifdef PROGRAM_BITS
        // memset(flash_cache_page_todo, 0, sizeof(flash_cache_page_todo));
#endif
    }
    return new_sector_address;
}

void flash_write(const struct flash_info *flash_info, unsigned address, const void *data, unsigned size) {
    dprintf("flash_write(%u, %p, %u)\n", address, data, size);

    const uint8_t *pdata = (const uint8_t *)data;
    while (size > 0) {
        unsigned sector_address = flash_cache_set_sector(flash_info, address);
        unsigned sector_offset  = (address % flash_info->sector_size);
        uint8_t *p              = flash_cache_sector_data + sector_offset;
#ifdef PROGRAM_BITS
        uint8_t *pp = flash_cache_sector_prog + sector_offset;
#endif
        unsigned size2 = flash_info->sector_size - sector_offset;
        if (size < size2) {
            size2 = size;
        }
        if (flash_cache_begin == MAX_SECTOR_SIZE && flash_cache_end == 0) {
            flash_cache_begin = sector_offset;
#ifdef PROGRAM_BITS
            flash_cache_end = sector_offset; // zero assumption
            flash_cache_dirty(sector_address, sector_offset, sector_offset + size2);
#else
            flash_cache_end = sector_offset + size2; // we'll just do memcpy anyway
#endif
        } else {
            flash_cache_dirty(sector_address, sector_offset, sector_offset + size2);
        }

#ifdef PROGRAM_BITS
        for (unsigned i = 0; i < size2; i++) {
            flash_cache_sector_erase |= ~p[i] & pdata[i]; // when old data is 0 and new data is 1, need to erase
            pp[i] &= ~p[i] | pdata[i];                    // when old data is 1 and new data is 0, set program bit to 0
            // flash_cache_page_todo[(sector_offset + i) / flash_info->page_size] |= (p[i] & ~pdata[i]); // when old data is 1 and new data is 0, need to program page
            p[i] = pdata[i];
        }
#else
        memcpy(p, pdata, size2);
        flash_cache_sector_erase = true;
#endif
        pdata += size2;
        address += size2;
        size -= size2;
    }
}

void flash_flush(const struct flash_info *flash_info) {
    dprintf("flash_flush()\n");
    flash_cache_set_sector(flash_info, (unsigned)-1);
}

void flash_test(const struct flash_info *flash_info) {
    printf("*** may need to erase\n");
    flash_write(flash_info, 100, "\xFF\xFF\xFF\xFF", 4);
    flash_flush(flash_info);

    printf("*** no need to erase\n");
    flash_write(flash_info, 100, "\x33\x00\x00\x33", 4);
    flash_flush(flash_info);

    printf("*** require erase\n");
    flash_write(flash_info, 100, "\x33\xAA\xFF", 3);
    flash_flush(flash_info);

    printf("*** no need to erase\n");
    flash_write(flash_info, 100, "\x33\xAA\x55", 3);
    flash_flush(flash_info);

    printf("*** no need to erase\n");
    flash_write(flash_info, 300, "1234", 4);
    flash_flush(flash_info);

    printf("*** no need to erase\n");
    flash_write(flash_info, 4096, "", 0);
    flash_flush(flash_info);

    printf("*** should read 33 AA 55 33\n");
    uint8_t data[4];
    flash_read(100, data, 4);
    hexdump(data, 4);

    printf("*** should read 31 32 33 34\n");
    flash_read(300, data, 4);
    hexdump(data, 4);
}
