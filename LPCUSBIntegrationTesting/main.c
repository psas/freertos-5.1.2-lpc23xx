/*
	FreeRTOS.org V5.1.2 - Copyright (C) 2003-2009 Richard Barry.

	This file is part of the FreeRTOS.org distribution.

	FreeRTOS.org is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	FreeRTOS.org is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with FreeRTOS.org; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

	A special exception to the GPL can be applied should you wish to distribute
	a combined work that includes FreeRTOS.org, without being obliged to provide
	the source code for any proprietary components.  See the licensing section 
	of http://www.FreeRTOS.org for full details of how and when the exception
	can be applied.

    ***************************************************************************
    ***************************************************************************
    *                                                                         *
    * Get the FreeRTOS eBook!  See http://www.FreeRTOS.org/Documentation      *
	*                                                                         *
	* This is a concise, step by step, 'hands on' guide that describes both   *
	* general multitasking concepts and FreeRTOS specifics. It presents and   *
	* explains numerous examples that are written using the FreeRTOS API.     *
	* Full source code for all the examples is provided in an accompanying    *
	* .zip file.                                                              *
    *                                                                         *
    ***************************************************************************
    ***************************************************************************

	Please ensure to read the configuration and relevant port sections of the
	online documentation.

	http://www.FreeRTOS.org - Documentation, latest information, license and 
	contact details.

	http://www.SafeRTOS.com - A version that is certified for use in safety 
	critical systems.

	http://www.OpenRTOS.com - Commercial support, development, porting, 
	licensing and training services.
*/

/*
 * Creates all the demo application tasks, then starts the scheduler.  The WEB
 * documentation provides more details of the standard demo application tasks.
 * In addition to the standard demo tasks, the following tasks and tests are
 * defined and/or created within this file:
 *
 * "LCD" task - the LCD task is a 'gatekeeper' task.  It is the only task that
 * is permitted to access the display directly.  Other tasks wishing to write a
 * message to the LCD send the message on a queue to the LCD task instead of
 * accessing the LCD themselves.  The LCD task just blocks on the queue waiting
 * for messages - waking and displaying the messages as they arrive.
 *
 * "Check" hook -  This only executes every five seconds from the tick hook.
 * Its main function is to check that all the standard demo tasks are still 
 * operational.  Should any unexpected behaviour within a demo task be discovered 
 * the tick hook will write an error to the LCD (via the LCD task).  If all the 
 * demo tasks are executing with their expected behaviour then the check task 
 * writes PASS to the LCD (again via the LCD task), as described above.
 *
 * "uIP" task -  This is the task that handles the uIP stack.  All TCP/IP
 * processing is performed in this task.
 */

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "portmacro.h"

/* Demo app includes. */
#include "BlockQ.h"
#include "death.h"
#include "blocktim.h"
#include "flash.h"
#include "partest.h"
#include "GenQTest.h"
#include "QPeek.h"
#include "dynamic.h"


#include "debug.h"
#include "usbapi.h"
#include "usbhw_lpc.h"








#define INT_IN_EP		0x81

#define ISOC_OUT_EP     0x06
#define ISOC_IN_EP      0x83

#define MAX_PACKET_SIZE	128

#define LE_WORD(x)		((x)&0xFF),((x)>>8)

#define BYTES_PER_ISOC_FRAME    4

U32 inputIsocDataBuffer[(BYTES_PER_ISOC_FRAME/4)];

#define ISOC_OUTPUT_DATA_BUFFER_SIZE    1024

volatile U8 outputIsocDataBuffer[ISOC_OUTPUT_DATA_BUFFER_SIZE];

int isConnectedFlag = 0;

U8 bDevStat = 0;







//static U8 abBulkBuf[64];
static U8 abClassReqData[8];

// forward declaration of interrupt handler
static void USBIntHandler(void) __attribute__ ((interrupt(IRQ), naked));

