/*
	FreeRTOS V3.0.0 - Copyright (C) 2003 - 2005 Richard Barry.

	This file is part of the FreeRTOS distribution.

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


/* 
	BASIC INTERRUPT DRIVEN SERIAL PORT DRIVER FOR UART0. 

	This file contains all the serial port components that must be compiled
	to ARM mode.  The components that can be compiled to either ARM or THUMB
	mode are contained in serial.c.

*/

/* Standard includes. */
#include <stdlib.h>

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"

/* Demo application includes. */
#include "serial.h"

/*-----------------------------------------------------------*/

/* Constant to access the VIC. */
#define serCLEAR_VIC_INTERRUPT				( ( unsigned portLONG ) 0 )

/* Constants to determine the ISR source. */
#define serSOURCE_THRE					( ( unsigned portCHAR ) 0x02 )
#define serSOURCE_RX_TIMEOUT				( ( unsigned portCHAR ) 0x0c )
#define serSOURCE_ERROR					( ( unsigned portCHAR ) 0x06 )
#define serSOURCE_RX					( ( unsigned portCHAR ) 0x04 )
#define serINTERRUPT_SOURCE_MASK			( ( unsigned portCHAR ) 0x0f )

/* Queues used to hold received characters, and characters waiting to be
transmitted. */
static xQueueHandle xRxedChars; 
static xQueueHandle xCharsForTx; 
static volatile portLONG lTHREEmpty;

static xQueueHandle xRxedChars1; 
static xQueueHandle xCharsForTx1; 
static volatile portLONG lTHREEmpty1;

/*-----------------------------------------------------------*/

/* 
 * The queues are created in serialISR.c as they are used from the ISR.
 * Obtain references to the queues and THRE Empty flag. 
 */
void vSerialISRCreateQueues(portCHAR pxPort, unsigned portBASE_TYPE uxQueueLength, xQueueHandle *pxRxedChars, xQueueHandle *pxCharsForTx, portLONG volatile **pplTHREEmptyFlag );

/* UART0 interrupt service routine.  This can cause a context switch so MUST
be declared "naked". */
void vUART_ISR( void ) __attribute__ ((naked));
void vUART_ISR1( void ) __attribute__ ((naked));

/*-----------------------------------------------------------*/
void vSerialISRCreateQueues(portCHAR pxPort, unsigned portBASE_TYPE uxQueueLength, xQueueHandle *pxRxedChars, 
								xQueueHandle *pxCharsForTx, portLONG volatile **pplTHREEmptyFlag )
{

	switch(pxPort)
	{
		case 0:    
			/* Create the queues used to hold Rx and Tx characters. */
			xRxedChars = xQueueCreate( uxQueueLength, ( unsigned portBASE_TYPE ) sizeof( signed portCHAR ) );
			xCharsForTx = xQueueCreate( uxQueueLength + 1, ( unsigned portBASE_TYPE ) sizeof( signed portCHAR ) );

			/* Pass back a reference to the queues so the serial API file can 
			post/receive characters. */
			*pxRxedChars = xRxedChars;
			*pxCharsForTx = xCharsForTx;

			/* Initialise the THRE empty flag - and pass back a reference. */
			lTHREEmpty = ( portLONG ) pdTRUE;
			*pplTHREEmptyFlag = &lTHREEmpty;
		break;
		case 1:
			xRxedChars1 = xQueueCreate( uxQueueLength, ( unsigned portCHAR ) sizeof( signed portCHAR ) );
			xCharsForTx1 = xQueueCreate( uxQueueLength + 1, ( unsigned portCHAR ) sizeof( signed portCHAR ) );

			/* Pass back a reference to the queues so the serial API file can 
			post/receive characters. */
			*pxRxedChars = xRxedChars1;
			*pxCharsForTx = xCharsForTx1;
	

			/* Initialise the THRE empty flag - and pass back a reference. */
			lTHREEmpty1 = ( portLONG ) pdTRUE;
			*pplTHREEmptyFlag = &lTHREEmpty1;	
		break;
	}
}
/*-----------------------------------------------------------*/

