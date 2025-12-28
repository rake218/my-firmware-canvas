.syntax unified
.cpu cortex-m7
.thumb

/* Symbols for linker */
.global Reset_Handler
.global _estack

/* Vector table: first entry = stack, second = reset handler */
.section .isr_vector,"a",%progbits
.word _estack          /* Initial stack pointer */
.word Reset_Handler    /* Reset handler entry point */

.section .text

/* Reset Handler */
Reset_Handler:
    /* Initialize BSS (zero uninitialized data) */
    ldr r0, =_sbss       /* Start of BSS */
    ldr r1, =_ebss       /* End of BSS */
zero_bss:
    cmp r0, r1
    it lt
    movlt r2, #0
    strlt r2, [r0], #4   /* Zero each word */
    blt zero_bss

    /* Call main() function in C */
    bl main

hang:
    b hang               /* Infinite loop if main returns */
