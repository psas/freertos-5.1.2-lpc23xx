/*
	GPIO handling suite
	Jeremy Booth
	Portland State Aeronautical Society
	http://psas.pdx.edu
	

	
	FreeRTOS is free software; you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation; either version 2 of the License, or
        (at your option) any later version.

        FreeRTOS is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with FreeRTOS; if not, write to the Free Software
        Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

        A special exception to the GPL can be applied should you wish to distribute
        a combined work that includes FreeRTOS, without being obliged to provide
        the source code for any proprietary components.  See the licensing section
        of http://www.FreeRTOS.org for full details of how and when the exception
        can be applied.

        ***************************************************************************
        See http://www.FreeRTOS.org for documentation, latest information, license
        and contact details.  Please ensure to read the configuration and relevant
        port sections of the online documentation.
        ***************************************************************************
*/

//#include "helpers.h"  //is this needed?
#include "gpio.h"



#if PROCESSOR_MODEL == LPC2378
/*
 * This is used to initialize a GPIO pin as input or output.
 */
void initFGPIOPin(enum PortNumber portNumber, portLONG ipNumber, enum BOOL input) {
	if( portNumber == PORT0 ) {
		
		if( ipNumber >= 0 && ipNumber <= 15 ) {
			PINSEL0 &= ~(3<< (ipNumber * 2));//clear set the pin into GPIO mode
		} else if( (ipNumber >= 16 && ipNumber <= 30) ) {
			PINSEL1 &= ~(3<< ((ipNumber-16) * 2));//set the pin into GPIO mode		
		} else {
			//FIXME ERROR
		}
		
		if( ipNumber >= 0 && ipNumber <= 30 ) {
			//set the pin as an input or an output
			if( input ) {
				//ZERO_BIT(IO0DIR, ipNumber);
				ZERO_BIT(FIO0DIR, ipNumber);	
			} else {
				//SET_BIT(IO0DIR, ipNumber);
				SET_BIT(FIO0DIR, ipNumber);
			}
		} else {
			//FIXME ERROR	
		}
	} else if( portNumber == PORT1 ) {
		
		if( ipNumber >= 16 && ipNumber <= 25 ) {
			ZERO_BIT(PINSEL2, 3);	//NOTE: this will disable trace support
		} else if( ipNumber >= 26 && ipNumber <= 35 ) {
			ZERO_BIT(PINSEL2, 2);//NOTE: this will disable debug support
		}
		
		if( ipNumber >= 0 && ipNumber <= 30 ) {
			if( input ) {
				//ZERO_BIT(IO1DIR, ipNumber);
				ZERO_BIT(FIO1DIR, ipNumber);
			} else {
				//SET_BIT(IO1DIR, ipNumber);
				SET_BIT(FIO1DIR, ipNumber);
			}
		} else {
			//FIXME ERROR	
		}
	} else {
		//FIXME error	
	}	
}
#endif
