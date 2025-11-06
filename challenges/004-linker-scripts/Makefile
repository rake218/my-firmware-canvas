# challenges/004-linker-scripts/Makefile
ARCH=arm-none-eabi
CC=$(ARCH)-gcc
OBJDUMP=$(ARCH)-objdump
READELF=$(ARCH)-readelf

BUILD_DIR=build
SRC=src/main.c
ELF=$(BUILD_DIR)/firmware.elf

LDSCRIPT=linker.ld

CFLAGS=-Wall -Wextra -nostdlib -ffreestanding -O0 -g
LDFLAGS=-T $(LDSCRIPT)

.PHONY: all test clean run

all: $(ELF)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(ELF): | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC)

test: all
	./tests/test_linker.sh $(ELF)

clean:
	rm -rf $(BUILD_DIR) *.o
