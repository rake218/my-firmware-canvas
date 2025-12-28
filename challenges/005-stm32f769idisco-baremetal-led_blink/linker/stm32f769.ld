/* STM32F769I-Discovery linker script for bare-metal firmware */

/* Define memory regions */
MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 2048K   /* Flash memory for code */
    RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 512K    /* SRAM for data and stack */
}

/* Stack pointer symbol (end of RAM) */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    /* Interrupt vector table at the beginning of flash */
    .isr_vector :
    {
        KEEP(*(.isr_vector))  /* Keep vector table symbols */
    } > FLASH

    /* Code section (text + read-only data) */
    .text :
    {
        *(.text*)             /* All text/code sections */
        *(.rodata*)           /* Read-only data */
    } > FLASH

    /* Initialized data copied from flash to RAM at startup */
    .data : AT(ADDR(.text) + SIZEOF(.text))
    {
        _sdata = .;           /* Start of data in RAM */
        *(.data*)
        _edata = .;           /* End of data */
    } > RAM

    /* Uninitialized data (BSS) */
    .bss :
    {
        _sbss = .;            /* Start of BSS */
        *(.bss*)
        *(COMMON)
        _ebss = .;            /* End of BSS */
    } > RAM
}
