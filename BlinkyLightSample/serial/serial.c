/* 
	INTERRUPT DRIVEN SERIAL PORT DRIVER FOR UART0 and UART1. 

	This file contains all the serial port components that can be compiled to
	either ARM or THUMB mode.  Components that must be compiled to ARM mode are
	contained in serialISR.c.
*/

/* Standard includes. */
#include <stdlib.h>

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"
#include <stdint.h>

/* Demo application includes. */
#include "serial.h"

/*-----------------------------------------------------------*/

/* Constants to setup and access the UART. */
#define serDLAB						( ( unsigned portCHAR ) 0x80 )
#define serENABLE_INTERRUPTS				( ( unsigned portCHAR ) 0x03 )
#define serNO_PARITY					( ( unsigned portCHAR ) 0x00 )
#define ser1_STOP_BIT					( ( unsigned portCHAR ) 0x00 )
#define ser8_BIT_CHARS					( ( unsigned portCHAR ) 0x03 )
#define serFIFO_ON					( ( unsigned portCHAR ) 0x01 )
#define serCLEAR_FIFO					( ( unsigned portCHAR ) 0x06 )
#define serWANTED_CLOCK_SCALING				( ( unsigned portLONG ) 16 )

/* Constants to setup and access the VIC. */
#define serUART0_VIC_CHANNEL				( ( unsigned portLONG ) (1<<6) )
#define serUART0_VIC_CHANNEL_BIT			( ( unsigned portLONG ) (1<<6) )
#define serUART0_VIC_ENABLE				( ( unsigned portLONG ) (1<<6) )
#define serCLEAR_VIC_INTERRUPT				( ( unsigned portLONG ) 0 )

#define serUART1_VIC_CHANNEL				( ( unsigned portLONG ) (1<<7) )
#define serUART1_VIC_CHANNEL_BIT			( ( unsigned portLONG ) (1<<7) )
#define serUART1_VIC_ENABLE				( ( unsigned portLONG ) (1<<7) )

#define serINVALID_QUEUE				( ( xQueueHandle ) 0 )
#define serHANDLE					( ( xComPortHandle ) 1 )
#define serNO_BLOCK					( ( portTickType ) 0 )

/*-----------------------------------------------------------*/

/* Queues used to hold received characters, and characters waiting to be
transmitted. */
static xQueueHandle xRxedChars; 
static xQueueHandle xCharsForTx; 
static xQueueHandle xRxedChars1; 
static xQueueHandle xCharsForTx1; 

/*-----------------------------------------------------------*/

/* Communication flag between the interrupt service routine and serial API. */
static volatile portLONG *plTHREEmpty;
static volatile portLONG *plTHREEmpty1;
/* 
 * The queues are created in serialISR.c as they are used from the ISR.
 * Obtain references to the queues and THRE Empty flag. 
 */
extern void vSerialISRCreateQueues(portCHAR pxPort,unsigned portBASE_TYPE uxQueueLength, xQueueHandle *pxRxedChars, xQueueHandle *pxCharsForTx, portLONG volatile **pplTHREEmptyFlag );

/*-----------------------------------------------------------*/

