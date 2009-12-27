

/*
 * Portions of this code:
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
 */

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "portmacro.h"

/* Demo app includes. */
/*
#include "BlockQ.h"
#include "death.h"
#include "blocktim.h"
#include "flash.h"
#include "partest.h"
#include "GenQTest.h"
#include "QPeek.h"
#include "dynamic.h"
*/
#include <stdint.h>
#include "serial/serial.h"
#include "printf/uart0PutChar2.h"
#include "printf/printf2.h"
#include "peripherals/pwm.h"
#include "i2c/i2c.h"

#define I2CTEST_STACK_SIZE 1024

// Constants to setup I/O. 
#define mainTX_ENABLE	( ( unsigned portLONG ) (1<<4) )
#define mainRX_ENABLE	( ( unsigned portLONG ) (1<<6) )
/*
#define mainTX_ENABLE	( ( unsigned portLONG ) 0x0001 )
#define mainRX_ENABLE	( ( unsigned portLONG ) 0x0004 )
#define mainTX1_ENABLE	( ( unsigned portLONG ) 0x10000 )
#define mainRX1_ENABLE	( ( unsigned portLONG ) 0x40000 )
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

// #define PCLK ((12 * (mainPLL_MUL+1) * 2) / (mainPLL_DIV + 1)) / mainCPU_CLK_DIV

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

#define PCLK    configCPU_CLOCK_HZ

uint32_t microsecondsToCPUTicks(const uint32_t microseconds) {
    uint32_t ret = (configCPU_CLOCK_HZ / 1000000) * microseconds;
    return(ret);
}

uint32_t milisecondsToCPUTicks(const uint32_t miliseconds) {
    uint32_t ret = (configCPU_CLOCK_HZ / 1000) * miliseconds;
    return(ret);
}

#define BLINKM_ADDR 0x09

static void i2cblinkmTask(void *pvParameters) {
    int x = 0;
    signed portCHAR theChar;
    signed portBASE_TYPE status;
    const int interval = 100000;

    uint32_t blinkm_id;

    // uint32_t pwmDutyCycle = 1000;

    uint8_t myDataToGet[100];
    uint8_t myDataToSend[100];
 
    printf2("VICIntEnable is: 0x%X\n\r", VICIntEnable);
    FIO1CLR = (1<<19);//turn off p1.22 on olimex 2378 Sdev board
    FIO1CLR = (1<<20);//turn off p1.20 on olimex 2378 Sdev board
    FIO1CLR = (1<<22);//turn off p1.22 on olimex 2378 Sdev board
    FIO1CLR = (1<<24);//turn off p1.24 on olimex 2378 Sdev board
    FIO1CLR = (1<<25);//turn off p1.24 on olimex 2378 Sdev board
    FIO1CLR = (1<<26);//turn off p1.26 on olimex 2378 Sdev board
    FIO1CLR = (1<<27);//turn off p1.27 on olimex 2378 Sdev board
    FIO1CLR = (1<<28);//turn off p1.28 on olimex 2378 Sdev board
    FIO1CLR = (1<<31);//turn off p1.31 on olimex 2378 Sdev board

    FIO0CLR = (1<<6);//turn off p0.6on olimex 2378 Sdev board

    if(I2C0STAT & 1<<0) {
        FIO1SET = (1<<28);
    } else {
        FIO1CLR = (1<<28);
    }
    if(I2C0STAT & 1<<1) {
        FIO1SET = (1<<20);
    } else {
        FIO1CLR = (1<<20);
    }
    if(I2C0STAT & 1<<2) {
        FIO1SET = (1<<22);
    } else {
        FIO1CLR = (1<<22);
    }
    if(I2C0STAT & 1<<3) {
        FIO1SET = (1<<24);
    } else {
        FIO1CLR = (1<<24);
    }
    if(I2C0STAT & 1<<4) {
        FIO1SET = (1<<25);
    } else {
        FIO1CLR = (1<<25);
    }
    if(I2C0STAT & 1<<5) {
        FIO1SET = (1<<26);
    } else {
        FIO1CLR = (1<<26);
    }
    if(I2C0STAT & 1<<6) {
        FIO1SET = (1<<27);
    } else {
        FIO1CLR = (1<<27);
    }
    if(I2C0STAT & 1<<7) {
        FIO1SET = (1<<31);
    } else {
        FIO1CLR = (1<<31);
    }


    int write = 1;

    for(;;) {
        //vSerialPutString(0, "Testing...\r\n", 50);
        x++;

        //    FIO0SET = (1<<6);//turn on p0.6 on olimex 2378 Sdev board
        //       vTaskDelay( 10 );
        if (x == interval) {
            FIO0CLR = (1<<6);//turn on p0.6 on olimex 2378 Sdev board
            FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board

//             pwmDutyCycle += 100;
 //            if(pwmDutyCycle > 2000 ) {
  //               pwmDutyCycle = 1000;
   //          }
    //         setPWMDutyCycle(PWM1_1, microsecondsToCPUTicks(pwmDutyCycle));

        } else if (x >= (6*interval)) {
            FIO0CLR = (1<<6);//turn on p0.6 on olimex 2378 Sdev board
            FIO1SET = (1<<19);//turn on led on olimex 2378 dev board
            //            FIO1CLR = (1<<22);//turn off p1.22 on olimex 2378 Sdev board
            //                FIO1SET = FIO1SET ^ (1<<22);//invert state of p1.22 on olimex 2378 dev board
            //            vTaskDelay( 10000 );


            x = 0;

            printf2("i2c Light Task...\r\n");

            // uint32_t myDataToSend[100] = {'o', 'p', 0x4, 0x2, 0x0, 'a'};
            //  myDataToSend[0] = 'Z'; // current blinkm firmware version
             myDataToSend[0] = 'g'; // current RGB color, 3 bytes

            if(write==1) {
            // printf2("i2c Light Task write cmd...\r\n");
 
            //  I2C0MasterTX(BLINKM_ADDR, myDataToSend, 6);
             I2C0MasterTX(BLINKM_ADDR, myDataToSend, 1);
             write=0;
            } else {
                I2C0MasterRX(BLINKM_ADDR, myDataToGet, 3);
                printf2("mydatatoget[0] is 0x%X\n\r",myDataToGet[0]);
                printf2("mydatatoget[1] is 0x%X\n\r",myDataToGet[1]);
                printf2("mydatatoget[2] is 0x%X\n\r",myDataToGet[2]);
                write = 1;
            }

            //           } else {
            //      printf2("i2c Light Task read data ...\r\n");
            //             printf2("mydatatoget[0] is 0x%X\n\r",myDataToGet[0]);
            //            write=1;
            //       }

            /*                       myDataToSend[1] = 'n';
                                     myDataToSend[2] = 0xff;
                       myDataToSend[3] = 0x0;
                       myDataToSend[4] = 0x0;
                       myDataToSend[5] = 'c';
                       myDataToSend[6] = 0xff;
                       myDataToSend[7] = 0xff;
                       myDataToSend[8] = 0x00; */


            //         printf2("myDataToSend: %c 0x%X\n", myDataToSend[0], myDataToSend[0]);
            //         printf2("VICRawIntr register is: 0x%X\n\r",VICRawIntr);
            //         printf2("I2C0STAT register is:   0x%X\n\r",I2C0STAT);


