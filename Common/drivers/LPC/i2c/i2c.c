 

/*
	i2c handling suite
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

#include "i2c.h"

// 1. Turn on the power to the channel
// 2. Configure the clock for the channel
// 3. Set I/O pins to correct mode
// 4. Configure interrupt in VIRC
// 5. Continue initializing
void I2Cinit(I2Cchannel channel) {
    switch(channel) {
        set up VIC p93 table 86
        case I2C0: 
            // power
            SET_BIT(PCONP, PCI2C0);

            // Enable
            SET_BIT(I20CONSET,    I2EN    );

            // i2c clock
            I2C0SCLL = I2SCLLOW;
            I2C0SCLH = I2SCLHIGH;

            //2368 is 100pin package use table 107 p 158
            // pins
            PINSEL1 &= SDA0MASK;
            PINSEL1 |= SDA0;
            PINSEL1 &= SCL0MASK;
            PINSEL1 |= SCL0;

            // vic
            SET_BIT(VICIntEnable, VICI2C0EN);
            channel 9 
            break;
        case I2C1: 
            SET_BIT(PCONP, PCI2C1);

            SET_BIT(I21CONSET, I2EN );

            I2C1SCLL = I2SCLLOW;
            I2C1SCLH = I2SCLHIGH;

            PINSEL1 &= SDA1MASK;
            PINSEL1 |= SDA1;
            PINSEL1 &= SCL1MASK;
            PINSEL1 |= SCL1;

            SET_BIT(VICIntEnable, VICI2C1EN);
            break;
        case I2C2: 
            SET_BIT(PCONP, PCI2C2);

            SET_BIT(I22CONSET, I2EN );

            I2C2SCLL = I2SCLLOW;
            I2C2SCLH = I2SCLHIGH;

            PINSEL0 &= SDA2MASK;
            PINSEL0 |= SDA2;
            PINSEL0 &= SCL2MASK;
            PINSEL0 |= SCL2;

            SET_BIT(VICIntEnable, VICI2C2EN);
            break;
        default:
            //  error         ???
            break;
    }
}


/*SLAVE FUNCTIONALITY IS JUST A STUB FOR NOW
//takes an int containing the slave address the LPC214x should respond to
void initI2C(char *myI2Cchannel, int mySlaveAddress) {
//Load mySlaveAddress to correct I2ADR (slave address register)
//correct per channel given in myI2Cchannel

//enable the I2C interrupt

//put 0x44 in the correct I2CONSET

}
*/  //end SLAVE FUNCTIONALITY IS JUST A STUB FOR NOW


//Master Transmit - Begin a master transmit by setting up the buffer,
//pointer, and data count, then sending a START
//takes a string containing the I2C channel to be set up
//takes an int (should this be byte?) vector containing the data to send
//takes an int containing the length of the vector (is this needed?)
void I2CmasterTransmit(enum I2Cchannel myI2Cchannel, int *myDataToSend, int dataLength) {


//initialize master data counter
//this seems to only exist in the I2C software example, so I'm assuming it's just to be a logical construction

//set up the Slave Address to transmit data to, and add the Write bit

//write 0x20 to I2CONSET to set the STA bit

//set up the data to be transmitted in the Master Transmit buffer

//initialize the Master data counter to match the length of the data being
//sent (why are we initializing this twice???)

//exit/return

} 

//Master Recieve - Begin a master recieve by setting up the buffer,
//pointer, and data count, then sending a START
//takes a string containing the I2C channel to be set up
//takes an int (should this be byte?) vector containing the data to recieve
//takes a pointer to an int to contain the length of the received data (is this needed?)
void I2CmasterRecieve(enum I2Cchannel myI2Cchannel, int *myDataToSend, int *dataLength) {

//initialize master data counter
//this seems to only exist in the I2C software example, so I'm assuming it's just to be a logical construction

//set up the Slave Address from which to recieve data, and add the Read bit

//write 0x20 to I2CONSET to set the STA bit

//set up the data to be transmitted in the Master Transmit buffer

//initialize the Master data counter to match the length of the data to be //received (why are we initializing this twice???)

//exit/return

} 