xComPortHandle xSerialPortInitMinimal(portCHAR pxPort, unsigned portLONG ulWantedBaud, unsigned portBASE_TYPE uxQueueLength )
{
	unsigned portLONG ulDivisor, ulWantedClock;
	xComPortHandle xReturn = serHANDLE;
	extern void ( vUART_ISR )( void );
	extern void ( vUART_ISR1 )( void );

	switch(pxPort)
	{
		case 0:    
			vSerialISRCreateQueues(0, uxQueueLength, &xRxedChars, &xCharsForTx, &plTHREEmpty );

			if( 
				( xRxedChars != serINVALID_QUEUE ) && 
				( xCharsForTx != serINVALID_QUEUE ) && 
				( ulWantedBaud != ( unsigned portLONG ) 0 ) 
	  			)
			{
				portENTER_CRITICAL();
				{
					/* Setup the baud rate:  Calculate the divisor value. */
					ulWantedClock = ulWantedBaud * serWANTED_CLOCK_SCALING;
					ulDivisor = configCPU_CLOCK_HZ / ulWantedClock;
		
					/* Set the DLAB bit so we can access the divisor. */
					U0LCR |= serDLAB;
	
					/* Setup the divisor. */
					U0DLL = ( unsigned portCHAR ) ( ulDivisor & ( unsigned portLONG ) 0xff );
					ulDivisor >>= 8;
					U0DLM = ( unsigned portCHAR ) ( ulDivisor & ( unsigned portLONG ) 0xff );
		
					/* Turn on the FIFO's and clear the buffers. */
					U0FCR = ( serFIFO_ON | serCLEAR_FIFO );
		
					/* Setup transmission format. */
					U0LCR = serNO_PARITY | ser1_STOP_BIT | ser8_BIT_CHARS;
		
					/* Setup the VIC for the UART. */
					
					VICIntSelect &= ~( serUART0_VIC_CHANNEL_BIT );
					VICVectAddr6 = ( portLONG ) vUART_ISR;
					VICVectCntl6 = serUART0_VIC_CHANNEL | serUART0_VIC_ENABLE;
					VICIntEnable |= serUART0_VIC_CHANNEL_BIT;
		
			/*		
					VICIntSelect &= ~( serUART0_VIC_CHANNEL_BIT );
					VICVectAddr1 = ( portLONG ) vUART_ISR;
					VICVectCntl1 = serUART0_VIC_CHANNEL | serUART0_VIC_ENABLE;
					VICIntEnable |= serUART0_VIC_CHANNEL_BIT;
		*/
					/* Enable UART0 interrupts. */
					U0IER |= serENABLE_INTERRUPTS;
				}
				portEXIT_CRITICAL();
			}
			else
			{
				xReturn = ( xComPortHandle ) 0;
			}
		break;
		case 1:
			/* The queues are used in the serial ISR routine, so are created from
			serialISR.c (which is always compiled to ARM mode. */
			vSerialISRCreateQueues(1, uxQueueLength, &xRxedChars1, &xCharsForTx1, &plTHREEmpty1 );
			if( 
				( xRxedChars1 != serINVALID_QUEUE ) && 
				( xCharsForTx1 != serINVALID_QUEUE ) && 
				( ulWantedBaud != ( unsigned portLONG ) 0 ) 
			  	)
			{
				portENTER_CRITICAL();
				{
					/* Setup the baud rate:  Calculate the divisor value. */
					ulWantedClock = ulWantedBaud * serWANTED_CLOCK_SCALING;
					ulDivisor = configCPU_CLOCK_HZ / ulWantedClock;

					/* Set the DLAB bit so we can access the divisor. */
					U1LCR |= serDLAB;

					/* Setup the divisor. */
					U1DLL = ( unsigned portCHAR ) ( ulDivisor & ( unsigned portLONG ) 0xff );
					ulDivisor >>= 8;
					U1DLM = ( unsigned portCHAR ) ( ulDivisor & ( unsigned portLONG ) 0xff );

					/* Turn on the FIFO's and clear the buffers. */
					U1FCR = ( serFIFO_ON | serCLEAR_FIFO );

					/* Setup transmission format. */
					U1LCR = serNO_PARITY | ser1_STOP_BIT | ser8_BIT_CHARS;

					/* Setup the VIC for the UART. */
					VICIntSelect &= ~( serUART1_VIC_CHANNEL_BIT );
					VICVectAddr2 = ( portLONG ) vUART_ISR1;
					VICVectCntl2 = serUART1_VIC_CHANNEL | serUART1_VIC_ENABLE;
					VICIntEnable |= serUART1_VIC_CHANNEL_BIT;

					/* Enable UART0 interrupts. */
					U1IER |= serENABLE_INTERRUPTS;
				}
				portEXIT_CRITICAL();
			}
			else
			{
				xReturn = ( xComPortHandle ) 0;
			}
			
		break;
	}

	/* The queues are used in the serial ISR routine, so are created from
	serialISR.c (which is always compiled to ARM mode. */

	return xReturn;
}

