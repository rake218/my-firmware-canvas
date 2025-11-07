/* challenges/004-linker-scripts/src/main.c */
volatile unsigned int my_data = 0x12345678;

void _start(void) {
    /* simple function to ensure code is in .text */
    my_data = my_data ^ 0xFFFFFFFF;
    while (1) {}
}
