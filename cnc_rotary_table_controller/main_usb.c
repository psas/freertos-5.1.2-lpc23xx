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
#include "lpc23xx.h"
#include <stdint.h>

#define VCOM_FD  0

void putchar2(const int fd, const int ch)
{
	VCOM_putchar(ch);
}



volatile int32_t g_target_step_position = 0;
volatile int32_t g_current_step_postion = 0;
volatile int32_t g_direction = 1;
volatile uint32_t g_pwm_output_value = 0;
volatile uint8_t g_min_step_period = 40;

char readline_buffer[1024];


void readline(char *buff, const uint32_t buff_length) {
	uint32_t buffIndex = 0;
	buff[buffIndex] = '\0';
	static uint8_t lastChar = 0;

	for(;;) {
		if( (buffIndex + 1) >= buff_length ) {
			return;
		}

		int ch = VCOM_getchar();
		if (ch != EOF ) {
			lastChar = ch;

			if (ch == '\n') {
				if( lastChar != '\r' ) {
					lastChar = 0;
					return;
				}
			} else if (ch == '\r') {
				return;
			} else {
				buff[buffIndex] = ch;
				buffIndex++;
				buff[buffIndex] = '\0';
			}
		}
	}
}

void cursorToBeginingOfLine(void)
{
	int i;
	for(i = 0; i < 50; i++ ) {
		//see http://www.ibiblio.org/pub/historic-linux/ftp-archives/tsx-11.mit.edu/Oct-07-1996/info/vt102.codes
		//go all the way left
		putchar2(VCOM_FD, 033);
		putchar2(VCOM_FD, 0133);
		putchar2(VCOM_FD, 0104);
	}
}

void cursorUp(void)
{
	//see http://www.ibiblio.org/pub/historic-linux/ftp-archives/tsx-11.mit.edu/Oct-07-1996/info/vt102.codes
	//go  up
	putchar2(VCOM_FD, 033);
	putchar2(VCOM_FD, 0133);
	putchar2(VCOM_FD, 0101);
}

void clearScreen(void)
{
	int i, j;
	cursorToBeginingOfLine();
	for(i = 0; i < 40; i++ ) {
		cursorUp();
	}
	for(j = 0; j < 40; j++ ) {
		for(i = 0; i < 80; i++ ) {
			putchar2(VCOM_FD, ' ');
		}
		putchar2(VCOM_FD, '\r');
		putchar2(VCOM_FD, '\n');
	}
	cursorToBeginingOfLine();
	for(i = 0; i < 40; i++ ) {
		cursorUp();
	}
}
#define MICROSTEPPING            4
#define STEPS_PER_REVOLUTION     200
#define TABLE_DEGREES_PER_MOTOR_ROTATION     5
const int32_t microstepping = MICROSTEPPING;
const int32_t step_per_rotation = STEPS_PER_REVOLUTION; //1.8 degrees per step
const int32_t pulses_per_motor_rotation = (MICROSTEPPING * STEPS_PER_REVOLUTION);
const int32_t degrees_per_motor_revolution = TABLE_DEGREES_PER_MOTOR_ROTATION;
const int32_t pulses_per_table_rotation = (MICROSTEPPING * STEPS_PER_REVOLUTION * (360 / TABLE_DEGREES_PER_MOTOR_ROTATION) );



int32_t tableDegreesToSteps(const double degrees)
{
	int32_t ret = (int32_t) ((degrees * ((double)pulses_per_table_rotation)) / 360.0);
	return(ret);
}

double stepsToTableDegrees(const int32_t steps)
{
	//const double pulses_per_table_degree =  pulses_per_table_rotation / degrees_per_motor_revolution;
	double ret = (((double)steps) / pulses_per_table_rotation) * 360.0;
	return(ret);
}