static const U8 abDescriptors[] = {

// device descriptor
	0x12,
	DESC_DEVICE,
	LE_WORD(0x0101),			// bcdUSB
	0x02,						// bDeviceClass
	0x00,						// bDeviceSubClass
	0x00,						// bDeviceProtocol
	MAX_PACKET_SIZE0,			// bMaxPacketSize
	LE_WORD(0xFFFF),			// idVendor
	LE_WORD(0x0005),			// idProduct
	LE_WORD(0x0100),			// bcdDevice
	0x01,						// iManufacturer
	0x02,						// iProduct
	0x03,						// iSerialNumber
	0x01,						// bNumConfigurations

// configuration descriptor
	0x09,
	DESC_CONFIGURATION,
	LE_WORD(32), //sizeof(this configuration descriptor) + sizeof(all interfaces defined)   //LE_WORD(67),				// wTotalLength
	0x01, //0x02,				// bNumInterfaces
	0x01,						// bConfigurationValue
	0x00,						// iConfiguration
	0xC0,						// bmAttributes
	0x32,						// bMaxPower
	
// data class interface descriptor   9+7+7=23
	0x09,
	DESC_INTERFACE,
	0x00,						// bInterfaceNumber
	0x00,						// bAlternateSetting
	0x02,//DC				    // bNumEndPoints
	0xFF,// 0x0A,				// bInterfaceClass = data
	0x00,						// bInterfaceSubClass
	0x00,						// bInterfaceProtocol
	0x00,						// iInterface
	
// data EP OUT
	0x07,
	DESC_ENDPOINT,
	ISOC_OUT_EP,				// bEndpointAddress
	0x0D,					    // bmAttributes = isoc, syncronous, data endpoint
	LE_WORD(MAX_PACKET_SIZE),	// wMaxPacketSize
	0x01,						// bInterval	
	
	// data EP OUT
	0x07,
	DESC_ENDPOINT,
	ISOC_IN_EP,				    // bEndpointAddress
	0x0D,					    // bmAttributes = isoc, syncronous, data endpoint
	LE_WORD(MAX_PACKET_SIZE),	// wMaxPacketSize
	0x01,						// bInterval	
	
	// string descriptors
	0x04,
	DESC_STRING,
	LE_WORD(0x0409),

	0x0E,
	DESC_STRING,
	'L', 0, 'P', 0, 'C', 0, 'U', 0, 'S', 0, 'B', 0,

	0x14,
	DESC_STRING,
	'U', 0, 'S', 0, 'B', 0, 'S', 0, 'e', 0, 'r', 0, 'i', 0, 'a', 0, 'l', 0,

	0x12,
	DESC_STRING,
	'D', 0, 'E', 0, 'A', 0, 'D', 0, 'C', 0, '0', 0, 'D', 0, 'E', 0,

// terminating zero
	0
};


















/**
	Local function to handle the USB-CDC class requests
		
	@param [in] pSetup
	@param [out] piLen
	@param [out] ppbData
 */
static BOOL HandleClassRequest(TSetupPacket *pSetup, int *piLen, U8 **ppbData)
{
	return TRUE;
}



/**
	Interrupt handler
	
	Simply calls the USB ISR, then signals end of interrupt to VIC
 */
void USBIntHandler(void) 
{
	portSAVE_CONTEXT(); 
	
	USBHwISR();
	
	VICVectAddr = 0x00;    // dummy write to VIC to signal end of ISR
	
	portRESTORE_CONTEXT();
}

/**
	USB frame interrupt handler
	
	Called every milisecond by the hardware driver.
	
	This function is responsible for sending the first of a chain of packets
	to the host. A chain is always terminated by a short packet, either a
	packet shorter than the maximum packet size or a zero-length packet
	(as required by the windows usbser.sys driver).

 */

