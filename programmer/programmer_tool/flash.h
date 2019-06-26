#pragma once

#include <stdint.h>

struct flash_info {
    const char *name;
    unsigned    size;
    unsigned    sector_size;
    unsigned    page_size;
    // unsigned    block_size;
};

const struct flash_info *flash_detect();
void                     flash_read(unsigned address, void *data, unsigned size);
int                      flash_compare(unsigned address, const void *data, unsigned size);
void                     flash_write(const struct flash_info *flash_info, unsigned address, const void *data, unsigned size);
void                     flash_flush(const struct flash_info *flash_info);
void                     flash_test(const struct flash_info *flash_info);
