set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)

# Tell CMake this is freestanding
set(CMAKE_C_FLAGS "-mcpu=cortex-m7 -mthumb -O0 -g -ffreestanding -nostdlib")
set(CMAKE_ASM_FLAGS "-mcpu=cortex-m7 -mthumb")
set(CMAKE_EXE_LINKER_FLAGS "-T${CMAKE_SOURCE_DIR}/linker/stm32f769.ld -nostdlib")