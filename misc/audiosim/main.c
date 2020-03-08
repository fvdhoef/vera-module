#include <stdint.h>
#include <stdio.h>
#include <math.h>

int16_t sin_table[256];

void generate_sin_table(void) {
    for (int i = 0; i < 256; i++) {
        double phi   = (i / 256.0) * (M_PI / 2.0);
        sin_table[i] = (int)(sin(phi) * 32767.0);
    }
}

int16_t lookup_sin(unsigned phase) {
    uint8_t idx = (phase & 256) ? (~phase & 255) : (phase & 255);
    int16_t val = sin_table[idx];
    return (phase & 512) ? ~val : val;
}

int main() {
    generate_sin_table();
    // for (int i = 0; i < 256; i++) {
    //     printf("%4d %d\n", i, sin_table[i]);
    // }

    double fs    = 44100.0;
    double fnote = 440.0;

    int freq = 10240;

    int op1_ratio = 16;
    int op2_ratio = 32;

    int op1_phase = 0;
    int op2_phase = 0;

    int16_t result[44100];
    int     idx = 0;

    for (int i = 0; i < 44100; i++) {
        int op2_freq = (op2_ratio * freq) / 16;
        op2_phase += op2_freq;
        int op2_val = lookup_sin(op2_phase >> 10);

        int op1_freq = (op1_ratio * freq) / 16;
        op1_phase += op1_freq + (op2_val * 1);
        int op1_val = lookup_sin(op1_phase >> 10);

        result[idx++] = op1_val;
    }

    FILE *f = fopen("result.bin", "wb");
    fwrite(result, sizeof(result), 1, f);
    fclose(f);

    return 0;
}