signed portBASE_TYPE xSerialGetChar( portCHAR pxPort, signed portCHAR *pcRxedChar, portTickType xBlockTime )
{
	switch(pxPort)
	{
		case 0:    
			/* Get the next character from the processCommandBuffer.  Return false if no characters
			are available, or arrive before xBlockTime expires. */
			if( xQueueReceive( xRxedChars, pcRxedChar, xBlockTime ) )
			{
				return pdTRUE;
			}
			else
			{
				return pdFALSE;
			}
		break;
		case 1:
			/* Get the next character from the processCommandBuffer.  Return false if no characters
			are available, or arrive before xBlockTime expires. */
			if( xQueueReceive(  xRxedChars1, pcRxedChar, xBlockTime) )
			{
				return pdTRUE;
			}
			else
			{
				return pdFALSE;
			}	
		break;
	}
	return pdFALSE;
}

void vSerialPutString( portCHAR pxPort, const signed portCHAR * const pcString, portTickType xBlockTime )
{
signed portCHAR *pxNext;


	/* Send each character in the string, one at a time. */
	pxNext = ( signed portCHAR * ) pcString;
	while( *pxNext )
	{
		xSerialPutChar( pxPort, *pxNext, xBlockTime );
		pxNext++;
	}
}

void vSerialPutBinary( portCHAR pxPort, const signed portCHAR * const pcString, const portLONG len, portTickType xBlockTime )
{
        signed portCHAR *pxNext;
        int i;

        /* Send each character in the string, one at a time. */
        pxNext = ( signed portCHAR * ) pcString;
        for(i = 0; i < len; i++ )
        {
                xSerialPutChar( pxPort, *pxNext, xBlockTime );
                pxNext++;
        }
}


signed portBASE_TYPE xSerialPutChar( portCHAR pxPort, signed portCHAR cOutChar, portTickType xBlockTime )
{
signed portBASE_TYPE xReturn = 0;

	switch(pxPort)
	{
		case 0:    
			portENTER_CRITICAL();
			{
				/* Is there space to write directly to the UART? */
				if( *plTHREEmpty == ( portLONG ) pdTRUE )
				{
					/* We wrote the character directly to the UART, so was 
					successful. */
					*plTHREEmpty = pdFALSE;
					U0THR = cOutChar;
					xReturn = pdPASS;
				}
				else 
				{
					/* We cannot write directly to the UART, so queue the character.
					Block for a maximum of xBlockTime if there is no space in the
					queue. */
					xReturn = xQueueSend( xCharsForTx, &cOutChar, xBlockTime );

					/* Depending on queue sizing and task prioritisation:  While we 
					were blocked waiting to post interrupts were not disabled.  It is 
					possible that the serial ISR has emptied the Tx queue, in which
					case we need to start the Tx off again. */
					if( ( *plTHREEmpty == ( portLONG ) pdTRUE ) && ( xReturn == pdPASS ) )
					{
						xQueueReceive( xCharsForTx, &cOutChar, serNO_BLOCK );
						*plTHREEmpty = pdFALSE;
						U0THR = cOutChar;
					}
				}
			}
			portEXIT_CRITICAL();
		break;
		case 1:
			portENTER_CRITICAL();
			{
				/* Is there space to write directly to the UART? */
				if( *plTHREEmpty1 == ( portLONG ) pdTRUE )
				{
					/* We wrote the character directly to the UART, so was 
					successful. */
					*plTHREEmpty1 = pdFALSE;
					U1THR = cOutChar;
					xReturn = pdPASS;
				}
				else 
				{
					/* We cannot write directly to the UART, so queue the character.
					Block for a maximum of xBlockTime if there is no space in the
					queue. */
					xReturn = xQueueSend( xCharsForTx1, &cOutChar, xBlockTime );

					/* Depending on queue sizing and task prioritisation:  While we 
					were blocked waiting to post interrupts were not disabled.  It is 
					possible that the serial ISR has emptied the Tx queue, in which
					case we need to start the Tx off again. */
					if( ( *plTHREEmpty1 == ( portLONG ) pdTRUE ) && ( xReturn == pdPASS ) )
					{
						xQueueReceive( xCharsForTx1, &cOutChar, serNO_BLOCK );
						*plTHREEmpty1 = pdFALSE;
						U1THR = cOutChar;
					}
				}
			}
			portEXIT_CRITICAL();	
		break;
		default:
			return xReturn;
		break;
	}

	return xReturn;
}