int delay = 0;
void USBFrameHandler(U16 wFrame)
{
    // send over USB
	if( isConnectedFlag ) {
		if( delay < 4000 ) {
			//FIXME need to delay a few seconds before doing isoc writes, impliment more elegant solution, status or event driven....
			delay++;
		} else {
			
			//Always write whatever is in our most recent isoc output data buffer, you may want to pust somthing interesting in there....
			inputIsocDataBuffer[0]++;
			USBHwEPWrite(ISOC_IN_EP, inputIsocDataBuffer, BYTES_PER_ISOC_FRAME);
			
			int iLen = USBHwISOCEPRead(ISOC_OUT_EP, outputIsocDataBuffer, sizeof(outputIsocDataBuffer));
			if (iLen > 0) {
				//Insert your code to do somthing interesting here....
				//DBG("z%d", b1);
				
				//The host sample code will send a byte indicating if the sample LED on olimex 2148 dev board should be on of off.
				if( outputIsocDataBuffer[0] ) {
#ifdef LPC214x
					IOSET0 = (1<<10);//turn on led on olimex dev board
#else
					FIO1SET = (1<<19);//turn off led on olimex 2378 Sdev board
#endif
					
				} else {
#ifdef LPC214x
					IOCLR0 = (1<<10);//turn off led on olimex dev board
#else
					FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board
#endif

				}
				
			}			
		}
	}
}


/**
	USB device status handler
	
	Resets state machine when a USB reset is received.
 */
static void USBDevIntHandler(U8 bDevStatus)
{	
	if ((bDevStatus & DEV_STATUS_RESET) != 0) {
	}
	
	bDevStat = bDevStatus;
	
	//FIXME not sure if this is the right way to detect being connected???
	switch(bDevStatus ) {
	case DEV_STATUS_CONNECT:
		isConnectedFlag= 1;
		break;
	case DEV_STATUS_RESET:
	case DEV_STATUS_SUSPEND:
		isConnectedFlag= 0;
		break;
	}
}







static void usbInit(void) {
	vSerialPutString(0, "Initialising USB stack\n", 0);

	// initialise stack
	USBInit();
	
	// register descriptors
	USBRegisterDescriptors(abDescriptors);

	// register class request handler
	USBRegisterRequestHandler(REQTYPE_TYPE_CLASS, HandleClassRequest, abClassReqData);

	// register endpoint handlers
	USBHwRegisterEPIntHandler(INT_IN_EP, NULL);
		
	// register frame handler
	USBHwRegisterFrameHandler(USBFrameHandler);
	
	// register device event handler
	USBHwRegisterDevIntHandler(USBDevIntHandler);
	
	inputIsocDataBuffer[0] = 0;
	
	DBG("Starting USB communication\n");

#ifdef LPC214x
	(*(&VICVectCntl0+INT_VECT_NUM)) = 0x20 | 22; // choose highest priority ISR slot 	
	(*(&VICVectAddr0+INT_VECT_NUM)) = (int)USBIntHandler;
#else
    VICVectCntl22 = 0x01;
    VICVectAddr22 = (int)USBIntHandler;
#endif
  
	// set up USB interrupt
	VICIntSelect &= ~(1<<22);               // select IRQ for USB
	VICIntEnable |= (1<<22);
	
	//enableIRQ();

	// connect to bus
	USBHwConnect(TRUE);
}






static void blinkyLightTask(void *pvParameters) {
	int x = 0;
		
	const int interval = 200000;
	// echo any character received (do USB stuff in interrupt)
	
	for(;;) {
		x++;

		if (x == interval) {
			
			if( ! isConnectedFlag ) {
				DBG("Not connected, blinking light...\n");
				FIO1SET = (1<<19);//turn on led on olimex 2378 dev board
			}
			
		} else if (x >= (interval*2)) {
			
			if( ! isConnectedFlag ) {
				DBG("Not connected, blinking light...\n");
				FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board
			}
			

			x = 0;
		}
	}

}
































/* Demo application definitions. */
#define mainQUEUE_SIZE						( 3 )
#define mainCHECK_DELAY						( ( portTickType ) 5000 / portTICK_RATE_MS )
#define mainBASIC_WEB_STACK_SIZE            ( configMINIMAL_STACK_SIZE * 6 )

/* Task priorities. */
#define mainQUEUE_POLL_PRIORITY				( tskIDLE_PRIORITY + 2 )
#define mainCHECK_TASK_PRIORITY				( tskIDLE_PRIORITY + 3 )
#define mainBLOCK_Q_PRIORITY				( tskIDLE_PRIORITY + 2 )
#define mainFLASH_PRIORITY                  ( tskIDLE_PRIORITY + 2 )
#define mainCREATOR_TASK_PRIORITY           ( tskIDLE_PRIORITY + 3 )
#define mainGEN_QUEUE_TASK_PRIORITY			( tskIDLE_PRIORITY ) 

