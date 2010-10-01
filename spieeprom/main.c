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
#include "spi/spi.h"

#define SPI_INTERRUPT_MODE            1

#define SPITEST_STACK_SIZE            1024

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
#define mainGEN_QUEUE_TASK_PRIORITY   ( tskIDLE_P            spi_transferNBytes(writeEnableCmd, 1,inPayload,1);RIORITY ) 

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

/*SPI_INTERRUPT_MODE
 * putchar
 */
void putchar2(const int fd, const int ch) {
    xSerialPutChar(0, ch, 1);
}


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
uint32_t millisecondsToCPUTicks(const uint32_t miliseconds) {
    uint32_t ret = (configCPU_CLOCK_HZ / 1000) * miliseconds;
    return(ret);
}
/*
void spi_transferNBytes(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize, uint8_t *bytesRead)
*/
/*
 * spi_Int_eepromtask
 */
static void spi_Int_eepromtask(void *pvParameters) {
    uint32_t    x                   = 0;
    uint32_t    cnt                 = 0;
    const int   interval            = 200000;
    uint8_t     do_wait             = 0;
    uint8_t     wait_iters          = 0;
    uint8_t     inPayload[4];
    uint8_t     writeEnableCmd[1]   = {0x06};
    uint8_t     writeCmd[4]         = {0x02, 0x00, 0x02, 0x0D};
    uint8_t     readCmd[3]          = {0x03, 0x00, 0x02};
    uint8_t     readStatusCmd[1]    = {0x05};
    
    
    for(;;) {
        x++;
        if (x == interval) {

        } else if (x >= (2*interval)) {
            x = 0;  
            printf2(" %d \r\n",cnt++);
#if (SPI_INTERRUPT_MODE)
            spi_transferNBytesInt(writeEnableCmd, 1,inPayload,1);
            spi_transferNBytesInt(writeCmd,4,inPayload,4);//A successful write cycle will reset the write enable latch

            do{
                spi_transferNBytesInt(readStatusCmd,1,inPayload,2);
                do_wait = (inPayload[1] & 0x01);
                wait_iters++;
            }while (do_wait);
            
            //printf2("Checked Status %d times, now reading..\r\n",wait_iters);
            wait_iters=0;
            spi_transferNBytesInt(readCmd,3,inPayload,4);
            if (inPayload[3] == writeCmd[3]){
                printf2("Write/Read Success!\r\n");
            }
#else
            spi_transferNBytesBW(writeEnableCmd, 1,inPayload,1);
            spi_transferNBytesBW(writeCmd,4,inPayload,4);//A successful write cycle will reset the write enable latch

            do{
                spi_transferNBytesBW(readStatusCmd,1,inPayload,2);
                do_wait = (inPayload[1] & 0x01);
                wait_iters++;
            }while (do_wait);
            
            //printf2("Checked Status %d times, now reading..\r\n",wait_iters);
            wait_iters=0;
            spi_transferNBytesBW(readCmd,3,inPayload,4);
            if (inPayload[3] == writeCmd[3]){
                printf2("Write/Read Success!\r\n");
            }   
#endif
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

    FIO1DIR |= (1<<19);

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

    spi_init();
#if (SPI_INTERRUPT_MODE)
    spi_initInt();
    printf2("SPI Interrupt Mode\r\n");
#else
    printf2("SPI Busy Wait Mode\r\n");
#endif

    xTaskCreate( spi_Int_eepromtask, 
            ( signed portCHAR * ) "spi_Int_eepromtask",  
            SPITEST_STACK_SIZE, NULL, 
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



            //   status = xSerialGetChar(0, &theChar, 1);
            //   if( status == pdTRUE ) {
            //       printf2("You typed the character: '%c'\r\n", theChar);
            //  }