//This is to handle the state machine aspect of the I2C hardware.
//It needs to be interrupt driven...  This seems uncomfortable...
//It should take the I2C channel it's working on as an input.
void i2cStateHandler(enum I2Cchannel myI2Cchannel) {

//Read the I2C state from the correct I2STA register and then branch to
//the corresponding state routine.
//SLAVE FUNCTIONALITY IS JUST A STUB FOR NOW

//State 0x00 - Bus Error

//write 0x14 to I2CONSET to set the STO and AA flags.
//write 0x08 to IXCONCLR to clear the SI flag.
//exit


//State 0X08 - A start condition has been transmitted, The Slave Address 
//and Read or Write bit will be transmitted.  An ACK bit will be received.

//write the Slave Address with R/W bit to I2DAT
//write 0x04 to I2CONSET to set the AA bit
//write 0x08 to I2CONCLR to clear the SI flag
//set up the Master Transmit data buffer
//set up the Master Recieve data buffer
//initialize the Master data counter
  //this seems to only exist in the I2C software example, so I'm assuming it's just to be a logical construction
//exit


//State 0x10 - A repeated start condition has been transmitted.  The Slave
//Address and Read or Write bit will be transmitted.  An ACK bit will be 
//received

//write the Slave Address with R/W bit to I2DAT
//write 0x04 to I2CONSET to set the AA bit
//write 0x08 to I2CONCLR to clear the SI flag
//set up the Master Transmit data buffer
//set up the Master Recieve data buffer
//initialize the Master data counter
  //this seems to only exist in the I2C software example, so I'm assuming it's just to be a logical construction
//exit


//State 0x18 - Previous state was 0x08 or 0x10.  Slave Address and Read or 
//Write has been transmitted.  An ACK has been received. The first data byte 
//will be transmitted, an ACK bit will be received.

//Load I2DAT with first data byte from Master Transmit buffer.
//Write 0x04 to I2CONSET to set the AA bit.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Increment Master Transmit buffer pointer.
//Exit


//State 0x20 - Slave Address + Write has been transmitted.  NOT ACK has been 
//received. A Stop condition will be transmitted.

//Write 0x14 to I2CONSET to set the STO and AA bits.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit


//State 0x28 - Data has been transmitted, ACK has been received. If the 
//transmitted data was the last data byte then transmit a Stop condition, 
//otherwise transmit the next data byte.

//Decrement the Master data counter, skip to NOT_LAST_BYTE if not the last data byte.
//Write 0x14 to I2CONSET to set the STO and AA bits.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit
//NOT_LAST_BYTE:
//Load I2DAT with next data byte from Master Transmit buffer.
//Write 0x04 to I2CONSET to set the AA bit.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Increment Master Transmit buffer pointer
//Exit


//State 0x30 - Data has been transmitted, NOT ACK received. A Stop condition 
//will be transmitted.

//Write 0x14 to I2CONSET to set the STO and AA bits.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit


//State 0x38 - Arbitration has been lost during Slave Address + Write or data. 
//The bus has been released and not addressed Slave mode is entered. A new Start 
//condition will be transmitted when the bus is free again.

//Write 0x24 to I2CONSET to set the STA and AA bits.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit


//State 0x40
//Previous state was State 08 or State 10. Slave Address + Read has been transmitted,
//ACK has been received. Data will be received and ACK returned.

//Write 0x04 to I2CONSET to set the AA bit.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit


//State 0x48 - Slave Address + Read has been transmitted, NOT ACK has been received. 
//A Stop condition will be transmitted.

//Write 0x14 to I2CONSET to set the STO and AA bits.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit


//State: 0x50 - Data has been received, ACK has been returned. Data will be read 
//from I2DAT. Additional data will be received. If this is the last data byte then 
//NOT ACK will be returned, otherwise ACK will be returned.

//Read data byte from I2DAT into Master Receive buffer.
//Decrement the Master data counter, skip to NOT_LAST_BYTE if not the last data byte.
//Write 0x0C to I2CONCLR to clear the SI flag and the AA bit.
//Exit
//NOT_LAST_BYTE:
//Write 0x04 to I2CONSET to set the AA bit.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Increment Master Receive buffer pointer
//Exit


//State: 0x58 - Data has been received, NOT ACK has been returned. Data will be read 
//from I2DAT. A Stop condition will be transmitted.

//Read data byte from I2DAT into Master Receive buffer.
//Write 0x14 to I2CONSET to set the STO and AA bits.
//Write 0x08 to I2CONCLR to clear the SI flag.
//Exit


//more states follow, but are all slave states...  Not including them yet.





}

