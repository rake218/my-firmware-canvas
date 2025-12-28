# 005 — STM32F769I Discovery LED Blink

## Problem
Bring up STM32F769I from reset to main() using bare-metal C/ASM. No HAL, no IDE.

## Approach
- Custom linker script
- Custom startup assembly
- Manual GPIO setup
- LED blink to verify

## How to Build
```bash
docker build -t mfc-005-ledblink .
docker run --rm -v ${PWD}:/workspaces/my-firmware-canvas/challenges/005-stm32f769idisco-ledblink mfc-005-ledblink make
