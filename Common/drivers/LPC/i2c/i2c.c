

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


int I2C0ExtSlaveAddress = 0;    // Slave the bus is currently talking to.  NOT the slave address of the LPC23xx device!!!
int I2C0DataCounter     = 0;    // bytes sent
int I2C0DataLength      = 0;    // total bytes to send
int I2C0TransmitData[I2C_MAX_BUFFER];  //data to transmit buffer
int I2C0ReceiveData[I2C_MAX_BUFFER];  //data to receive buffer

int I2C1ExtSlaveAddress = 0;
int I2C1DataCounter     = 0;
int I2C1DataLength      = 0;
int I2C1TransmitData[I2C_MAX_BUFFER];
int I2C1ReceiveData[I2C_MAX_BUFFER];

int I2C2ExtSlaveAddress = 0;
int I2C2DataCounter     = 0;
int I2C2DataLength      = 0;
int I2C2TransmitData[I2C_MAX_BUFFER];
int I2C2ReceiveData[I2C_MAX_BUFFER];

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

    switch(channel) {
        portENTER_CRITICAL();
        {
            case I2C0: 
                printf2("\tI2C0 Init! ...\n\r");
                // power
                SET_BIT(PCONP, PCI2C0);

                // Enable
                I2C0CONCLR = 0x7C;
                SET_BIT(I2C0CONSET, I2EN ); // master mode
                ZERO_BIT(I2C0CONSET, AA );

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

                portEXIT_CRITICAL();
        }

        case I2C1: 
        portENTER_CRITICAL();
        {

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

            portEXIT_CRITICAL();
        }

        case I2C2: 
        portENTER_CRITICAL();
        {

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

            portEXIT_CRITICAL();
        }

        default:
        //  error         ???
        break;
    }
}

/*
 * i2c0_isr
 */
void i2c0_isr(void) {

    portSAVE_CONTEXT();

//    FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board
    FIO1SET = (1<<19);//turn on led on olimex 2378 dev board


//     printf2("\tI2C0 ISR! ...\n\r");
    uint32_t status;
    uint8_t  holdbyte;

    status = I2C0STAT;

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
            I2C0CONCLR = 0x1<<SI;
            break;


            //State 0x10 - A repeated start condition has been transmitted.  The Slave
            //Address and Read or Write bit will be transmitted.  An ACK bit will be 
            //received
        case 0x10:
            //write the Slave Address with R/W bit to I2DAT
            I2C0DAT = I2C0ExtSlaveAddress;

            //write 0x04 to I2CONSET to set the AA bit
            SET_BIT(I2C0CONSET,AA);

            //write 0x08 to I2CONCLR to clear the SI flag
            I2C0CONCLR = 0x1<<SI;
            break;

            //State 0x18 - Previous state was 0x08 or 0x10.  Slave Address and Read or 
            //Write has been transmitted.  An ACK has been received. The first data byte 
            //will be transmitted, an ACK bit will be received.
        case 0x18:
            if(I2C0DataCounter < I2C0DataLength) {
                I2C0DAT = I2C0TransmitData[I2C0DataCounter];
                SET_BIT(I2C0CONSET,AA);
                I2C0DataCounter++;
            }
            I2C0CONCLR = 0x1<<SI;
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
                SET_BIT(I2C0CONSET, AA);
            } else {
                if(I2C0DataCounter < I2C0DataLength) {
                    I2C0DAT = I2C0TransmitData[I2C0DataCounter];
                    SET_BIT(I2C0CONSET,AA);
                    I2C0DataCounter++;
                }
            }
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

            //State 0x40
            //Previous state was State 08 or State 10. Slave Address + Read has been transmitted,
            //ACK has been received. Data will be received and ACK returned.
        case 0x40:
            SET_BIT(I2C0CONSET, AA);
            I2C0CONCLR = 0x1<<SI;
            break;

            //State 0x48 - Slave Address + Read has been transmitted, NOT ACK has been received. 
            //A Stop condition will be transmitted.
        case 0x48:
            SET_BIT(I2C0CONSET, STO);
            SET_BIT(I2C0CONSET, AA);
            I2C0CONCLR = 0x1<<SI;
            break;

            //State: 0x50 - Data has been received, ACK has been returned. Data will be read 
            //from I2DAT. Additional data will be received. If this is the last data byte then 
            //NOT ACK will be returned, otherwise ACK will be returned.
        case 0x50:
            if(I2C0DataCounter < I2C0DataLength) {
                I2C0ReceiveData[I2C0DataCounter] = I2C0DAT;
            }
            I2C0DataCounter++;
            if(I2C0DataCounter == I2C0DataLength) {
                I2C0CONCLR = 0x1<<AA;
            } else if(I2C0DataCounter < I2C0DataLength) {
                SET_BIT(I2C0CONSET, AA);
            }
            I2C0CONCLR = 0x1<<SI;
            break;

            //State: 0x58 - Data has been received, NOT ACK has been returned. Data will be read 
            //from I2DAT. A Stop condition will be transmitted.
        case 0x58:
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
void I2C0MasterTX(int deviceAddr, int *myDataToSend, int dataLength) {

    uint32_t i;

    //set up the data to be transmitted in the Master Transmit buffer
    for(i=0; i<dataLength; i++) {
        I2C0TransmitData[i] = myDataToSend[i];
    }
    //initialize master data counter
    I2C0DataLength  = dataLength;
    I2C0DataCounter = 0;

    //set up the Slave Address to transmit data to, and add the Write bit
    I2C0ExtSlaveAddress = deviceAddr;
    I2C0ExtSlaveAddress &= WRITEMASK;

    //write 0x20 to I2CONSET to set the STA bit
    SET_BIT(I2C0CONSET, STA);

} 

//Master Recieve - Begin a master recieve by setting up the buffer,
//pointer, and data count, then sending a START
//takes a string containing the I2C channel to be set up
//takes an int (should this be byte?) vector containing the data to recieve
//takes a pointer to an int to contain the length of the received data (is this needed?)
void I2C0MasterRX(int deviceAddr, int *myDataToSend, int dataLength) {
    uint32_t i;

    //set up the data to be transmitted in the Master RX buffer
    for(i=0; i<dataLength; i++) {
        I2C0ReceiveData[i] = myDataToSend[i];
    }

    //initialize master data counter
    I2C0DataLength  = dataLength;
    I2C0DataCounter = 0;

    // add the Read bit
    I2C0ExtSlaveAddress = deviceAddr;
    I2C0ExtSlaveAddress |= READMASK;

    SET_BIT(I2C0CONSET, STA);
} 


