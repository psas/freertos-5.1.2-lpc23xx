#include "lpc23xx.h"
#include "printf/printf2.h"
#include "FreeRTOSConfig.h"

#include "spi/spi.h"

void spi_init(void)
{
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
    S0SPCR = 0x24;//Master Mode, MSB First, 8 Bit transfers, POL=PHA=0.    
    S0SPCCR = 0x0C;//500Khz

    //Configure SSEL as GPIO Out
    FIO0DIR |= (1<<16);
    FIO0SET |= (1<<16);    
}

/*
 * readSPIStatus
 * ---------------------------------------
 *  check the flags in the status register
 *  return SPIF value
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
 * setBytesPerTransfer
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
 * spiTransferNBytes
 * ----------------------------------
 * This function will transfer up to 32 bits
 * in 1 or 2 byte transfers.
 * This function will keep SSEL (chipselect) 
 * low for the entire transfer.
 */
/*uint32_t spi_transferNBytes(const int32_t payload, const int8_t numBytes) {

    uint32_t byte0, byte1, byte2, byte3;
    uint32_t read_data = 0; 

    if(numBytes < 1 || numBytes > 4) {
        spi_errorMsg("Invalid number of bytes in spiTransferNbytes.\n\r\t1<=numBytes <=4. STOPPING!!\n");
        for(;;){}
    }

    FIO0CLR |= (1<<16);

    spi_setBytesPerTransfer(1);

    byte0 = payload & 0xFF;
    byte1 = (payload & (0xFF << 8))  >> 8;
    byte2 = (payload & (0xFF << 16)) >> 16;
    byte3 = (payload & (0xFF << 24)) >> 24;

    switch(numBytes) {
        case 1: 
            spi_setBytesPerTransfer(1);
            S0SPDR    = byte0;
            WAIT_ON_SPIF;
            read_data = S0SPDR & 0x000000FF;
            break;
        case 2: 
           spi_setBytesPerTransfer(2);
            S0SPDR = payload & 0xFFFF; 
            WAIT_ON_SPIF;
            read_data = S0SPDR & 0x0000FFFF;
            break;
        case 3:
            spi_setBytesPerTransfer(1);
            S0SPDR = byte2;
            WAIT_ON_SPIF;
            read_data = S0SPDR & 0x000000FF;
            S0SPDR = byte1;
            WAIT_ON_SPIF;
            read_data = (read_data << 8) | (S0SPDR & 0x000000FF);
            S0SPDR = byte0;
            WAIT_ON_SPIF;
            read_data = (read_data << 8) | (S0SPDR & 0x000000FF);
            break;
        case 4: 
            spi_setBytesPerTransfer(2);
            S0SPDR = ((byte3 << 8) | byte2);
            WAIT_ON_SPIF;
            read_data = S0SPDR & 0x0000FFFF;
            S0SPDR = ((byte1 << 8 ) | byte0);
            WAIT_ON_SPIF;
            read_data = (read_data << 16) | (S0SPDR & 0x0000FFFF);
            break;
        default:
            spi_errorMsg("Not an available transfer size...write your own?\n\r");
            break;
    }
    FIO0SET |= (1<<16);
    return(read_data);
}*/

void spi_transferNBytes(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize) {

    uint8_t payloadIndex=0;

    FIO0CLR |= (1<<16);
    spi_setBytesPerTransfer(1);
    for (payloadIndex=0;payloadIndex < outPayloadSize;payloadIndex++)
    {
        S0SPDR = outPayload[payloadIndex];
        WAIT_ON_SPIF;
        inPayload[payloadIndex] = S0SPDR;
        printf2("In Write: Sent 0x%X, Recv 0x%X\r\n", outPayload[payloadIndex], inPayload[payloadIndex]);
    }

    for (payloadIndex=outPayloadSize;payloadIndex < inPayloadSize;payloadIndex++)
    {
        S0SPDR = 0xAA;//Dummy to generate clock
        WAIT_ON_SPIF;
        inPayload[payloadIndex] = S0SPDR;
        printf2("In Read: Recv 0x%X\r\n", inPayload[payloadIndex]);
       
    }

    FIO0SET |= (1<<16);

}



/*
 * SPI0_INFO
 * ---------------------------
 */
void spi_infoMsg (char *string) {
    if(SPI0_DEBUG) {
        vSerialPutString(0, (signed portCHAR *) "SPI--INFO--",0);
        vSerialPutString(0, (signed portCHAR *) string,0);
    }
}

/*
 * SPI0_ERROR
 * ---------------------------
 */
void spi_errorMsg (char *string) {
    if(SPI0_DEBUG) {
        vSerialPutString(0, (signed portCHAR *) "SPI--ERROR--",0);
        vSerialPutString(0, (signed portCHAR *) string,0);
    }
}