static void cncRotaryTableTask(void *pvParameters)
{
	int32_t index_step_size = tableDegreesToSteps(11.25);

	const int interval = 20000;
	const int interval2 = 40000;
	double deg;
	//const int interval = 3;
	int status = 0;


	int x, i;


	int redisplay = 0;
	for (;;) {
		//vTaskDelay(200);
		x++;

		if ( redisplay || x == interval2) {
			cursorToBeginingOfLine();
			for(i = 0; i < 40; i++ ) {
				cursorUp();
			}

			redisplay = 0;
			fprintf2(VCOM_FD, "-------------------------------------------------------\r\n");
			fprintf2(VCOM_FD, "deg = %f                                \r\n", deg);
			fprintf2(VCOM_FD, "CNC Rotary Table Controller                  \r\n");
			fprintf2(VCOM_FD, "Steping Pulse Width:       %d                \r\n", g_min_step_period);
			fprintf2(VCOM_FD, "Microstepping:             %d                \r\n", microstepping);
			fprintf2(VCOM_FD, "Steps Per Rotation:        %d                \r\n", step_per_rotation);
			fprintf2(VCOM_FD, "Pulses Per Motor Rotation: %d                \r\n", pulses_per_motor_rotation);
			fprintf2(VCOM_FD, "Pulses Per Table Rotation: %d                \r\n", pulses_per_table_rotation);
			fprintf2(VCOM_FD, "Target Step Position:      %d                \r\n", g_target_step_position);
			fprintf2(VCOM_FD, "Current Step Position:     %d                \r\n", g_current_step_postion);
			fprintf2(VCOM_FD, "Target Angular Position:   %f                \r\n", stepsToTableDegrees(g_target_step_position));
			fprintf2(VCOM_FD, "Current Angular Position:  %f                \r\n", stepsToTableDegrees(g_current_step_postion));
			fprintf2(VCOM_FD, "Index Step Size:           %d                \r\n", index_step_size);
			fprintf2(VCOM_FD, "Index Step Size (angular): %f                \r\n", stepsToTableDegrees(index_step_size));
			fprintf2(VCOM_FD, "Direction:                 %d                \r\n", g_direction);
			fprintf2(VCOM_FD, "\r\n");
			fprintf2(VCOM_FD, "Commands:\r\n");
			fprintf2(VCOM_FD, "   's': set index step size                \r\n");
			fprintf2(VCOM_FD, "   'n': move by index-step-size degrees                \r\n");
			fprintf2(VCOM_FD, "   'z': rotate zero                \r\n");
			fprintf2(VCOM_FD, "   'R': reset zero                \r\n");
			fprintf2(VCOM_FD, "   'g': goto specific position                \r\n");
			fprintf2(VCOM_FD, "   'd': toggle direction                \r\n");


		}

		char *end_ptr;
		int c = VCOM_getchar();
		if (c != EOF) {
			redisplay = 1;

			switch (c) {
				case 's':
					{
						cursorUp();
						fprintf2(VCOM_FD, "What step-index size would you like to use (degrees * 1000)? : \r\n");
						readline(readline_buffer, sizeof(readline_buffer));
						end_ptr = NULL;

						//double deg = strtod(readline_buffer, &end_ptr);
						//deg = atof(readline_buffer);
						deg = strtol(readline_buffer, &end_ptr, 10);
						if( deg == 0 && readline_buffer == end_ptr ) {
							fprintf2(VCOM_FD, "Failed to convert number!            \r\n");
						} else {
							index_step_size = tableDegreesToSteps(deg/1000.0);
							clearScreen();
						}

						/*
						int32_t new_step_size = strtol(readline_buffer, &end_ptr, 10);
						if( new_step_size == 0 && readline_buffer == end_ptr ) {
							fprintf2(VCOM_FD, "Failed to convert number to integer!            \r\n");
						} else {
							index_step_size = new_step_size;
							clearScreen();
						}
						*/

					}
					break;
				case 'n':
					g_target_step_position = ((g_target_step_position + index_step_size) % pulses_per_table_rotation);
					break;
				case 'z':
					g_target_step_position = 0;
					break;
				case 'g':
					{
						cursorUp();
						fprintf2(VCOM_FD, "What position would you like to goto? (degrees * 1000) : \r\n");
						readline(readline_buffer, sizeof(readline_buffer));
						end_ptr = NULL;
						//deg = strtod(readline_buffer, &end_ptr);
						deg = strtol(readline_buffer, &end_ptr, 10);

						if( deg == 0 && readline_buffer == end_ptr ) {
							fprintf2(VCOM_FD, "Failed to convert number!            \r\n");
						} else {
							g_target_step_position = tableDegreesToSteps(deg / 1000.0);
							clearScreen();
						}
					}
					break;
				case 'p':
					{
						cursorUp();
						fprintf2(VCOM_FD, "What stepping pulse width would you like? : \r\n");
						readline(readline_buffer, sizeof(readline_buffer));
						end_ptr = NULL;
						int32_t p = strtol(readline_buffer, &end_ptr, 10);

						if( p == 0 && readline_buffer == end_ptr ) {
							fprintf2(VCOM_FD, "Failed to convert number!            \r\n");
						} else {
							if( p >= 1 && p <= 100 ) {
								g_min_step_period = p;
							}
							clearScreen();
						}
					}
					break;
				case 'd':
					if (g_direction) {
						g_direction = 0;
					} else {
						g_direction = 1;
					}
					break;
				case 'R':
					g_current_step_postion = g_target_step_position = 0;
					break;
				case '+':
					g_target_step_position = ((g_target_step_position + 1) % pulses_per_table_rotation);
					redisplay = 0;
					break;
				case 0x1B:
					//Esc character
					g_target_step_position = g_current_step_postion;
					break;
			}

		}

		if (x == interval) {
			FIO1SET = (1 << 19);//turn on led on olimex 2378 dev board
			status = 1;
		} else if (x >= (interval * 2)) {
			FIO1CLR = (1 << 19);//turn off led on olimex 2378 Sdev board
			status = 0;
			x = 0;
		}
/*
		int c = VCOM_getchar();
		if (c != EOF) {
			if (status) {
				FIO1CLR = (1 << 19);//turn off led on olimex 2378 Sdev board
				status = 0;
			} else {
				FIO1SET = (1 << 19);//turn on led on olimex 2378 dev board
				status = 1;
			}
			// show on console
			if ((c == 9) || (c == 10) || (c == 13) || ((c >= 32) && (c <= 126))) {
				DBG("%c", c);
			} else {
				DBG(".");
			}
			//VCOM_putchar(c);
			fprintf2(VCOM_FD, "%c", c);

			if (c == '?') {

			}
		}
		*/

	}
}

