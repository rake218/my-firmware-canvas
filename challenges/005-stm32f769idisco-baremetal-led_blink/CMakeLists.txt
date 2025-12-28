cmake_minimum_required(VERSION 3.15)
project(LED_Blink C ASM)

# Use cross-compiler
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)

# Compile flags for Cortex-M7 bare-metal
set(CMAKE_C_FLAGS "-mcpu=cortex-m7 -mthumb -O0 -g -ffreestanding -nostdlib")
set(CMAKE_ASM_FLAGS "-mcpu=cortex-m7 -mthumb")
set(CMAKE_EXE_LINKER_FLAGS "-T${CMAKE_SOURCE_DIR}/linker/stm32f769.ld -nostdlib")

# Source files
set(SRC
    src/main.c
    src/startup.s
)

# Generate ELF target
add_executable(${PROJECT_NAME}.elf ${SRC})

# Generate BIN file
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMENT "Generating binary file")
