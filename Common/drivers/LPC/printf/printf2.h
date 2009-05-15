#ifndef PRINTF_H_
#define PRINTF_H_

#include "FreeRTOS.h"
#include <stdarg.h>

int print(const char *format, va_list args );
int printf2(const char *format, ...);

#endif /*PRINTF_H_*/
