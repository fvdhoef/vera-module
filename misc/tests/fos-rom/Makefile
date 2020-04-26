OUT     = $(OBJ_DIR)/fos.rom
S_SRCS += main.s
S_SRCS += vera.s
S_SRCS += sdcard.s
S_SRCS += fat32.s
S_SRCS += ps2.s
S_SRCS += text_display.s
S_SRCS += text_input.s
S_SRCS += fat32_util.s
S_SRCS += cli.s
S_SRCS += jumptable.s

EMU_PARAMS = -sdcard ~/Work/x16/x16-emulator/disk5.img -quality nearest -scale 2 -echo

COMMON_DIR := common

S_SRCS +=

OBJ_DIR ?= obj
S_OBJS  := $(addprefix $(OBJ_DIR)/, $(S_SRCS:.s=.o))

AS = ca65
LD = ld65
EMU ?= ~/Work/x16/x16-emulator/x16emu

.PHONY: all run clean flash

all: $(OUT)

$(OUT): $(OBJ_DIR) $(S_OBJS)
	@echo Linking $@
	@$(LD) -C x16-rom.cfg -m $(OUT).map -o $(OUT) $(S_OBJS)
	cat $(OUT) $(OUT) $(OUT) $(OUT) $(OUT) $(OUT) $(OUT) $(OUT) > $(OUT).bin
	./jumptable_to_inc.py

$(OBJ_DIR):
	@mkdir -p $(dir $(S_OBJS))

$(S_OBJS): $(OBJ_DIR)/%.o: %.s
	@echo Assembling $<
	@$(AS) --cpu 65C02 -I$(COMMON_DIR) -l $@.lst -o $@ $<

run: all
	$(EMU) $(EMU_PARAMS) -rom $(OUT).bin

flash: all
	minipro -p SST39SF010A -w $(OUT).bin

clean:
	@echo Cleaning...
	@rm -rf $(OUT) $(OBJ_DIR)

.DEFAULT_GOAL := all
