

/*
 * Portions of this code:
 * FreeRTOS.org V5.1.2 - Copyright (C) 2003-2009 Richard Barry.
 *
 * This file is part of the FreeRTOS.org distribution.
 *
 * FreeRTOS.org is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * FreeRTOS.org is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FreeRTOS.org; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * A special exception to the GPL can be applied should you wish to distribute
 * a combined work that includes FreeRTOS.org, without being obliged to provide
 * the source code for any proprietary components.  See the licensing section 
 * of http://www.FreeRTOS.org for full details of how and when the exception
 * can be applied.
 */

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "portmacro.h"

#include <stdint.h>
#include "serial/serial.h"
#include "printf/uart0PutChar2.h"
#include "printf/printf2.h"
#include "peripherals/pwm.h"
#include "i2c/i2c.h"

#define I2CTEST_STACK_SIZE            1024

// Constants to setup I/O. 
#define mainTX_ENABLE                 ( ( unsigned portLONG ) (1<<4) )
#define mainRX_ENABLE                 ( ( unsigned portLONG ) (1<<6) )

/* Demo application definitions. */
#define mainQUEUE_SIZE                ( 3 )
#define mainCHECK_DELAY               ( ( portTickType ) 5000 / portTICK_RATE_MS )
#define mainBASIC_WEB_STACK_SIZE      ( configMINIMAL_STACK_SIZE * 6 )

/* Task priorities. */
#define mainQUEUE_POLL_PRIORITY       ( tskIDLE_PRIORITY + 2 )
#define mainCHECK_TASK_PRIORITY       ( tskIDLE_PRIORITY + 3 )
#define mainBLOCK_Q_PRIORITY          ( tskIDLE_PRIORITY + 2 )
#define mainFLASH_PRIORITY            ( tskIDLE_PRIORITY + 2 )
#define mainCREATOR_TASK_PRIORITY     ( tskIDLE_PRIORITY + 3 )
#define mainGEN_QUEUE_TASK_PRIORITY   ( tskIDLE_PRIORITY ) 

/* clock setup */
#define mainPLL_MUL                   ( ( unsigned portLONG ) ( 11 ) )
#define mainPLL_DIV                   ( ( unsigned portLONG ) 0x0000 )
#define mainCPU_CLK_DIV               ( ( unsigned portLONG ) 0x0005 )
#define PCLK                          configCPU_CLOCK_HZ

#define mainPLL_ENABLE                ( ( unsigned portLONG ) 0x0001 )
#define mainPLL_CONNECT               ( ( ( unsigned portLONG ) 0x0002 ) | mainPLL_ENABLE )
#define mainPLL_FEED_BYTE1            ( ( unsigned portLONG ) 0xaa )
#define mainPLL_FEED_BYTE2            ( ( unsigned portLONG ) 0x55 )
#define mainPLL_LOCK                  ( ( unsigned portLONG ) 0x4000000 )
#define mainPLL_CONNECTED             ( ( unsigned portLONG ) 0x2000000 )
#define mainOSC_ENABLE                ( ( unsigned portLONG ) 0x20 )
#define mainOSC_STAT                  ( ( unsigned portLONG ) 0x40 )
#define mainOSC_SELECT                ( ( unsigned portLONG ) 0x01 )

/* Constants to setup the MAM. */
#define mainMAM_TIM_3                 ( ( unsigned portCHAR ) 0x03 )
#define mainMAM_MODE_FULL             ( ( unsigned portCHAR ) 0x02 )

/* blinkm i2c address */
#define BLINKM_ADDR                   0x09

/*
 * microsecondsToCPUTicks
 */
uint32_t microsecondsToCPUTicks(const uint32_t microseconds) {
    uint32_t ret = (configCPU_CLOCK_HZ / 1000000) * microseconds;
    return(ret);
}

/*
 * millisecondsToCPUTicks
 */
uint32_t milisecondsToCPUTicks(const uint32_t miliseconds) {
    uint32_t ret = (configCPU_CLOCK_HZ / 1000) * miliseconds;
    return(ret);
}

/*
 * i2cblinkmtask
 */
