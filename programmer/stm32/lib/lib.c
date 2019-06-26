#include "lib.h"

void hexdump(const void *buf, int length) {
    int            idx = 0;
    const uint8_t *p   = (const uint8_t *)buf;

    while (length > 0) {
        int len = length;
        if (len > 16) {
            len = 16;
        }

        DBGF("%08x  ", idx);

        for (int i = 0; i < 16; i++) {
            if (i < len) {
                DBGF2("%02x ", p[i]);
            } else {
                DBGF2("   ");
            }
            if (i == 7) {
                DBGF2(" ");
            }
        }
        DBGF2(" |");

        for (int i = 0; i < len; i++) {
            DBGF2("%c", (p[i] >= 32 && p[i] <= 126) ? p[i] : '.');
        }
        DBGF2("|\n");

        idx += len;
        length -= len;
        p += len;

        udelay(10000);
    }
}
