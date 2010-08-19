#include "lpc23xx.h"
#include "printf/printf2.h"
#include "FreeRTOSConfig.h"

#include "spi/spi.h"

/*
 * spi_init 
 * ---------------------------------------
 * must be the first function called when using this library.
 * This function configures the hardware to be in master mode.
 * Fast IO is assumed.
 * SSEL is a GPIO output.
 */
void spi_init(void)
{
    vSemaphoreCreateBinary( spi_semaphore );
    
    //Power
    PCONP   |= (1<<8);              //pg.69
    
    //Clock
    PCLKSEL0 |= (1<<17) | (1<<16);//=48Mhz/8  pg.63    

    //Pin Function
    PINSEL0 |= (1<<31) | (1<<30);
    //PINSEL1 |= (1<<1)  | (1<<0);//P0.16 - SSEL as a GPIO
    PINSEL1 |= (1<<3)  | (1<<2);
    PINSEL1 |= (1<<5)  | (1<<4);

    //Pin Mode
    PINMODE0 = (PINMODE0 | (1<<31)) & ~(1<<30);
    PINMODE1 = (PINMODE1 | (1<<1))  & ~(1<<0);
    PINMODE1 = (PINMODE1 | (1<<3))  & ~(1<<2);
    PINMODE1 = (PINMODE1 | (1<<5))  & ~(1<<4);

    //SPI Settings
    S0SPCR = 0x24;//Master Mode, MSB First, variable Bit transfers, POL=PHA=0.    
    


    S0SPCCR = 0x0C;//500Khz

    //Configure SSEL as GPIO Out
    FIO0DIR |= (1<<16);
    FIO0SET |= (1<<16);   


  
}

/*
 * spi_initInt
 * ---------------------------------------
 * Must call this before using the interrupt version
 * of the transfer function.
 */
void spi_initInt(void)
{
    S0SPCR |= (1<<7);//Turn on SPI Interrupts.pg.462
    VICIntEnable |= (1<<10);//pg.94
    VICVectAddr10  = spi_isr;
}

void spi_isr(void)
{
    portSAVE_CONTEXT();
    static signed portBASE_TYPE xHigherPriorityTaskWoken= pdFALSE;
    FIO1PIN = FIO1PIN ^ (1<<19);   
    //Between Boilerplate..
    S0SPINT |= (1<<0);      //Clear SPI Interrupt Flag by writing a 1 to it.
    VICVectAddr = 0x0;      // Update VIC hardware
    xSemaphoreGiveFromISR( spi_semaphore, &xHigherPriorityTaskWoken );
    if( xHigherPriorityTaskWoken ) {
	    portYIELD_FROM_ISR();
    }
    
    portRESTORE_CONTEXT();
}


/*
 * spi_readStatus
 * ---------------------------------------
 * check the flags in the status register
 * return SPIF value
 */
int8_t spi_readStatus (void) {

    unsigned int SPIStatus;

    int8_t abrt, modf, rovr, wcol, spif;

    SPIStatus = S0SPSR;
    abrt = (SPIStatus & 0x8 ) >> 3;
    modf = (SPIStatus & 0x10) >> 4;
    rovr = (SPIStatus & 0x20) >> 5;
    wcol = (SPIStatus & 0x40) >> 6;
    spif = (SPIStatus & 0x80) >> 7;

    if(abrt==1) { 
        spi_errorMsg("Slave Abort occurred\n\r");
    }

    if(modf==1) { 
        spi_errorMsg("Mode Fault occurred\n\r");
    }

    if(rovr==1) { 
        spi_errorMsg("Read Overrun occurred\n\r");
    }

    if(wcol==1) { 
        spi_errorMsg("Write Collision occurred\n\r");
    }

    if(spif==1) { 
        spi_infoMsg("SPIF is 1 - clearing\n\r");
    }

    S0SPCR = S0SPCR; // write cr register to clear status bit
    return(spif);
}

/*
 * spi_setBytesPerTransfer
 * -----------------------------------
 * Some transfers are two bytes, some one byte
 * For SPI, this means changing the control register 
 * before the transfer.
 */
