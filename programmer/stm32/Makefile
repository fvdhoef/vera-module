#-----------------------------------------------------------------------------
# Makefile
#-----------------------------------------------------------------------------

INC_DIRS += . lib usb os
SRC_DIRS += . lib usb os
CFLAGS   += -Os -Wno-unused-parameter -Wno-shadow -DSTM32F070x6 -DHAL_PCD_MODULE_ENABLED
LDSCRIPT  = lib/linkerscript

OUT       = $(OBJ_DIR)/stm32.elf
BIN       = $(OBJ_DIR)/stm32.bin
DFU       = $(OBJ_DIR)/stm32.dfu

#-----------------------------------------------------------------------------
# No need to change stuff below this line
#-----------------------------------------------------------------------------

CC           := arm-none-eabi-gcc
OBJDUMP      := arm-none-eabi-objdump
OBJCOPY      := arm-none-eabi-objcopy
SIZE         := arm-none-eabi-size
GDB          := arm-none-eabi-gdb
AR           := arm-none-eabi-ar

CFLAGS       += -mthumb -mcpu=cortex-m0
CFLAGS       += -MD $(addprefix -I,$(INC_DIRS)) -g -ffreestanding
CFLAGS       += -ffunction-sections -fdata-sections
CFLAGS       += -std=c11 -pedantic
CFLAGS       += -Wall -Wextra -Wshadow -Winit-self -Wfloat-conversion -Wdouble-promotion -Wmissing-include-dirs -Wlogical-op
CFLAGS       += -Werror=implicit-function-declaration

LFLAGS       += -Wl,--gc-sections -Wl,-T$(LDSCRIPT)
LFLAGS       += -Wl,-Map=$(OBJ_DIR)/$(OUT_NAME).map.txt

OBJ_DIR      ?= obj

GDB_HOST     ?= localhost
GDB_PORT     ?= 2331

OUT_NAME      = $(basename $(notdir $(OUT)))

#-----------------------------------------------------------------------------
# sources
#-----------------------------------------------------------------------------
S_SRCS   += $(wildcard $(addsuffix /*.S, $(SRC_DIRS)))
C_SRCS   += $(wildcard $(addsuffix /*.c, $(SRC_DIRS)))

#-----------------------------------------------------------------------------
# object files
#-----------------------------------------------------------------------------
S_OBJS   := $(addprefix $(OBJ_DIR)/, $(S_SRCS:.S=.o))
C_OBJS   := $(addprefix $(OBJ_DIR)/, $(C_SRCS:.c=.o))
OBJS     := $(S_OBJS) $(C_OBJS)
DEPS     := $(OBJS:.o=.d)
DEP_OBJS := $(USER_OBJS) $(OBJS)

#-----------------------------------------------------------------------------
# rules
#-----------------------------------------------------------------------------
$(S_OBJS): $(OBJ_DIR)/%.o: %.S
	@echo Assembling $<
	@$(CC) $(CFLAGS) -o $@ -c $<

$(C_OBJS): $(OBJ_DIR)/%.o: %.c
	@echo Compiling $<
	@$(CC) $(CFLAGS) -o $@ -c $<

.PHONY: all release install debug dfu clean

all: $(OBJ_DIR) $(OUT)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR) $(addprefix $(OBJ_DIR)/, $(dir $(S_SRCS) $(C_SRCS)))

$(OUT): $(DEP_OBJS) $(LDSCRIPT) $(CREATEUPDATEFILE)
	@echo Linking $@
	@$(CC) $(DEP_OBJS) $(CFLAGS) $(LFLAGS) -o $@
	@$(SIZE) -A $@
	@$(OBJDUMP) -x $(OUT) > $(OBJ_DIR)/dump_x.txt
	@$(OBJDUMP) -d $(OUT) > $(OBJ_DIR)/dump.txt
	@$(OBJCOPY) -O binary $(OUT) $(OUT:.elf=.bin)

install: all
	@echo Installing $(OUT) using GDB server $(GDB_HOST):$(GDB_PORT)
	@$(GDB) -batch \
		-ex "file $(OUT)" \
		-ex "target remote $(GDB_HOST):$(GDB_PORT)" \
		-ex "monitor reset" \
		-ex "monitor halt" \
		-ex "monitor clrbp" \
		-ex "load" \
		-ex "monitor memU32 0" \
		-ex "set \$$sp = *((unsigned int*)&vector_table + 0)" \
		-ex "set \$$pc = *((unsigned int*)&vector_table + 1)" \
		-ex "monitor go" 2>&1 | \
	grep -q "Reading from address 0x00000000 (Data " && echo gdb install OK || (echo gdb install FAILED ; false)

debug: all
	@echo Debugging $(OUT) using GDB server $(GDB_HOST):$(GDB_PORT)
	@$(GDB) -q --tui $(OUT) \
		-ex "target remote $(GDB_HOST):$(GDB_PORT)" \
		-ex "monitor reset" \
		-ex "monitor halt" \
		-ex "monitor clrbp" \
		-ex "load" \
		-ex "set \$$sp = *((unsigned int*)&vector_table + 0)" \
		-ex "set \$$pc = *((unsigned int*)&vector_table + 1)" \
		-ex "break main"
#	-ex "c"

$(BIN): $(OUT)
	$(OBJCOPY) -O binary $< $@

$(DFU): $(BIN)
	../../tools/scripts/dfu-convert.py -b 0x08000000:$< $@

dfu: $(DFU)
	@echo Programming $<...
	dfu-util --alt 0 --download $< --reset

clean:
	@echo Cleaning...
	@rm -rf $(OBJ_DIR)

.DEFAULT_GOAL = all

-include $(DEPS)
