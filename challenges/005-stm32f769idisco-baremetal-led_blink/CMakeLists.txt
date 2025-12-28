cmake_minimum_required(VERSION 3.15)

project(LED_Blink C ASM)

set(MCU_FLAGS "-mcpu=cortex-m7 -mthumb -O0 -g -ffreestanding -nostdlib")

add_executable(LED_Blink.elf
    src/main.c
    src/startup.s
)

target_compile_options(LED_Blink.elf PRIVATE ${MCU_FLAGS})

target_link_options(LED_Blink.elf PRIVATE
    ${MCU_FLAGS}
    -T${CMAKE_SOURCE_DIR}/linker/stm32f769.ld
    -Wl,--gc-sections
)

add_custom_command(TARGET LED_Blink.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary LED_Blink.elf LED_Blink.bin
)
