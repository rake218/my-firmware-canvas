#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Build firmware for challenge-005: STM32F769 bare-metal LED blink
# This script:
#   1) Creates a clean build directory
#   2) Configures CMake with the ARM toolchain
#   3) Builds the firmware into ELF and BIN files
#   4) Performs minimal host-side verification (section check)
# -----------------------------------------------------------------------------

# Exit immediately if a command fails, treat unset variables as errors,
# and prevent errors in pipes from being masked
set -euo pipefail

# -----------------------------------------------------------------------------
# Step 0: Clean and prepare build directory
# -----------------------------------------------------------------------------
rm -rf build          # Remove old build artifacts (if any)
mkdir -p build        # Create a fresh build directory
cd build              # Move into the build directory

# -----------------------------------------------------------------------------
# Step 1: Configure CMake with ARM cross-compilation toolchain
# -DCMAKE_TOOLCHAIN_FILE points to a CMake toolchain file that sets:
#   - Compiler: arm-none-eabi-gcc
#   - Assembler: arm-none-eabi-gcc
#   - Linker flags suitable for Cortex-M7 bare-metal
# -DCMAKE_BUILD_TYPE=Debug adds debug symbols
# -----------------------------------------------------------------------------
cmake .. -DCMAKE_TOOLCHAIN_FILE=../../tools/arm-none-eabi.cmake -DCMAKE_BUILD_TYPE=Debug

# -----------------------------------------------------------------------------
# Step 2: Build the firmware
# -----------------------------------------------------------------------------
# -j$(nproc) runs compilation in parallel on all available CPU cores for speed
make -j$(nproc)

# -----------------------------------------------------------------------------
# Step 3: Verify that build outputs exist
# -----------------------------------------------------------------------------
if [ ! -f LED_Blink.elf ]; then
    echo "ERROR: LED_Blink.elf not found!"
    exit 1
fi

# Generate binary file from ELF for flashing
arm-none-eabi-objcopy -O binary LED_Blink.elf LED_Blink.bin

if [ ! -f LED_Blink.bin ]; then
    echo "ERROR: LED_Blink.bin not found!"
    exit 1
fi

echo " Firmware built successfully: ELF and BIN generated"

# -----------------------------------------------------------------------------
# Step 4: Minimal host-side verification
# - Uses objdump to list sections (.text, .data, .bss)
# - Ensures that the sections exist in the ELF file
# -----------------------------------------------------------------------------
arm-none-eabi-objdump -h LED_Blink.elf | grep -E ".text|.data|.bss"

echo " Minimal host-side verification completed"

# -----------------------------------------------------------------------------
# Step 5: Finish
# -----------------------------------------------------------------------------
echo " QEMU skipped: STM32F769 peripherals not supported"
echo " Challenge-005 test completed"