/* Constants to setup the PLL. */
//#define mainPLL_MUL			( ( unsigned portLONG ) ( 8 - 1 ) )
//#define mainPLL_DIV			( ( unsigned portLONG ) 0x0000 )
//#define mainCPU_CLK_DIV		( ( unsigned portLONG ) 0x0003 )

//Get 48mhz for 
#define mainPLL_MUL			( ( unsigned portLONG ) ( 11 ) )
#define mainPLL_DIV			( ( unsigned portLONG ) 0x0000 )
#define mainCPU_CLK_DIV		( ( unsigned portLONG ) 0x0005 )

#define mainPLL_ENABLE		( ( unsigned portLONG ) 0x0001 )
#define mainPLL_CONNECT		( ( ( unsigned portLONG ) 0x0002 ) | mainPLL_ENABLE )
#define mainPLL_FEED_BYTE1	( ( unsigned portLONG ) 0xaa )
#define mainPLL_FEED_BYTE2	( ( unsigned portLONG ) 0x55 )
#define mainPLL_LOCK		( ( unsigned portLONG ) 0x4000000 )
#define mainPLL_CONNECTED	( ( unsigned portLONG ) 0x2000000 )
#define mainOSC_ENABLE		( ( unsigned portLONG ) 0x20 )
#define mainOSC_STAT		( ( unsigned portLONG ) 0x40 )
#define mainOSC_SELECT		( ( unsigned portLONG ) 0x01 )

/* Constants to setup the MAM. */
#define mainMAM_TIM_3		( ( unsigned portCHAR ) 0x03 )
#define mainMAM_MODE_FULL	( ( unsigned portCHAR ) 0x02 )

/* 
 * The task that handles the uIP stack.  All TCP/IP processing is performed in
 * this task.
 */
extern void vuIP_Task( void *pvParameters );

/*
 * The LCD is written two by more than one task so is controlled by a 
 * 'gatekeeper' task.  This is the only task that is actually permitted to 
 * access the LCD directly.  Other tasks wanting to display a message send
 * the message to the gatekeeper.
 */
static void vLCDTask( void *pvParameters );

/* Configure the hardware as required by the demo. */
static void prvSetupHardware( void );

/* The queue used to send messages to the LCD task. */
xQueueHandle xLCDQueue;

/*-----------------------------------------------------------*/

int main( void )
{
	prvSetupHardware();
	
	xSerialPortInitMinimal(0, 115200, 250 );
	vSerialPutString(0, "Starting up LPC23xx with FreeRTOS\n", 0);
	
	//usbInit();
	
	/* Create the queue used by the LCD task.  Messages for display on the LCD
	are received via this queue. */
	//xLCDQueue = xQueueCreate( mainQUEUE_SIZE, sizeof( xLCDMessage ) );

	/* Create the uIP task.  This uses the lwIP RTOS abstraction layer.*/
    //xTaskCreate( vuIP_Task, ( signed portCHAR * ) "uIP", mainBASIC_WEB_STACK_SIZE, NULL, mainCHECK_TASK_PRIORITY - 1, NULL );

	SCS |= 1;
	FIO1DIR |= (1<<19);
	int i;
	for(;;) {
		FIO1SET = (1<<19);
		for(i = 0; i < 500000; i++ ) {
			asm volatile("nop\n");

		}
		FIO1CLR = (1<<19);
		for(i = 0; i < 500000; i++ ) {
			asm volatile("nop\n");

		}
	}
	
	
	/* Start the standard demo tasks. */
	//vStartBlockingQueueTasks( mainBLOCK_Q_PRIORITY );
    //vCreateBlockTimeTasks();
    //vStartLEDFlashTasks( mainFLASH_PRIORITY );
    
	//vStartGenericQueueTasks( mainGEN_QUEUE_TASK_PRIORITY );
    //vStartQueuePeekTasks();   
    //vStartDynamicPriorityTasks();

	/* Start the tasks defined within this file/specific to this demo. */
	//xTaskCreate( vLCDTask, ( signed portCHAR * ) "LCD", configMINIMAL_STACK_SIZE, NULL, mainCHECK_TASK_PRIORITY - 1, NULL );

	
	xTaskCreate( blinkyLightTask, ( signed portCHAR * ) "usbCounter", configMINIMAL_STACK_SIZE, NULL, mainCHECK_TASK_PRIORITY - 1, NULL );

    
	/* Start the scheduler. */
	vTaskStartScheduler();

    /* Will only get here if there was insufficient memory to create the idle
    task. */
	return 0; 
}
/*-----------------------------------------------------------*/

