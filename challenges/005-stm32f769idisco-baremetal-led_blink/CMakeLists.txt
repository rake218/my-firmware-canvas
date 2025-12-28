cmake_minimum_required(VERSION 3.15)


# We are bare-metal — cross-compilation toolchain is provided externally
project(LED_Blink C ASM)

# Source files
add_executable(LED_Blink.elf
    src/main.c
    src/startup.s
)

# ELF executable
target_compile_options(LED_Blink.elf PRIVATE ${MCU_FLAGS})

# Add compile/link flags explicitly if not in toolchain
target_link_options(LED_Blink.elf PRIVATE
    ${MCU_FLAGS}
    -T${CMAKE_SOURCE_DIR}/linker/stm32f769.ld
    -Wl,--gc-sections
)
# Generate binary after build
add_custom_command(TARGET LED_Blink.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary LED_Blink.elf LED_Blink.bin
)
