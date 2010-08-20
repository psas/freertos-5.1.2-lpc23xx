#ifndef SPI_H_
#define SPI_H_

/*
    SPI Library
    This library uses the SPI block on the LPC2378.
    spi_init must be called before any other function in this library.

    This library only implements Master Mode.
    This library only supports a single slave.
    This library only supports transmitting 8 bits per transfer even though
        the SPI hardware supports transmitting between 8 and 16 bits per transfer.
        There is functionality included to change the bits per transfer but not currently used.

    There are two options for transfering data.
        1. Interrupt Mode
        2. Busy-Wait Mode
    If you choose Interrupt Mode, then you must call spi_initInt before
    you call spi_transferNBytesInt. You must not mix the two methods.

    The pins that this library use by default are:
    
        P0.15   -   SCK
        P0.16   -   SSEL
        P0.17   -   MISO
        P0.18   -   MOSI

    All the pins have the pull up/down resistors turned off.
    This library assumes Fast IO is enabled.
    
    P0.16 is configured as a GPIO output.
    It is used to chip select a single slave.

    if SPIO_DEBUG == 1 then
        the serial port will output information.
    
    
//Example:
//  Notes:    the busy wait methods can be used instead by
//            omitting the call to spi_initInt and replacing
//            the call to spi_transferNBytesInt with a call to
//            spi_transferNBytesBW
//
//            Reading is odd. For every byte sent, you will need memory to store
//            an incoming byte whether you care about it or not.
//            In the example that follows, with the particular device used, meaningful
//            data is not recieved from the device until after all the command bytes 
//            are written. That is why the in-buffer, when a read is intended, is always 
//            bigger than the out-buffer. With this example device, to read, 3 bytes must 
//            first be written to the device to tell it what we want. We will read 3 
//            bytes for the 3 bytes we wrote. Then, we read 1 more byte which is the data 
//            we are interested in.

    static void spi_Int_eepromtask(void *pvParameters);

    int main( void ) {
        SCS |= 1; //Configure FIO

        spi_init();
        spi_initInt();

         xTaskCreate( spi_Int_eepromtask, 
            ( signed portCHAR * ) "spi_Int_eepromtask",  
            SPITEST_STACK_SIZE, NULL, 
            mainCHECK_TASK_PRIORITY - 1, 
            NULL );

        vTaskStartScheduler();

        return 0;
    }


    static void spi_Int_eepromtask(void *pvParameters) {

        uint8_t     do_wait             = 0;
        uint8_t     inPayload[4];
        uint8_t     writeEnableCmd[1]   = {0x06};
        uint8_t     writeCmd[4]         = {0x02, 0x00, 0x02, 0x0D};
        uint8_t     readCmd[3]          = {0x03, 0x00, 0x02};
        uint8_t     readStatusCmd[1]    = {0x05};
    
        //Write 1 byte - ignoring the bytes rx'd while tx'ing
        spi_transferNBytesInt(writeEnableCmd, 1,inPayload,1);
    
        //Write 4 bytes - ignoring the bytes rx'd while tx'ing
        spi_transferNBytesInt(writeCmd,4,inPayload,4);

        //Read status and wait for a write to complete        
        do{
            //Write 1 byte, Read 1 byte - ignoring the bytes rx'd while tx'ing
            spi_transferNBytesInt(readStatusCmd,1,inPayload,2);
            do_wait = (inPayload[1] & 0x01);

        }while (do_wait);

        //Write 3 bytes, Read 1 byte - ignoring the bytes rx'd while tx'ing
        spi_transferNBytesInt(readCmd,3,inPayload,4);
        if (inPayload[3] == writeCmd[3]){
            printf2("Write/Read Success!\r\n");
        }
    }    
 */

#include <stdint.h>
#include "semphr.h"

#define SPI0_DEBUG 0
#define WAIT_ON_SPIF         while (spi_readStatus() == 0) {} 

xSemaphoreHandle spi_IntSemaphore;

void        spi_isr(void) __attribute__ ((naked));
void        spi_infoMsg (char *string);
void        spi_errorMsg (char *string);
void        spi_init(void);
void        spi_initInt(void);
int8_t      spi_readStatus (void);
void        spi_setBytesPerTransfer(const int8_t numBytes);
void        spi_transferNBytesInt(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize);
void        spi_transferNBytesBW(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize);


#endif

