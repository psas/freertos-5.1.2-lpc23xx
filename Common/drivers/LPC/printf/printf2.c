#include "printf2.h"

void putchar2(const int fd, const int ch);

#define NUM_BUFF_LENGTH 20
char buffer2[NUM_BUFF_LENGTH];

/* Description: Converts an unsigned integer to an ascii string, placing it into the buffer specified by buffer.
 *
 *   While I'm not a fan of re-inventing the wheel, sprintf seems to cause a alot
 *   problems with generating code that will crash the MCU.
 *
 *
 * Parameters:
 *   -x: The number to convert to ascii.
 *   -buffer[]: The buffer into which you want the ascii representation of the number to be placed.
 *   -buffSize: The length of the buffer, which is not to be excedded.
 *
 * Return Value(s): The address of the start of "buffer"
 *
 */
char* printf2_uitoa(const uint32_t x, char buffer[], const int buffSize) {
	uint32_t var = x;
	uint32_t modVal, divVal;

	if (x == 0) {
		buffer[0] = '0';
		buffer[1] = '\0';
		return (buffer);
	}

	int32_t i = 0, i2;

	for (;;) {
		if (var == 0)
			break;

		if ((i-1) >= NUM_BUFF_LENGTH) {
			break;
		}

		modVal = (var % 10);
		divVal = (var / 10);
		buffer2[i] = 48 + modVal;

		var = divVal;
		i++;
	}
	i--;

	i2=0;

	for (; i >= 0; i2++) {
		buffer[i2] = buffer2[i];
		if (i == 0) {
			i2++;
			break;
		}
		i--;
	}

	buffer[i2] = '\0';

	return (buffer);
}


/* Description: Converts an integer to an ascii string, placing it into the buffer specified by buffer.
 *
 *      While I'm not a fan of re-inventing the wheel, sprintf seems to cause a alot
 *      problems with generating code that will crash the MCU.
 *
 * Parameters:
 *   -x: The number to convert to ascii.
 *   -buffer[]: The buffer into which you want the ascii representation of the number to be placed.
 *   -buffSize: The length of the buffer, which is not to be excedded.
 *
 * Return Value(s): The address of the start of "buffer"
 *
 */
char* printf2_itoa(const int32_t x, char buffer[], const int buffSize) {
	int32_t var = x;
	int32_t modVal, divVal;

	if (x == 0) {
		buffer[0] = '0';
		buffer[1] = '\0';
		return (buffer);
	}

	int32_t i = 0, i2;

	if (var < 0) {
		var = (var * (-1));
	}

	for (;;) {
		if (var == 0)
			break;

		if ((i-1) >= NUM_BUFF_LENGTH) {
			break;
		}

		modVal = (var % 10);
		divVal = (var / 10);
		buffer2[i] = 48 + modVal;

		var = divVal;
		i++;
	}
	i--;

	i2=0;
	if (x < 0) {
		buffer[i2] = '-';
		i2++;
	}

	for (; i >= 0; i2++) {
		//printf("i=%li\n", i);
		//printf("i2=%li\n", i2);
		buffer[i2] = buffer2[i];
		if (i == 0) {
			i2++;
			break;
		}
		i--;
	}

	buffer[i2] = '\0';

	return (buffer);
}


int printf2Debug(const char *format, ...) {
    va_list args;
    va_start( args, format );
    int ret = print(STDERR_FD, format, args);
    return(ret);
}

int printf2(const char *format, ...) {
    va_list args;
    va_start( args, format );

    int ret = print(STDOUT_FD, format, args);
    return(ret);
}

int fprintf2(const int fd, const char *format, ...) {
    va_list args;
    va_start( args, format );

    int ret = print(fd, format, args);
    return(ret);
}

static void printUnsignedInt(const int fd, const unsigned int valToPrint) {
	char buff[12];
	char *ptr = buff;

	printf2_uitoa(valToPrint, buff, 12);

	for( ;*ptr != '\0';ptr++ ) {
		putchar2(fd, *ptr);
	}
}

