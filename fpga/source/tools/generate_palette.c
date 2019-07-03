#include <stdio.h>
#include <stdint.h>
#include <math.h>

uint16_t commodore_palette[] = {
    0x000, // Commodore 16 color
    0xFFF,
    0x800,
    0xAFE,
    0xC4C,
    0x0C5,
    0x00A,
    0xEE7,
    0xD85,
    0x640,
    0xF77,
    0x333,
    0x777,
    0xAF6,
    0x08F,
    0xBBB,
};

struct RGB {
    unsigned char R;
    unsigned char G;
    unsigned char B;
};

struct HSV {
    double H;
    double S;
    double V;
};

struct RGB HSVToRGB(struct HSV hsv) {
    double r = 0, g = 0, b = 0;

    if (hsv.S == 0) {
        r = hsv.V;
        g = hsv.V;
        b = hsv.V;
    } else {
        int    i;
        double f, p, q, t;

        if (hsv.H == 360)
            hsv.H = 0;
        else
            hsv.H = hsv.H / 60;

        i = (int)trunc(hsv.H);
        f = hsv.H - i;

        p = hsv.V * (1.0 - hsv.S);
        q = hsv.V * (1.0 - (hsv.S * f));
        t = hsv.V * (1.0 - (hsv.S * (1.0 - f)));

        switch (i) {
            case 0:
                r = hsv.V;
                g = t;
                b = p;
                break;

            case 1:
                r = q;
                g = hsv.V;
                b = p;
                break;

            case 2:
                r = p;
                g = hsv.V;
                b = t;
                break;

            case 3:
                r = p;
                g = q;
                b = hsv.V;
                break;

            case 4:
                r = t;
                g = p;
                b = hsv.V;
                break;

            default:
                r = hsv.V;
                g = p;
                b = q;
                break;
        }
    }

    struct RGB rgb;
    rgb.R = r * 15;
    rgb.G = g * 15;
    rgb.B = b * 15;

    return rgb;
}

int main() {
    // Commodore palette
    for (int i = 0; i < 16; i++) {
        printf("%04x\n", commodore_palette[i]);
    }

    // Grayscale ramp
    for (int i = 0; i < 16; i++) {
        printf("%04x\n", (i << 8) | (i << 4) | (i << 0));
    }

    // General purpose palette
    for (int hue = 0; hue < 8; hue++) {
        for (int saturation = 0; saturation < 4; saturation++) {
            for (int value = 0; value < 7; value++) {
                struct HSV hsv;
                hsv.H = (double)hue / 8.0 * 360.0;
                hsv.S = (double)(saturation + 1) / 4.0;
                hsv.V = (double)(value + 1) / 7.0;

                struct RGB rgb   = HSVToRGB(hsv);
                uint16_t   entry = (rgb.R << 8) | (rgb.G << 4) | (rgb.B << 0);
                printf("%04x\n", entry);
            }
        }
    }
    return 0;
}