/*
static void blinkyLightTask(void *pvParameters) {
	int x = 0;
		
	const int interval = 20000;
	
	int status = 0;
	for(;;) {
		x++;

		if (x == interval) {
			FIO1SET = (1 << 19);//turn on led on olimex 2378 dev board
			status = 1;
		} else if (x >= (interval * 2)) {
			FIO1CLR = (1 << 19);//turn off led on olimex 2378 Sdev board
			status = 0;
			x = 0;
		}


		int c = VCOM_getchar();
		if (c != EOF) {
			if (status) {
				FIO1CLR = (1 << 19);//turn off led on olimex 2378 Sdev board
				status = 0;
			} else {
				FIO1SET = (1 << 19);//turn on led on olimex 2378 dev board
				status = 1;
			}
			// show on console
			if ((c == 9) || (c == 10) || (c == 13) || ((c >= 32) && (c <= 126))) {
				DBG("%c", c);
			}
			else {
				DBG(".");
			}
			VCOM_putchar(c);


			if( c == '?' ) {

			}
		}
	}
}
*/


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


#define mainTX_ENABLE	( ( unsigned portLONG ) (1<<4) )
#define mainRX_ENABLE	( ( unsigned portLONG ) (1<<6) )
void enableSerial0( void ) {
	PCLKSEL0 = (PCLKSEL0 & ~(3<<6)) | (1<<6);//set uart to run at CCLK speed, UART0
	PINSEL0 |= mainTX_ENABLE;
	PINSEL0 |= mainRX_ENABLE;
}

/* Configure the hardware as required by the demo. */
static void prvSetupHardware( void );


/*-----------------------------------------------------------*/

int main( void )
{
	SCS |= 1;
	FIO1DIR |= (1<<19);


	int i = 1;
	int j = 0;
	while(j ) {
		i++;
	}

	prvSetupHardware();

	//VCOM_init();
	usbInit();

	//blinkyLightTask(NULL);
/*
	j = 1;
	while( j ) {
		i++;
	}
	*/


	enableSerial0();
	xSerialPortInitMinimal(0, 115200, 250 );
	vSerialPutString(0, "Starting up LPC23xx with FreeRTOS\n", 50);
	


/*
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
	*/
	

	/* Start the standard demo tasks. */
	//vStartBlockingQueueTasks( mainBLOCK_Q_PRIORITY );
    //vCreateBlockTimeTasks();
    //vStartLEDFlashTasks( mainFLASH_PRIORITY );
    
	//vStartGenericQueueTasks( mainGEN_QUEUE_TASK_PRIORITY );
    //vStartQueuePeekTasks();   
    //vStartDynamicPriorityTasks();
	
	FIO0DIR |= 0x01; //Set P0.0 to output mode
	FIO0CLR |= 0x01; //clear P0.0
	g_pwm_output_value = 0;
	xTaskCreate( cncRotaryTableTask, ( signed portCHAR * ) "usbCounter", 2048, NULL, mainCHECK_TASK_PRIORITY - 1, NULL );
	//xTaskCreate( cncRotaryTableTask, ( signed portCHAR * ) "usbCounter", configMINIMAL_STACK_SIZE, NULL, mainCHECK_TASK_PRIORITY - 1, NULL );

    
	/* Start the scheduler. */
	vTaskStartScheduler();

    /* Will only get here if there was insufficient memory to create the idle
    task. */
	return 0; 
}
/*-----------------------------------------------------------*/

void vApplicationTickHook(void)
{

	static int hook_counter = 0;

	if (hook_counter == 0) {
		if (g_target_step_position != g_current_step_postion) {
			if (g_pwm_output_value) {
				FIO0CLR = 0x01;
				g_pwm_output_value = 0;
			} else {
				FIO0SET = 0x01;
				g_pwm_output_value = 1;
			}

			if (g_target_step_position > g_current_step_postion) {
				g_current_step_postion++;
			} else {
				g_current_step_postion--;
			}
		}
	}
	hook_counter++;
	if (hook_counter >= g_min_step_period) {
		hook_counter = 0;
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