static void printSignedInt(const int fd, const int valToPrint) {
	char buff[12];
	char *ptr = buff;

	printf2_itoa(valToPrint, buff, 12);

	for( ;*ptr != '\0';ptr++ ) {
		putchar2(fd, *ptr);
	}
}

static void printDouble(const int fd, const double d) {
	double d2 = d;
	if( d2 < 0.0 ) {
		d2 *= -1.0;
		putchar2(fd, '-');
	}

	const uint32_t largePart = d2;

	double dsmallPart = d2 - largePart;

	printUnsignedInt(fd, largePart);

	putchar2(fd, '.');

	int i;
	for(i = 0; i < 10; i++) {
		dsmallPart *= 10;

		const uint32_t num = dsmallPart;
		putchar2(fd, '0' + num);
		dsmallPart -= num;

		if( dsmallPart == 0.0 ) {
			break;
		}
	}
}

/*
 * Note: This is a bare minimum initial cut at printf function, specifically to avoid licencing issues with the other version
 * of printf previously in use. This should provide minimum functionality for beta and production
 * release, and it would be of interest to be cleaned up further and made tighter/faster later on.
 *
*/
int print(const int fd, const char *format, va_list args ) {
	 const char *curFormatPtr = format;
	 int i;

	 for( ;*curFormatPtr != '\0'; curFormatPtr++ ) {
		 if( *curFormatPtr != '%' ) {
			 putchar2(fd, *curFormatPtr);
		 } else {
			 curFormatPtr++;
			 if( *curFormatPtr == '\0') {
				 break;
			 }

			 if( *curFormatPtr == 'd') {
				 const int valToPrint = va_arg( args, int );
				 printSignedInt(fd, valToPrint);

			 } else if( *curFormatPtr == 'f') {
 				 const double valToPrint = va_arg( args, double );
 				 printDouble(fd, valToPrint);

			 } else if( *curFormatPtr == 'u') {
				 const unsigned int valToPrint = va_arg( args, unsigned int );
				 printUnsignedInt(fd, valToPrint);

			 } else if( *curFormatPtr == 'X') {
				 unsigned int valToPrint = va_arg( args, unsigned int );
				 if( valToPrint == 0 ) {
					 putchar2(fd, '0');
					 putchar2(fd, '0');
				 } else {
					 char printSubsiquentFlag = 0;
					 for(i = 0; i < 8; i++ ) {
						 const unsigned int v = (valToPrint & 0xF0000000) >> 28;
						 if( v != 0 || printSubsiquentFlag ) {
							 printSubsiquentFlag = 1;
							 putchar2(fd, hexch(v));
						 }
						 valToPrint = valToPrint << 4;
					 }
					 if( ! printSubsiquentFlag ) {
						 putchar2(fd, '0');
					 }
				 }

			 } else if( *curFormatPtr == 's') {
				 char *s = (char *) va_arg( args, int );
				 for(;*s != '\0'; s++ ) {
					 putchar2(fd, *s);
				 }

			 } else if( *curFormatPtr == 'c') {
				char ch = (char)va_arg( args, int );
				putchar2(fd, ch);
			 } else if( *curFormatPtr == '%') {
				 putchar2(fd, '%');

			 } else {
				 //dont know what to do with this format string
				 putchar2(fd, '%');
				 putchar2(fd, *curFormatPtr);
			 }
		 }
	 }

	 return 0;

}

/* Description: Converts a number to it's hex character
 *
 * Parameters:
 *   -x: The number for which you want the hex value for, must be less then 16.
 *
 * Return Value(s): The hex character for the number passed in
 *
 */
char hexch(const uint8_t x) {
	if( x < 10 ) {
		return('0' + x);
	} else if( x < 16 ) {
		return('A' + (x-10));
	} else {
		return('?');
	}
}



































