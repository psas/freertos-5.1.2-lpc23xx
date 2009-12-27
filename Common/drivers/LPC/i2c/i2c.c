

/*
   I2C handling suite
   Jeremy Booth
   Portland State Aerospace Society
   http://psas.pdx.edu

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

#include <stdint.h>
#include <stdio.h>

#include "lpc23xx.h"
#include "printf/printf2.h"
#include "FreeRTOSConfig.h"

#include "i2c.h"


uint32_t I2C0ExtSlaveAddress = 0;    // Slave the bus is currently talking to.  NOT the slave address of the LPC23xx device!!!
uint32_t I2C0DataCounter     = 0;    // bytes sent
uint32_t I2C0DataLength      = 0;    // total bytes to send

uint32_t I2C1ExtSlaveAddress = 0;
uint32_t I2C1DataCounter     = 0;
uint32_t I2C1DataLength      = 0;

uint32_t I2C2ExtSlaveAddress = 0;
uint32_t I2C2DataCounter     = 0;
uint32_t I2C2DataLength      = 0;

uint8_t I2C0TransmitData[I2C_MAX_BUFFER];  // data to transmit buffer
uint8_t *I2C0ReceiveData;                  // pointer to data to receive buffer

uint8_t I2C1TransmitData[I2C_MAX_BUFFER]; 
uint8_t *I2C1ReceiveData;           

uint8_t I2C2TransmitData[I2C_MAX_BUFFER]; 
uint8_t *I2C2ReceiveData;           


/*
 * I2Cinit
 *
 * 1. Turn on the power to the channel
 * 2. Configure the clock for the channel
 * 3. Set I/O pins to correct mode
 * 4. Configure interrupt in VIC
 * 5. Continue initializing...tbd
 */
void I2Cinit(i2c_iface channel) {

    {
        portENTER_CRITICAL();
        switch(channel) {
            case I2C0: 

//                printf2("\tI2C0 Init! ...\n\r");

                // power
                SET_BIT(PCONP, PCI2C0);

                // Enable
                I2C0CONCLR = 0x7C;
                SET_BIT(I2C0CONSET, I2EN ); // master mode
                ZERO_BIT(I2C0CONSET, AA );
                printf2("I20Conset is 0x%X\n",I2C0CONSET);

                // I2C clock
                I2C0SCLL = I2SCLLOW;
                I2C0SCLH = I2SCLHIGH;

                // 2368 is 100pin package use table 107 p158 lpc23xx usermanual
                PINSEL1 &= SDA0MASK;
                PINSEL1 |= SDA0;
                PINSEL1 &= SCL0MASK;
                PINSEL1 |= SCL0;

                // pinmode: I2C0 pins permanent open drain (pullup)
                // reference: lpc23xx usermanual p158 table 107 footnote 2

                // vic
                // set up VIC p93 table 86 lpc23xx user manual
                SET_BIT(VICIntEnable, VICI2C0EN);
                VICVectAddr9 = (unsigned) i2c0_isr;

                I2C0CONCLR = 0x1<<SI;
                break;

            case I2C1: 

                SET_BIT(PCONP, PCI2C1);

                SET_BIT(I2C1CONSET, I2EN );
                ZERO_BIT(I2C1CONSET, AA );

                I2C1SCLL = I2SCLLOW;
                I2C1SCLH = I2SCLHIGH;

                PINSEL1 &= SDA1MASK;
                PINSEL1 |= SDA1;
                PINSEL1 &= SCL1MASK;
                PINSEL1 |= SCL1;

                PINMODE1 &= SDA1MASK;
                PINMODE1 |= PULLUP;
                PINMODE1 &= SCL1MASK;
                PINMODE1 |= PULLUP;

                SET_BIT(VICIntEnable, VICI2C1EN);
                VICVectAddr19 = (unsigned) i2c1_isr;
                break;

            case I2C2: 

                SET_BIT(PCONP, PCI2C2);

                SET_BIT(I2C2CONSET, I2EN );
                ZERO_BIT(I2C2CONSET, AA );

                I2C2SCLL = I2SCLLOW;
                I2C2SCLH = I2SCLHIGH;

                PINSEL0 &= SDA2MASK;
                PINSEL0 |= SDA2;
                PINSEL0 &= SCL2MASK;
                PINSEL0 |= SCL2;

                PINMODE2 &= SDA2MASK;
                PINMODE2 |= PULLUP;
                PINMODE2 &= SCL2MASK;
                PINMODE2 |= PULLUP;

                SET_BIT(VICIntEnable, VICI2C2EN);
                VICVectAddr30 = (unsigned) i2c2_isr;
                break;


            default:
                //  error         ???
                break;
        }
    };
    portEXIT_CRITICAL();
}

/*
 * i2c0_isr
 */