void vUART_ISR( void )
{
	/* This ISR can cause a context switch, so the first statement must be a
	call to the portENTER_SWITCHING_ISR() macro.  This must be BEFORE any
	variable declarations. */
	//portENTER_SWITCHING_ISR();
	portSAVE_CONTEXT();
	
	/* Now we can declare the local variables. */
	signed portCHAR cChar;
	portBASE_TYPE xTaskWokenByTx = pdFALSE, xTaskWokenByRx = pdFALSE;

	/* What caused the interrupt? */
	switch( U0IIR & serINTERRUPT_SOURCE_MASK )
	{
		case serSOURCE_ERROR :	/* Not handling this, but clear the interrupt. */
								cChar = U0LSR;
								break;

		case serSOURCE_THRE	:	/* The THRE is empty.  If there is another
								character in the Tx queue, send it now. */
								if( xQueueReceiveFromISR( xCharsForTx, &cChar, &xTaskWokenByTx ) == pdTRUE )
								{
									U0THR = cChar;
								}
								else
								{
									/* There are no further characters 
									queued to send so we can indicate 
									that the THRE is available. */
									lTHREEmpty = pdTRUE;
								}
								break;

		case serSOURCE_RX_TIMEOUT :
		case serSOURCE_RX	:	/* A character was received.  Place it in 
								the queue of received characters. */
								cChar = U0RBR;
								if( xQueueSendFromISR( xRxedChars, &cChar, ( portBASE_TYPE ) pdFALSE ) ) 
								{
									xTaskWokenByRx = pdTRUE;
								}
								break;

		default				:	/* There is nothing to do, leave the ISR. */
								break;
	}

	/* Clear the ISR in the VIC. */
	VICVectAddr = serCLEAR_VIC_INTERRUPT;

	/* Exit the ISR.  If a task was woken by either a character being received
	or transmitted then a context switch will occur. */
	//portEXIT_SWITCHING_ISR( ( xTaskWokenByTx || xTaskWokenByRx ) );
	portRESTORE_CONTEXT(); 
}

/*-----------------------------------------------------------*/
void vUART_ISR1( void )
{
	/* This ISR can cause a context switch, so the first statement must be a
	call to the portENTER_SWITCHING_ISR() macro.  This must be BEFORE any
	variable declarations. */
	//portENTER_SWITCHING_ISR();
	portSAVE_CONTEXT(); 
	
	
	/* Now we can declare the local variables. */
	signed portCHAR cChar;
	portBASE_TYPE xTaskWokenByTx = pdFALSE, xTaskWokenByRx = pdFALSE;

	switch( U1IIR & serINTERRUPT_SOURCE_MASK )
	{
		case serSOURCE_ERROR :	/* Not handling this, but clear the interrupt. */
								cChar = U1LSR;
								break;

		case serSOURCE_THRE	:	/* The THRE is empty.  If there is another
								character in the Tx queue, send it now. */
								if( xQueueReceiveFromISR( xCharsForTx1, &cChar, &xTaskWokenByTx ) == pdTRUE )
								{
									U1THR = cChar;
								}
								else
								{
									/* There are no further characters 
									queued to send so we can indicate 
									that the THRE is available. */
									lTHREEmpty1 = pdTRUE;
								}
								break;

		case serSOURCE_RX_TIMEOUT :
		case serSOURCE_RX	:	/* A character was received.  Place it in 
								the queue of received characters. */
								cChar = U1RBR;
								if( xQueueSendFromISR( xRxedChars1, &cChar, ( portBASE_TYPE ) pdFALSE ) ) 
								{
									xTaskWokenByRx = pdTRUE;
								}

		default				:	/* There is nothing to do, leave the ISR. */
								break;
	}
	/* Clear the ISR in the VIC. */
	VICVectAddr = serCLEAR_VIC_INTERRUPT;

	/* Exit the ISR.  If a task was woken by either a character being received
	or transmitted then a context switch will occur. */
	//portEXIT_SWITCHING_ISR( ( xTaskWokenByTx || xTaskWokenByRx ) );
	portRESTORE_CONTEXT(); 
}





	
