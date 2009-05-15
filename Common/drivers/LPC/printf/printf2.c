
#include "printf2.h"

void printUnsignedInt(const unsigned int valToPrint) {
	char buff[12];
	char *ptr = buff;
	
	toString2U(valToPrint, buff);

	for( ;*ptr != '\0';ptr++ ) {
		putchar2(*ptr);
	}
}

void printSignedInt(const int valToPrint) {
	char buff[12];
	char *ptr = buff;
	
	toString2(valToPrint, buff);

	for( ;*ptr != '\0';ptr++ ) {
		putchar2(*ptr);
	}
}

int printf2(const char *format, ...) {
    va_list args;
    va_start( args, format );
    int ret = print(format, args);
    return(ret);
}

/*
 * Note: This is a bare minimum initial cut at printf function, specifically to avoid licencing issues with the other version
 * of printf previously in use. This should provide minimum functionality for beta and production 
 * release, and it would be of interest to be cleaned up further and made tighter/faster later on.
 * 
*/
int print(const char *format, va_list args ) {
	 
	 const char *curFormatPtr = format;
	 int i;
	 
	 for( ;*curFormatPtr != '\0'; curFormatPtr++ ) {
		 if( *curFormatPtr != '%' ) {
			 putchar2(*curFormatPtr);
		 } else {
			 curFormatPtr++;
			 if( *curFormatPtr == '\0') {
				 break;
			 }
			 
			 if( *curFormatPtr == 'd') {
				 int valToPrint = va_arg( args, int );
				 printSignedInt(valToPrint);
				 
			 } else if( *curFormatPtr == 'u') {
				 unsigned int valToPrint = va_arg( args, unsigned int );
				 printUnsignedInt(valToPrint);

			 } else if( *curFormatPtr == 'X') {
				 unsigned int valToPrint = va_arg( args, unsigned int );
				 if( valToPrint == 0 ) {
					 putchar2('0');
					 putchar2('0');
				 } else {
					 char printSubsiquentFlag = 0;
					 for(i = 0; i < 8; i++ ) {
						 unsigned int v = (valToPrint & 0xF0000000) >> 28;
						 if( v != 0 || printSubsiquentFlag ) {
							 printSubsiquentFlag = 1;
							 putchar2(hexch(v));
						 }
						 valToPrint = valToPrint << 4;
					 }
					 if( ! printSubsiquentFlag ) {
						 putchar2('0');
					 }
				 }
				 
			 } else if( *curFormatPtr == 's') {
				 char *s = (char *) va_arg( args, int );
				 for(;*s != '\0'; s++ ) {
					 putchar2(*s);
				 }
				 
			 } else if( *curFormatPtr == 'c') {
				char ch = (char)va_arg( args, int );
				putchar2(ch);
			 } else if( *curFormatPtr == '%') {
				 putchar2('%');
				 
			 } else {
				 //dont know what to do with this format string
				 putchar2('%');
				 putchar2(*curFormatPtr);
			 }
		 }
		 
		 
	 }
	 
	 return 0;

}
