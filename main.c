

#include <s5pv310.h>

static int TestArray[100];
static int TestArray2[2] = {1,2};


unsigned char MainStackAddr = 0x40200000;

unsigned char MainStack[1024*8];
unsigned char ExceptStack[1024*8];

typedef struct {
        volatile unsigned long ULCON;
        volatile unsigned long UCON;
        volatile unsigned long UFCON;
        volatile unsigned long UMCON;
        volatile unsigned long UTRSTAT;
        volatile unsigned long UERSTAT;
        volatile unsigned long UFSTAT;
        volatile unsigned long UMSTAT;
        volatile unsigned char UTXH;
        volatile unsigned char res1[3];
        volatile unsigned char URXH;
        volatile unsigned char res2[3];
        volatile unsigned long UBRDIV;
    } S5PC11X_UART;

void uart_putc(char ch) {
    

    S5PC11X_UART *const uart = (S5PC11X_UART *)0x13800000;

    while (!(uart->UTRSTAT & 0x2));

    uart->UTXH = ch;
}


void kmain(void)
{
	int i,j;

	i = 0;
	j = 1;
	i = j;

	uart_putc('O');
	uart_putc('S');
	uart_putc('P');
	uart_putc('R');
	uart_putc('O');
	uart_putc('J');
	uart_putc('E');
	uart_putc('C');
	uart_putc('T');
	uart_putc(' ');
	uart_putc('T');
	uart_putc('E');
	uart_putc('S');
	uart_putc('T');
	uart_putc('!');

	while(1)
	{

	}
}
