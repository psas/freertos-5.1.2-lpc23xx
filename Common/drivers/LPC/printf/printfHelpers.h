#ifndef PRINTFHELPERS_H_
#define PRINTFHELPERS_H_

#include "FreeRTOS.h"

portCHAR* toString2(portBASE_TYPE x, portCHAR buffer[]);
portCHAR* toString2U(unsigned portBASE_TYPE x, portCHAR buffer[]);

portCHAR* toString(portBASE_TYPE x, portCHAR buffer[], portBASE_TYPE buffSize );
portCHAR* toBinaryString(portBASE_TYPE x, portCHAR buffer[]);
inline long max(long l, long r);

char hexch(const uint8_t x);



#endif /*PRINTFHELPERS_H_*/