static void i2cblinkmtask(void *pvParameters) {
    uint32_t  x             = 0;
    uint32_t  write         = 1;

    signed    portCHAR      theChar;
    signed    portBASE_TYPE status;

    const int interval      = 10000;

    uint8_t myDataToGet[100];
    uint8_t myDataToSend[100];

    FIO0CLR = (1<<6);            // turn off p0.6on olimex 2378 Sdev board

    for(;;) {
        x++;

        if (x == interval) {
            FIO0CLR = (1<<6);    // turn on  p0.6 on olimex 2378 Sdev board
            FIO1CLR = (1<<19);   // turn off led  on olimex 2378 Sdev board
            myDataToSend[0] = 'o';   // sstop light task script
            myDataToSend[1] = 'n';   // set rgb color
            myDataToSend[2] = 0xbd;
            myDataToSend[3] = 0x10;
            myDataToSend[4] = 0x02;
            I2C0MasterTX(BLINKM_ADDR, myDataToSend, 5);
 
        } else if (x >= (2*interval)) {
            FIO0CLR = (1<<6);    // turn on p0.6 on olimex 2378 Sdev board
            FIO1SET = (1<<19);   // turn on led on olimex 2378 dev board

            x = 0;

            printf2("i2c Light Task...\r\n");

            //  myDataToSend[0] = 'Z'; // current blinkm firmware version
            myDataToSend[0] = 'g';     // current RGB color, 3 bytes

            if(write==1) {
                I2C0MasterTX(BLINKM_ADDR, myDataToSend, 1);
                write=0;
            } else {
                I2C0MasterRX(BLINKM_ADDR, myDataToGet, 3);
                printf2("mydatatoget[0] is 0x%X\n\r",myDataToGet[0]);
                printf2("mydatatoget[1] is 0x%X\n\r",myDataToGet[1]);
                printf2("mydatatoget[2] is 0x%X\n\r",myDataToGet[2]);
                write = 1;
            }

            //   status = xSerialGetChar(0, &theChar, 1);
            //   if( status == pdTRUE ) {
            //       printf2("You typed the character: '%c'\r\n", theChar);
            //  }
        }
    }
}


/*-----------------------------------------------------------*/

/*
 * prvSetupHardware
 */
static void prvSetupHardware( void ) {
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

    // debugging pins
    FIO1DIR |= (1<<19);
    FIO1DIR |= (1<<20);
    FIO1DIR |= (1<<22);
    FIO1DIR |= (1<<24);
    FIO1DIR |= (1<<25);
    FIO1DIR |= (1<<26);
    FIO1DIR |= (1<<27);
    FIO1DIR |= (1<<28);
    FIO1DIR |= (1<<31);

    FIO0DIR |= (1<<6);
}

/*
 * enableSerial0
 */
void enableSerial0( void ) {
    PCLKSEL0 = (PCLKSEL0 & ~(3<<6)) | (1<<6); // set uart to run at CCLK speed, UART0
    PINSEL0 |= mainTX_ENABLE;
    PINSEL0 |= mainRX_ENABLE;
}

/*
 * main
 */
int main( void ) {
    uint8_t myDataToSend[100];
    prvSetupHardware();

    enableSerial0();

    xSerialPortInitMinimal(0, 115200, 250 );
    vSerialPutString(0, "Starting up LPC23xx with FreeRTOS\n\r", 50);

    SCS |= 1; //Configure FIO

    // Initialize I2C0
    I2Cinit(I2C0);

    myDataToSend[0] = 'o';   // stop the current blinkm light script 
//        myDataToSend[1] = 'h';  // set an hsv color
 //       myDataToSend[2] = 228;
  //      myDataToSend[3] = 0x80;
   //     myDataToSend[4] = 0xff;

     myDataToSend[1] = 'n';   // set rgb color
     myDataToSend[2] = 0x0f;
     myDataToSend[3] = 0x20;
     myDataToSend[4] = 0xff;
     I2C0MasterTX(BLINKM_ADDR, myDataToSend, 5);

// i2c Light Task...                                                               
// I2C0ExtSlaveAddress is: 0x12                                                    
// I2C0TransmitData    is: 0x67                                                    
// I2C0DataLength      is: 0x1                                                     
// I2C0DataCounter     is: 0x00                                                    
// i2c Light Task...                                                               
// mydatatoget[0] is 0xF                                                           
// mydatatoget[1] is 0x20                                                          
// mydatatoget[2] is 0xFF 

    xTaskCreate( i2cblinkmtask, 
            ( signed portCHAR * ) "i2cblinkmtask", 
            I2CTEST_STACK_SIZE, NULL, 
            mainCHECK_TASK_PRIORITY - 1, 
            NULL );

    /* Start the scheduler. */
    vTaskStartScheduler();

    /* Will only get here if there was insufficient memory to create the idle
       task. */
    return 0; 
}


/*-----------------------------------------------------------*/
void vApplicationTickHook( void ) {
    unsigned portBASE_TYPE uxColumn = 0;
    static xLCDMessage xMessage = { 0, "PASS" };
    static unsigned portLONG ulTicksSinceLastDisplay = 0;
    static portBASE_TYPE xHigherPriorityTaskWoken = pdFALSE;

    // Called from every tick interrupt.  Have enough ticks passed to make it
    // time to perform our health status check again? 
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
    }
}


