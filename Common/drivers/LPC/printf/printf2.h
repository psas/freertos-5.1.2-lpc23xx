#ifndef PRINTF_H_
#define PRINTF_H_

#include "FreeRTOS.h"
#include <stdarg.h>
#include <stdint.h>

#define STDOUT_FD  1
#define STDERR_FD  2

int print(const int fd, const char *format, va_list args );
int printf2(const char *format, ...);
int fprintf2(const int fd, const char *format, ...);
char hexch(const uint8_t x);


#endif /*PRINTF_H_*/
