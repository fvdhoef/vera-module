#!/usr/bin/python3.7
import math

for i in range(512):
    phase = i / 512.0 * (2.0 * math.pi)

    val = round(math.sin(phase) * 100) & 255

    print(f'        9\'d{i}: value <= 8\'d{val};')
