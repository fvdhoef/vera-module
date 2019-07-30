#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "lodepng.h"

uint16_t palette[256];
int      palette_cnt = 0;

int main() {
    uint8_t *pix8 = NULL;
    unsigned w, h;

    if (lodepng_decode32_file(&pix8, &w, &h, "../tiles.png") != 0) {
        exit(0);
    }

    printf("w: %u, h: %u\n", w, h);

    int num_pixels = w * h;

    uint8_t result[w * h];
    for (int i = 0; i < num_pixels; i++) {
        uint16_t color =
            ((pix8[i * 4 + 0] >> 4) << 8) |
            ((pix8[i * 4 + 1] >> 4) << 4) |
            ((pix8[i * 4 + 2] >> 4) << 0);

        int idx = -1;
        for (int j = 0; j < palette_cnt; j++) {
            if (palette[j] == color) {
                idx = j;
                break;
            }
        }
        if (idx < 0) {
            if (palette_cnt >= 256) {
                printf("Too many colors!\n");
                exit(1);
            }
            palette[palette_cnt] = color;
            idx                  = palette_cnt;
            palette_cnt++;
        }
        result[i] = idx;
    }

    printf("Number of colors: %d\n", palette_cnt);

    FILE *f = fopen("palette.bin", "wb");
    fwrite(palette, 2 * 256, 1, f);
    fclose(f);

    f = fopen("tiles.bin", "wb");
    fwrite(result, w * h, 1, f);
    fclose(f);

    return 0;
}
