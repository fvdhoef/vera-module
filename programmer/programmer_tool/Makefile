INC_DIRS    += .
SRC_DIRS    += .

CFLAGS      += -O0 -g
OUT          = $(OBJ_DIR)/programmer_tool
CFLAGS      += `pkg-config --cflags libusb-1.0`
LFLAGS      += `pkg-config --libs libusb-1.0`

CFLAGS      += -D_BSD_SOURCE -D_DEFAULT_SOURCE -std=c11 -pedantic
CFLAGS      += -Wall -Wextra -Wshadow -Winit-self -Wfloat-conversion -Wdouble-promotion -Wmissing-include-dirs
CFLAGS      += -Werror=implicit-function-declaration
OBJ_DIR     ?= obj

CFLAGS      += -MD $(addprefix -I,$(INC_DIRS))

#-----------------------------------------------------------------------------
# sources
#-----------------------------------------------------------------------------
C_SRCS      += $(wildcard $(addsuffix /*.c, $(SRC_DIRS)))

#-----------------------------------------------------------------------------
# object files
#-----------------------------------------------------------------------------
C_OBJS      := $(addprefix $(OBJ_DIR)/, $(C_SRCS:.c=.o))
OBJS        := $(C_OBJS)
DEPS        := $(OBJS:.o=.d)

#-----------------------------------------------------------------------------
# rules
#-----------------------------------------------------------------------------

.PHONY: all clean run debug

all: $(OUT)

$(OUT): $(OBJ_DIR) $(OBJS)
	@echo Linking $@
	@$(CC) $(OBJS) $(CFLAGS) $(LFLAGS) -o $@

$(C_OBJS): $(OBJ_DIR)/%.o: %.c
	@echo Compiling $<
	@$(CC) $(CFLAGS) -o $@ -c $<

$(OBJ_DIR):
	@mkdir -p $(dir $(C_OBJS))

run: $(OUT)
	$(OUT) $(RUN_PARAMS)

debug: $(OUT)
	gdb -ex "b main" -ex "run" -q --tui --args $(OUT) $(RUN_PARAMS)

clean:
	@echo Cleaning...
	@rm -f $(OUT)
	@rm -rf $(OBJ_DIR)

.DEFAULT_GOAL = all

-include $(DEPS)