//                vTaskDelay( 100 );
//e
                       // printf2("VICRawIntr register is: 0x%X\n\r",VICRawIntr);

            //            myDataToSend[0] = 0xff;

            //            I2C0MasterTX(BLINKM_ADDR, &myDataToSend, 1);

            //            myDataToSend[0] = 0xc4;

            //            I2C0MasterTX(BLINKM_ADDR, &myDataToSend, 1);

            //            status = xSerialGetChar(0, &theChar, 1);
            //            if( status == pdTRUE ) {
            //                printf2("You typed the character: '%c'\r\n", theChar);
            //           }
        }
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


void enableSerial0( void ) {
    PCLKSEL0 = (PCLKSEL0 & ~(3<<6)) | (1<<6);//set uart to run at CCLK speed, UART0
    PINSEL0 |= mainTX_ENABLE;
    PINSEL0 |= mainRX_ENABLE;
}


/*-----------------------------------------------------------*/

//#define PCLK    48000000
int main( void )
{
    uint8_t myDataToSend[100];
    prvSetupHardware();

    enableSerial0();

//    PWMinit (0, milisecondsToCPUTicks(30));                // 30ms period, given 48mhz CPU clock

//    setupPWMChannel(PWM1_1, microsecondsToCPUTicks(1500)); // 1ms duty cycle, given 48mhz CPU clock

    xSerialPortInitMinimal(0, 115200, 250 );
    vSerialPutString(0, "Starting up LPC23xx with FreeRTOS\n\r", 50);

    SCS |= 1; //Configure FIO

//     uint32_t pllcfg   = PLLCFG;
//     uint32_t pllstat = PLLSTAT ;
//     uint32_t cclkcfg  = CCLKCFG;
//     uint32_t pclksel0 = PCLKSEL0 ;
//     uint32_t pclksel1 = PCLKSEL1 ;
//     uint32_t clksrcsel = CLKSRCSEL ;
//    printf2("\tPLLCFG is: 0x%X\n\r", pllcfg);
//    printf2("\tCCLKCFG is: 0x%X\n\r", cclkcfg);
//    printf2("\tCLKSRCSEL is: 0x%X\n\r", clksrcsel);
//    printf2("\tPCLKSEL0 is: 0x%X\n\r", pclksel0);
//    printf2("\tPCLKSEL0 is: 0x%X\n\r", pclksel1);

    // Initialize I2C0
    I2Cinit(I2C0);

    myDataToSend[0] = 'o'; 
//    myDataToSend[1] = 'h'; 
//    myDataToSend[2] = 128;
//    myDataToSend[3] = 0x0f;
//    myDataToSend[4] = 0x0f;
    myDataToSend[1] = 'n'; 
  myDataToSend[2] = 0xf;
  myDataToSend[3] = 0xef;
  myDataToSend[4] = 0xcf;
 
    I2C0MasterTX(BLINKM_ADDR, myDataToSend, 5);


    xTaskCreate( i2cblinkmTask, 
            ( signed portCHAR * ) "i2cblinkmTask", 
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

void vApplicationTickHook( void )
{
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


