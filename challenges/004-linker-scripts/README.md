# Challenge 004 : Linker Scripts (Intro)

Goal
----
Learn how to write a basic GNU linker script that places the `.text` section at a specific flash address.

What you'll do
--------------
- Write/inspect `linker.ld`
- Build a freestanding ELF with `arm-none-eabi-gcc`
- Verify the `.text` section VMA (address) in the ELF matches the expected value

Expected addresses
------------------
This challenge expects `.text` to be linked to `0x08004000` (an arbitrary flash start for this exercise).

How to run (local/Codespaces)
-----------------------------
# from repo root:
cd challenges/004-linker-scripts
# in Codespaces or in the Docker container, run:
make test

What `make test` does
---------------------
1. Builds `build/firmware.elf` using `linker.ld`
2. Runs `tests/test_linker.sh` which checks `.text` VMA using arm-none-eabi-readelf

Notes
-----
This challenge contains a small Dockerfile for reproducible builds with `gcc-arm-none-eabi` and `arm-none-eabi-readelf`. Use it if your local machine doesn't have the toolchain installed.