void i2c0_isr(void) {

    portSAVE_CONTEXT();

        //        FIO1SET & (1<<22)
        //        FIO1CLR = (1<<22);

        uint32_t status;
        uint8_t  holdbyte;

        status = I2C0STAT;

        // status register observability to io pins
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

        //Read the I2C state from the correct I2STA register and then branch to
        //the corresponding state routine.
        switch(status) {

            //State 0x00 - Bus Error
            case 0x00:
                //write 0x14 to I2CONSET to set the STO and AA flags.
                SET_BIT(I2C0CONSET, STO);
                SET_BIT(I2C0CONSET, AA);

                I2C0CONCLR = 0x1<<SI;
                break;

                // State 0X08 - A start condition has been transmitted, The Slave Address 
                // and Read or Write bit will be transmitted.  An ACK bit will be received.
            case 0x08:
                //write the Slave Address with R/W bit to I2DAT
                I2C0DAT = I2C0ExtSlaveAddress;

                //write 0x04 to I2CONSET to set the AA bit
                SET_BIT(I2C0CONSET,AA);

                //write 0x08 to I2CONCLR to clear the SI flag
//                ZERO_BIT(I2C0CONSET, STA);
                I2C0CONCLR = 0x1<<SI;
                break;

                //State 0x10 - A repeated start condition has been transmitted.  The Slave
                //Address and Read or Write bit will be transmitted.  An ACK bit will be 
                //received
            case 0x10:
                //write the Slave Address with R/W bit to I2DAT
                I2C0DAT = I2C0ExtSlaveAddress;

                //write 0x08 to I2CONCLR to clear the SI flag
                ZERO_BIT(I2C0CONSET, STA);
                I2C0CONCLR = 0x1<<SI;
                break;

                //State 0x18 - Previous state was 0x08 or 0x10.  Slave Address and Read or 
                //Write has been transmitted.  An ACK has been received. The first data byte 
                //will be transmitted, an ACK bit will be received.
            case 0x18:

                FIO0SET = (1<<6);//turn on p0.6on olimex 2378 Sdev board
                if(I2C0DataCounter < I2C0DataLength) {

                    FIO0SET = (1<<6);//turn on p0.6on olimex 2378 Sdev board

                    I2C0DAT = I2C0TransmitData[I2C0DataCounter];
                    //                    I2C0DAT = 0x55;
                    SET_BIT(I2C0CONSET,AA);
                    I2C0CONCLR = 0x20;
                    I2C0CONCLR = 0x1<<SI;
                    //    ZERO_BIT(I2C0CONSET, STO);
                    // ZERO_BIT(I2C0CONSET, STA);
                    I2C0DataCounter++;
                }
                break;

                //State 0x20 - Slave Address + Write has been transmitted.  NOT ACK has been 
                //received. A Stop condition will be transmitted.
            case 0x20:

                SET_BIT(I2C0CONSET, STO);
                SET_BIT(I2C0CONSET, AA);
                I2C0CONCLR = 0x1<<SI;
                break;

                //State 0x28 - Data has been transmitted, ACK has been received. If the 
                //transmitted data was the last data byte then transmit a Stop condition, 
                //otherwise transmit the next data byte.
            case 0x28:
                if(I2C0DataCounter == I2C0DataLength) {
                    SET_BIT(I2C0CONSET, STO);
                    I2C0CONCLR = 0x20;
                    // SET_BIT(I2C0CONSET, AA);
                } 
                else if(I2C0DataCounter < I2C0DataLength) {
                    I2C0DAT = I2C0TransmitData[I2C0DataCounter];
                    I2C0CONCLR = 0x20;
                }
                I2C0DataCounter++;
                I2C0CONCLR = 0x1<<SI;
                break;

                //State 0x30 - Data has been transmitted, NOT ACK received. A Stop condition 
                //will be transmitted.
            case 0x30:
                SET_BIT(I2C0CONSET, STO);
                SET_BIT(I2C0CONSET, AA);
                I2C0CONCLR = 0x1<<SI;
                break;

                //State 0x38 - Arbitration has been lost during Slave Address + Write or data. 
                //The bus has been released and not addressed Slave mode is entered. A new Start 
                //condition will be transmitted when the bus is free again.
            case 0x38:
                SET_BIT(I2C0CONSET, STA);
                SET_BIT(I2C0CONSET, AA);
                I2C0CONCLR = 0x1<<SI;
                break;

              // Data has been received, ACK has been returned. Data will be read from I2DAT. Additional
              // data will be received. If this is the last data byte then NOT ACK will be returned, otherwise
              // ACK will be returned.
              //  1. Read data byte from I2DAT into Master Receive buffer.
              //  2. Decrement the Master data counter, skip to step 5 if not the last data byte.
              //  3. Write 0x0C to I2CONCLR to clear the SI flag and the AA bit.
              //  4. Exit
              //  5. Write 0x04 to I2CONSET to set the AA bit.
              //  6. Write 0x08 to I2CONCLR to clear the SI flag.
              //  7. Increment Master Receive buffer pointer
              //  8. Exit

            case 0x50:
                {
                    I2C0ReceiveData[I2C0DataCounter] = I2C0DAT;
                    I2C0DataCounter++;
                }
                /*
                if(I2C0DataCounter == I2C0DataLength) {
                    // I2C0CONCLR = 0xc; // clear AA and SI
                    // I2C0CONCLR = 0x20;   // not in documentation.
                    ZERO_BIT(I2C0CONSET, AA );
                    I2C0CONCLR = 0x1<<SI;
                }
                else if(I2C0DataCounter < I2C0DataLength) {
                    I2C0CONCLR = 0x20;   // not in documentation.
                    SET_BIT(I2C0CONSET, AA);
                    I2C0CONCLR = 0x1<<SI;
                }
                break;
                */

                //  Previous state was State 08 or State 10. Slave Address + Read has been transmitted,
                //  ACK has been received. Data will be received and ACK returned.
                //    1. Write 0x04 to I2CONSET to set the AA bit.
                //    2. Write 0x08 to I2CONCLR to clear the SI flag.
                //    3. Exit
            case 0x40:
                if(I2C0DataCounter < I2C0DataLength -1 ) {
                    I2C0CONSET = 0x1 << AA;  // order important! this then clear start
                    I2C0CONCLR = 0x20;       //     not in documentation.
                } else {
                    //                     ZERO_BIT(I2C0CONSET, AA );
                    I2C0CONCLR = 0x20 | 0x1<<AA;   // not in documentation.
                }
                I2C0CONCLR = 0x1<<SI;
                break;

                //State 0x48 - Slave Address + Read has been transmitted, NOT ACK has been received. 
                //A Stop condition will be transmitted.
            case 0x48:
                SET_BIT(I2C0CONSET, STO);
                SET_BIT(I2C0CONSET, AA);
                I2C0CONCLR = 0x1<<SI;
                break;
                //State: 0x58 - Data has been received, NOT ACK has been returned. Data will be read 
                //from I2DAT. A Stop condition will be transmitted.
            case 0x58:
                I2C0ReceiveData[I2C0DataCounter] = I2C0DAT;
                I2C0DataCounter++;
                SET_BIT(I2C0CONSET, STO);
                SET_BIT(I2C0CONSET, AA);
                I2C0CONCLR = 0x1<<SI;
                break;
            default:
                break;
        }

    VICVectAddr = 0x0;   // clear VIC address

    portRESTORE_CONTEXT();
}


