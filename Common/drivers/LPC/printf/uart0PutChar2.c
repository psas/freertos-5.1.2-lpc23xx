
#include "printf/uart0PutChar2.h"

void uart0_putchar2(const portCHAR ch) {
	portCHAR buff[2];
	buff[0] = ch;
	buff[1] = '\0';
	vSerialPutString(0, buff, 5);
}
