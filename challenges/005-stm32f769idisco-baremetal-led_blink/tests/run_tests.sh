#!/usr/bin/env bash
set -e

rm -rf build
mkdir build
cd build

cmake .. \
  -DCMAKE_TOOLCHAIN_FILE=../../tools/arm-none-eabi.cmake
make

echo "== Running in QEMU =="
timeout 5 qemu-system-arm \
  -M stm32f7discovery \
  -kernel firmware.elf \
  -nographic -serial stdio | tee qemu.log

grep -q "LED toggled" qemu.log
echo "PASS: firmware executed in QEMU"
