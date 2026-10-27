#define GPIO_BASE 0x41200000

#define LED_REG    *(volatile unsigned int *)(GPIO_BASE + 0x00)
#define BUTTON_REG *(volatile unsigned int *)(GPIO_BASE + 0x08)

#define DELAY         100000000
#define POLL_INTERVAL 100000

void delay_with_buttons(unsigned int blink_state)
{
    for (unsigned int elapsed = 0;
         elapsed < DELAY;
         elapsed += POLL_INTERVAL)
    {
        // Leer los cuatro botones
        unsigned int buttons = BUTTON_REG & 0xF;

        // Combinar el estado del parpadeo con los botones
        LED_REG = blink_state | buttons;

        // Pequeño intervalo antes de volver a consultar botones
        for (volatile int i = 0; i < POLL_INTERVAL; i++);
    }
}

int main()
{
    while(1)
    {
        // Fase ON
        delay_with_buttons(0xF);

        // Fase OFF
        delay_with_buttons(0x0);
    }

    return 0;
}