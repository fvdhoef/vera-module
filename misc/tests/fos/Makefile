OUT     = $(OBJ_DIR)/fos.prg
S_SRCS += main.s
S_SRCS += sdcard.s
S_SRCS += fat32.s
S_SRCS += text_display.s
S_SRCS += text_input.s
S_SRCS += fat32_util.s
S_SRCS += cli.s

EMU_PARAMS = -sdcard ~/Work/x16/x16-emulator/disk5.img -quality nearest -scale 2 -echo

install: all
	cp $(OUT) /media/frank/X16/
	sync

include common/Makefile.common

.DEFAULT_GOAL := all