/*
 * i2c1_isr
 */
void i2c1_isr(void) {
    // not implemented
}

/*
 * i2c2_isr
 */
void i2c2_isr(void) {
    // not implemented
}


/*
 * I2CMasterTX
 * Master Transmit - Begin a master transmit by setting up the buffer,
 * pointer, and data count, then sending a START
 * takes a string containing the I2C channel to be set up
 * takes an int (should this be byte?) vector containing the data to send
 * takes an int containing the length of the vector (is this needed?)
 */
void I2C0MasterTX(int deviceaddr, uint8_t *myDataToSend, int datalength) {

    uint8_t i;

    // check datalength - error handling is truncate the buffer requested
    if (datalength >= I2C_MAX_BUFFER) {
        datalength = I2C_MAX_BUFFER-1;
    }
    //set up the data to be transmitted in the Master Transmit buffer
    for(i=0; i<datalength; i++) {
        I2C0TransmitData[i] = myDataToSend[i];
    }

    //initialize master data counter
    I2C0DataLength  = datalength;
    I2C0DataCounter = 0;

    //set up the Slave Address to transmit data to, and add the Write bit
    I2C0ExtSlaveAddress = (deviceaddr << 1);  // 7:1Address 0:low  means write
    printf2("I2C0ExtSlaveAddress is: 0x%X\n\r", I2C0ExtSlaveAddress);
    printf2("I2C0TransmitData    is: 0x%X\n\r", I2C0TransmitData[0]);
    printf2("I2C0DataLength      is: 0x%X\n\r", I2C0DataLength);
    printf2("I2C0DataCounter     is: 0x%X\n\r", I2C0DataCounter);


    //write 0x20 to I2CONSET to set the STA bit
    SET_BIT(I2C0CONSET, STA);

} 

//Master Recieve - Begin a master recieve by setting up the buffer,
//pointer, and data count, then sending a START
//takes a string containing the I2C channel to be set up
//takes an int (should this be byte?) vector containing the data to recieve
//takes a pointer to an int to contain the length of the received data (is this needed?)
void I2C0MasterRX(int deviceAddr, uint8_t *myDataToGet, int datalength) {
    uint8_t i;

    // check datalength - error handling is truncate the buffer requested
    if (datalength >= I2C_MAX_BUFFER) {
        datalength = I2C_MAX_BUFFER-1;
    }
  
    //set up the data to be transmitted in the Master RX buffer
    I2C0ReceiveData = myDataToGet;

    //initialize master data counter
    I2C0DataLength  = datalength;
    I2C0DataCounter = 0;

    // add the Read bit
    I2C0ExtSlaveAddress = (deviceAddr << 1);  // 7:1Address,0:high  means read
    I2C0ExtSlaveAddress |= 0x1;

    SET_BIT(I2C0CONSET, STA);
} 


