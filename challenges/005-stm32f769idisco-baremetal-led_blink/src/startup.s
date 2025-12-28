.syntax unified
.cpu cortex-m7
.thumb

.global _start
.global Reset_Handler

.section .isr_vector, "a", %progbits
.word  _estack
.word  Reset_Handler

.section .text.Reset_Handler
Reset_Handler:
    ldr r0, =_estack
    mov sp, r0

    bl main

Hang:
    b Hang
