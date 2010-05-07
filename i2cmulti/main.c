
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
#define EEPROM_ADDR                   0x50   // 0b1010 000

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
 * set_blinkm_rgb
 */
void set_blinkm_rgb(i2c_master_xact_t* xact_s, int8_t red, uint8_t green, uint8_t blue) {
    xact_s->I2C_TX_buffer[0] =  i2c_create_write_address(BLINKM_ADDR);
    xact_s->I2C_TX_buffer[1] =  'o';
    xact_s->I2C_TX_buffer[2] =  'n';
    xact_s->I2C_TX_buffer[3] =  red;
    xact_s->I2C_TX_buffer[4] =  green;
    xact_s->I2C_TX_buffer[5] =  blue;
    xact_s->write_length     =  0x06;
    xact_s->read_length      =  0x0;
    I2C0_master_xact(xact_s);
}


/*
 * i2cmultitask
 */
static void i2cmultitask(void *pvParameters) {
    uint8_t rgb_color[3];
    uint8_t stop, down;

    uint32_t  x             = 0;
    uint32_t  i             = 0;
    uint32_t  write         = 1;

    signed    portCHAR      theChar;
    signed    portBASE_TYPE status;

    const int interval      = 1000;

    i2c_master_xact_t       xact_s;

    FIO0CLR = (1<<6);            // turn off p0.6on olimex 2378 Sdev board

    for(i=0; i<I2C_MAX_BUFFER; i++) {
        xact_s.I2C_TX_buffer[i]  = 0;
        xact_s.I2C_RD_buffer[i]  = 0;
    }
    xact_s.write_length          = 0;
    xact_s.read_length           = 0;
    xact_s.I2Cext_slave_address  = 0;

    rgb_color[0] = 0x0;
    rgb_color[1] = 0x0;
    rgb_color[2] = 0x0;

    uint32_t  rgb_c = 0;

    printf2("i2c initial write byte 0xc to 0xf  ...\r\n");

    xact_s.I2C_TX_buffer[0] =  i2c_create_write_address(EEPROM_ADDR);
    xact_s.I2C_TX_buffer[1] =  0x0;
    xact_s.I2C_TX_buffer[2] =  0xf;
    xact_s.I2C_TX_buffer[3] =  0xc;
    xact_s.write_length     =  0x4;
    xact_s.read_length      =  0x0;
    I2C0_master_xact(&xact_s);

    stop = 0;
    down = 0;

    set_blinkm_rgb(&xact_s, 0xff, 0xff, 0xff);

    for(;;) {
        x++;

        if (x == interval) {
            FIO0CLR = (1<<6);    // turn off  p0.6 on olimex 2378 Sdev board
            FIO1CLR = (1<<19);   // turn off led  on olimex 2378 Sdev board

        } else if (x >= (2*interval)) {
            FIO0SET = (1<<6);    // turn on p0.6 on olimex 2378 Sdev board
            FIO1SET = (1<<19);   // turn on led on olimex 2378 dev board

            x = 0;

            xact_s.I2C_RD_buffer[0] =  0x0;

            //            printf2("i2c eeprom 1 read byte...\r\n");
            xact_s.I2C_TX_buffer[0] =  i2c_create_write_address(EEPROM_ADDR);
            xact_s.I2C_TX_buffer[1] =  0x0;
            xact_s.I2C_TX_buffer[2] =  0xf;
            xact_s.write_length     =  0x3;
            xact_s.I2C_TX_buffer[3] =  i2c_create_read_address(EEPROM_ADDR);
            xact_s.read_length      =  0x1;
            I2C0_master_xact(&xact_s);

            I2C0_get_read_data(&xact_s);
            if(xact_s.I2C_RD_buffer[0] != 0xc) {
                printf2("*** I2C Read Error***: Read data is 0x%X\n\r",xact_s.I2C_RD_buffer[0]);
                printf2("*** I2C Read Error***: Stopping.");
                rgb_color[0] = 0xff;
                rgb_color[1] = 0x0;
                rgb_color[2] = 0x0;
                stop         = 1;
            } else {
                //   printf2("*** I2C Info ***: Read data is 0x%X\n\r",xact_s.I2C_RD_buffer[0]);
                //  printf2("*** I2C Info ***: rgb_c is 0x%X\n\r",rgb_c);
                // increment rgb on successful xaction
                // rgb_color[0]++;
                
                if(rgb_color[1] == 0) {
                    down = 0;
                }
                if (rgb_color[1] == 255) { 
                    down = 1;
                }
                if( down == 1){
                    rgb_color[1]--;
                } else {
                    rgb_color[1]++;
                }

                //rgb_color[2]++;
            }

            set_blinkm_rgb(&xact_s, rgb_color[0], rgb_color[1], rgb_color[2]);
            if(stop==1) {
                while(1);
            }
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


    xTaskCreate( i2cmultitask, 
            ( signed portCHAR * ) "i2cmultitask", 
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



//   status = xSerialGetChar(0, &theChar, 1);
//   if( status == pdTRUE ) {
//       printf2("You typed the character: '%c'\r\n", theChar);
//  }

