#!/usr/bin/env bash
# challenges/004-linker-scripts/tests/test_linker.sh
set -euo pipefail

ELF=${1:-build/firmware.elf}

if [ ! -f "$ELF" ]; then
  echo "ERROR: ELF not found: $ELF"
  exit 2
fi

# Expectation: .text VMA should be 0x08004000
EXPECTED_ADDR=0x08004000

# Use arm-none-eabi-readelf to get section addresses
# Format: [Nr] Name Type ... Addr ...
LINE=$(arm-none-eabi-readelf -S "$ELF" | awk '/\.text/ {print $5; exit}')

if [ -z "$LINE" ]; then
  echo "ERROR: .text section not found in $ELF"
  arm-none-eabi-readelf -S "$ELF"
  exit 3
fi

# readelf prints addresses like 08004000 (no 0x) depending on version. Normalize:
ADDR=0x$LINE
echo "Found .text address: $ADDR"
if [ "$ADDR" != "$EXPECTED_ADDR" ]; then
  echo "FAIL: expected .text at $EXPECTED_ADDR but found $ADDR"
  exit 4
fi

echo "PASS: .text located at $ADDR"
