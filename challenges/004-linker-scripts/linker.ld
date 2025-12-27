/* challenges/004-linker-scripts/linker.ld */
ENTRY(_start)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x08004000, LENGTH = 128K
  RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

/* Place the sections */
SECTIONS
{
  /* Force the linker to start allocating at FLASH origin */
  . = ORIGIN(FLASH);
  .text ALIGN(4) : 
  {
    KEEP(*(.vectors))   /* preserve interrupt vector if any */
    *(.text*)
    *(.rodata*)
    . = ALIGN(4);
  } > FLASH

  .data : 
  {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > RAM AT> FLASH

  .bss (NOLOAD) :
  {
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
  } > RAM

  /DISCARD/ : { *(.comment) }
}