void vApplicationTickHook( void )
{
	unsigned portBASE_TYPE uxColumn = 0;
	static xLCDMessage xMessage = { 0, "PASS" };
	static unsigned portLONG ulTicksSinceLastDisplay = 0;
	static portBASE_TYPE xHigherPriorityTaskWoken = pdFALSE;

	/* Called from every tick interrupt.  Have enough ticks passed to make it
	time to perform our health status check again? */
	ulTicksSinceLastDisplay++;
	if( ulTicksSinceLastDisplay >= mainCHECK_DELAY )
	{
		ulTicksSinceLastDisplay = 0;
		
		/* Has an error been found in any task? */

        if( xAreBlockingQueuesStillRunning() != pdTRUE )
		{
			xMessage.pcMessage = "ERROR - BLOCKQ";
		}

		if( xAreBlockTimeTestTasksStillRunning() != pdTRUE )
		{
			xMessage.pcMessage = "ERROR - BLOCKTIM";
		}

		if( xAreGenericQueueTasksStillRunning() != pdTRUE )
		{
			xMessage.pcMessage = "ERROR - GENQ";
		}
		
		if( xAreQueuePeekTasksStillRunning() != pdTRUE )
		{
			xMessage.pcMessage = "ERROR - PEEKQ";
		}       
		
		if( xAreDynamicPriorityTasksStillRunning() != pdTRUE )
		{
			xMessage.pcMessage = "ERROR - DYNAMIC";
		}
        
        xMessage.xColumn++;

		/* Send the message to the LCD gatekeeper for display. */
		xHigherPriorityTaskWoken = pdFALSE;
		xQueueSendToBackFromISR( xLCDQueue, &xMessage, &xHigherPriorityTaskWoken );
	}
}
/*-----------------------------------------------------------*/

static void prvSetupHardware( void )
{
	#ifdef RUN_FROM_RAM
		/* Remap the interrupt vectors to RAM if we are are running from RAM. */
		SCB_MEMMAP = 2;
	#endif
	
	/* Disable the PLL. */
	PLLCON = 0;
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;
	
	/* Configure clock source. */
	SCS |= mainOSC_ENABLE;
	while( !( SCS & mainOSC_STAT ) );
	CLKSRCSEL = mainOSC_SELECT; 
	
	/* Setup the PLL to multiply the XTAL input by 4. */
	PLLCFG = ( mainPLL_MUL | mainPLL_DIV );
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;

	/* Turn on and wait for the PLL to lock... */
	PLLCON = mainPLL_ENABLE;
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;
	CCLKCFG = mainCPU_CLK_DIV;	
	while( !( PLLSTAT & mainPLL_LOCK ) );
	
	/* Connecting the clock. */
	PLLCON = mainPLL_CONNECT;
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;
	while( !( PLLSTAT & mainPLL_CONNECTED ) ); 
	
	/* 
	This code is commented out as the MAM does not work on the original revision
	LPC2368 chips.  If using Rev B chips then you can increase the speed though
	the use of the MAM.
	
	Setup and turn on the MAM.  Three cycle access is used due to the fast
	PLL used.  It is possible faster overall performance could be obtained by
	tuning the MAM and PLL settings.
	MAMCR = 0;
	MAMTIM = mainMAM_TIM_3;
	MAMCR = mainMAM_MODE_FULL;
	*/
	
	/* Setup the led's on the MCB2300 board */
	vParTestInitialise();
}







