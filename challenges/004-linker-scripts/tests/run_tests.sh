#!/usr/bin/env bash
set -euo pipefail

# Run from challenge folder
echo "Running challenge harness: build then test"

# Build the project (make will create build/firmware.elf)
if command -v make >/dev/null 2>&1 && [ -f Makefile ]; then
  echo "Running: make all"
  make all
else
  echo "No Makefile found or make not available in PATH. Attempting a direct gcc build..."
  mkdir -p build
  # Attempt a fallback build (may fail if cross-compiler required)
  gcc -Wall -Wextra -O0 -g -nostdlib -ffreestanding -I src src/*.c -o build/firmware.elf || {
    echo "Fallback build failed: no Makefile and gcc build did not succeed."
    exit 3
  }
fi

# Ensure artifact exists
if [ ! -f build/firmware.elf ]; then
  echo "ERROR: build/firmware.elf not produced. Check Makefile or toolchain availability."
  ls -la
  exit 2
fi

# Run actual verification
if [ -x tests/test_linker.sh ]; then
  echo "Executing tests/test_linker.sh"
  ./tests/test_linker.sh build/firmware.elf
else
  echo "Executing tests/test_linker.sh (via bash)"
  bash tests/test_linker.sh build/firmware.elf
fi
