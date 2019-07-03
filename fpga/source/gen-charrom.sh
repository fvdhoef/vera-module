#!/bin/sh
hexdump -ve '1/4 "%.8x\n"' ../../misc/c64-char-rom.bin > ./char_rom.mem