void spi_setBytesPerTransfer(const int8_t numBytes ) {
    switch(numBytes) {
        case 1:
            S0SPCR = (S0SPCR & 0xF0FF) | (1<<11);
            break;
        case 2:
            S0SPCR &= 0xF0FF;
            break;
        default:
            spi_errorMsg("Not a recognized transfer size for this device.\n\r");
            S0SPCR = (S0SPCR & 0xF0FF) | (1<<11);
            break;
    }
}

/*
 * spi_transferNBytesInt
 * ----------------------------------
 * This function will transfer up to 32 bits
 * This function utilizes interrupts.
 * in 1 or 2 byte transfers.
 * This function will keep SSEL (chipselect) 
 * low for the entire transfer.
 * Assumes spi_initInt was called.
 *
 * notes:
 * clocks are generated when S0SPDR is written to. So, if you intend to read, then you must first write.
 */
void spi_transferNBytesInt(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize) {

    uint8_t payloadIndex=0;
    int8_t spiStatus;
    FIO0CLR |= (1<<16);
    spi_setBytesPerTransfer(1);
    for (payloadIndex=0;payloadIndex < outPayloadSize;payloadIndex++)
    {
        S0SPDR = outPayload[payloadIndex];
        xSemaphoreTake( spi_semaphore, portMAX_DELAY );
        spiStatus = spi_readStatus();
        inPayload[payloadIndex] = S0SPDR;
        //printf2("W: Tx 0x%X, Rx 0x%X\r\n", outPayload[payloadIndex], inPayload[payloadIndex]);
    }

    for (payloadIndex=outPayloadSize;payloadIndex < inPayloadSize;payloadIndex++)
    {
        S0SPDR = 0xAA;//Dummy to generate clock
        xSemaphoreTake( spi_semaphore, portMAX_DELAY );
        spiStatus = spi_readStatus();
        inPayload[payloadIndex] = S0SPDR;
        //printf2("R: Rx 0x%X\r\n", inPayload[payloadIndex]);       
    }

    FIO0SET |= (1<<16);

}
/*
 * spi_transferNBytesBW
 * ----------------------------------
 * This function will transfer up to 32 bits
 * This function utilizes Busy Waits.
 * in 1 or 2 byte transfers.
 * This function will keep SSEL (chipselect) 
 * low for the entire transfer.
 *
 * notes:
 * clocks are generated when S0SPDR is written to. So, if you intend to read, then you must first write.
 */
void spi_transferNBytesBW(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize) {

    uint8_t payloadIndex=0;
    FIO0CLR |= (1<<16);
    spi_setBytesPerTransfer(1);
    for (payloadIndex=0;payloadIndex < outPayloadSize;payloadIndex++)
    {
        S0SPDR = outPayload[payloadIndex];
        WAIT_ON_SPIF;
        inPayload[payloadIndex] = S0SPDR;
        //printf2("W: Tx 0x%X, Rx 0x%X\r\n", outPayload[payloadIndex], inPayload[payloadIndex]);
    }

    for (payloadIndex=outPayloadSize;payloadIndex < inPayloadSize;payloadIndex++)
    {
        S0SPDR = 0xAA;//Dummy to generate clock
        WAIT_ON_SPIF;
        inPayload[payloadIndex] = S0SPDR;
        //printf2("R: Rx 0x%X\r\n", inPayload[payloadIndex]);       
    }

    FIO0SET |= (1<<16);

}


/*
 * spi_infoMsg
 * ---------------------------
 */
void spi_infoMsg (char *string) {
    if(SPI0_DEBUG) {
        vSerialPutString(0, (signed portCHAR *) "SPI--INFO--",0);
        vSerialPutString(0, (signed portCHAR *) string,0);
    }
}

/*
 * spi_errorMsg
 * ---------------------------
 */
void spi_errorMsg (char *string) {
    if(SPI0_DEBUG) {
        vSerialPutString(0, (signed portCHAR *) "SPI--ERROR--",0);
        vSerialPutString(0, (signed portCHAR *) string,0);
    }
}
