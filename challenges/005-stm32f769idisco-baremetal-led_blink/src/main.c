/* STM32F769I Discovery LED Blink (bare-metal) */

/* Register addresses */
#define RCC_AHB1ENR   (*(volatile unsigned int*)0x40023830)  /* Clock enable register */
#define GPIOI_MODER   (*(volatile unsigned int*)0x40022000)  /* GPIO mode register */
#define GPIOI_ODR     (*(volatile unsigned int*)0x40022014)  /* GPIO output data register */

/* Simple delay loop */
void delay(volatile unsigned int t)
{
    while(t--);  /* Do nothing, just burn cycles */
}

int main(void)
{
    /* Enable GPIOI clock (bit 8 = GPIOI) */
    RCC_AHB1ENR |= (1 << 8);

    /* Configure PI1 as output */
    GPIOI_MODER &= ~(3 << (2*1)); /* Clear mode bits for PI1 */
    GPIOI_MODER |=  (1 << (2*1)); /* Set as output (01) */

    /* Infinite loop: toggle LED */
    while (1)
    {
        GPIOI_ODR ^= (1 << 1);   /* Toggle PI1 */
        delay(1000000);          /* Simple software delay */
    }
}
