OUT     = $(OBJ_DIR)/fostest.prg
S_SRCS += main.s

OBJ_DIR ?= obj
S_OBJS  := $(addprefix $(OBJ_DIR)/, $(S_SRCS:.s=.o))

AS = ca65
LD = ld65
EMU ?= ~/Work/x16/x16-emulator/x16emu
EMU_PARAMS = -rom ../fos-rom/obj/fos.rom -sdcard disk.img -quality nearest -scale 2 -echo

.PHONY: all run clean

all: $(OUT)

$(OUT): $(OBJ_DIR) $(S_OBJS)
	@echo Linking $@
	@$(LD) -C x16.cfg -m $(OUT).map -o $(OUT) $(S_OBJS)

$(OBJ_DIR):
	@mkdir -p $(dir $(S_OBJS))

$(S_OBJS): $(OBJ_DIR)/%.o: %.s
	@echo Assembling $<
	@$(AS) --cpu 65C02 -l $@.lst -o $@ $<

run: all disk.img
	-mdel -i disk.img@@1M $(notdir $(OUT))
	mcopy -i disk.img@@1M $(OUT) ::
	$(EMU) $(EMU_PARAMS)

clean:
	@echo Cleaning...
	@rm -rf $(OUT) $(OBJ_DIR)

disk.img:
	# Generate empty disk image
	dd if=/dev/zero of=diskhdr.img bs=1M count=128
	# Partition disk image with one FAT32 partition
	echo "o\nn\np\n1\n2048\n\nt\nc\nw" | /sbin/fdisk diskhdr.img
	# Copy FAT32 partition to separate file
	dd if=diskhdr.img of=diskfs.img bs=1M skip=1
	# Truncate to only partition header
	truncate -s 1M diskhdr.img
	# Format FAT32 partition
	/sbin/mkfs.vfat -F 32 diskfs.img
	# Concatenate header with partition table
	cat diskhdr.img diskfs.img > disk.img
	# Remove temporary files
	rm -f diskhdr.img diskfs.img
