#ifndef PRINTFHELPERS_C_
#define PRINTFHELPERS_C_

#include "FreeRTOS.h"
#include <stdint.h>

#define PRINTF_STRING_BUFFER_SIZE 64

portCHAR buffer[PRINTF_STRING_BUFFER_SIZE];



inline long max(long l, long r) {
	if( l >= r ) {
		return(l);
	} 
	return(r);
}

/* While I'm not a fan of re-inventing the wheel, sprintf seems to cause a alot
 * problems with generating code that will crash the MCU.  
 */
portCHAR* toString2(portBASE_TYPE x, portCHAR buffer[]) {
        portLONG var = x;
        portLONG modVal, divVal;
        portCHAR buffer2[PRINTF_STRING_BUFFER_SIZE];
        
        if( x == 0 ) {
        	buffer[0] = '0';
        	buffer[1] = '\0';
        	return(buffer);	
        }
        
        int i = 0, i2;

        if( var < 0 ) {
                var = (var * (-1));
        }

        for(;;) {
                if( var == 0 )
                        break;

                modVal = (var % 10);
                divVal = (var / 10);
                buffer2[i] = 48 + modVal;

                var = divVal;
                i++;
                //printf("varZ=%li\n", var);
        }
        i--;
        //buffer2[i] = '\0';

        i2=0;
        if( x < 0 ) {
               buffer[i2] = '-';
               i2++;
        }
        
        //printf("i=%li\n", i);
        //printf("i2=%li\n", i2);
        for(; i >= 0 ; i2++ ) {
                //printf("i=%li\n", i);
                //printf("i2=%li\n", i2);
                buffer[i2] = buffer2[i];
                if( i == 0 ) {
                        i2++;
                        break;
                }
                i--;
        }

        //printf("i end=%li\n", i);
        //printf("i2 end=%li\n", i2);
        buffer[i2] = '\0';

        return(buffer);
}

portCHAR* toString2U(unsigned portBASE_TYPE x, portCHAR buffer[]) {
	    unsigned portLONG var = x;
	    unsigned portLONG modVal, divVal;
        portCHAR buffer2[PRINTF_STRING_BUFFER_SIZE];
        
        if( x == 0 ) {
        	buffer[0] = '0';
        	buffer[1] = '\0';
        	return(buffer);	
        }
        
        int i = 0, i2;

        if( var < 0 ) {
                var = (var * (-1));
        }

        for(;;) {
                if( var == 0 )
                        break;

                modVal = (var % 10);
                divVal = (var / 10);
                buffer2[i] = 48 + modVal;

                var = divVal;
                i++;
                //printf("varZ=%li\n", var);
        }
        i--;
        //buffer2[i] = '\0';

        i2=0;
        if( x < 0 ) {
               buffer[i2] = '-';
               i2++;
        }
        
        //printf("i=%li\n", i);
        //printf("i2=%li\n", i2);
        for(; i >= 0 ; i2++ ) {
                //printf("i=%li\n", i);
                //printf("i2=%li\n", i2);
                buffer[i2] = buffer2[i];
                if( i == 0 ) {
                        i2++;
                        break;
                }
                i--;
        }

        //printf("i end=%li\n", i);
        //printf("i2 end=%li\n", i2);
        buffer[i2] = '\0';

        return(buffer);
}

portCHAR* toString(portBASE_TYPE x, portCHAR buffer[], portBASE_TYPE buffSize ) {
	return(toString2(x,buffer));
}

portCHAR* toBinaryString(portBASE_TYPE y, portCHAR buffer[]) {
		portLONG x = y;
		int i, i2;
		
		//for(i = 0; i < ((int) sizeof(processCommandBuffer)); i++ ) {
		//	processCommandBuffer[i] = '\0';	
		//}
		
		for(i = 31, i2=0; i >= 0; i--, i2++ ) {
			int temp = (1 & (x>>i));
			if( temp ) 
				buffer[i2] = '1';
			else
				buffer[i2] = '0';
			
			if( i % 8 == 0 ) {
				i2++;
				buffer[i2] = ' ';	
			}
		}
		buffer[i2] = '\0';
		
		return(buffer);
}


#endif /*PRINTFHELPERS_C_*/
