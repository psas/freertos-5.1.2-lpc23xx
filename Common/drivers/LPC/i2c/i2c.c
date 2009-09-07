 

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

int i2c0TxSlaveAddress = 0; //Slave the bus is currently talking to.  NOT the slave address of the LPC23xx device!!!
int i2c0TransmitData [127];  //data to transmit buffer
int i2c0ReceiveData [127];  //data to receive buffer
int i2c0DataCounter = 0;    // bytes sent
int i2c0DataLength  = 0;    // total bytes to send

i
int i2c1TxSlaveAddress = 0; //Slave the bus is currently talking to.  NOT the slave address of the LPC23xx device!!!
int i2c1TransmitData [127];  //data to transmit buffer
int i2c1ReceiveData [127];  //data to receive buffer
int i2c1DataCounter = 0;

int i2c2TxSlaveAddress = 0; //Slave the bus is currently talking to.  NOT the slave address of the LPC23xx device!!!
int i2c2TransmitData [127];  //data to transmit buffer
int i2c2ReceiveData [127];  //data to receive buffer
int i2c2DataCounter = 0;

/*
 * i2cinit
 *
 * 1. Turn on the power to the channel
 * 2. Configure the clock for the channel
 * 3. Set I/O pins to correct mode
 * 4. Configure interrupt in VIC
 * 5. Continue initializing...tbd
 */
void i2cinit(i2c_iface channel) {
    switch(channel) {
        case I2C0: 
            // power
            SET_BIT(PCONP, PCI2C0);

            // Enable
            SET_BIT(I2C0CONSET, I2EN ); // master mode
            ZERO_BIT(I2C0CONSET, AA );

            // i2c clock
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

            // continue initializing...? stopped here on Wed 02 September 2009 11:04:10 (PDT)
            //
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
}

/*
 * i2c0_isr
 */
void i2c0_isr(void) {
    uint32_t status;

    status = I2C0STAT;

    //Read the I2C state from the correct I2STA register and then branch to
    //the corresponding state routine.
    switch(status) {

        //State 0x00 - Bus Error
        case 0x00:
            //write 0x14 to I2CONSET to set the STO and AA flags.
            SET_BIT(I2C0CONCLR, STO);
            SET_BIT(I2C0CONCLR, AA);
            // DBG("Clearing flags");
            //write 0x08 to IXCONCLR to clear the SI flag.
            SET_BIT(I2C0CONCLR, SI);
            //should we log anything?
            break;

        //State 0X08 - A start condition has been transmitted, The Slave Address 
        //and Read or Write bit will be transmitted.  An ACK bit will be received.
        case 0x08:
            //write the Slave Address with R/W bit to I2DAT
             I2C0DAT = i2c0TxSlaveAddress

            //write 0x04 to I2CONSET to set the AA bit
            SET_BIT(I2C0CONSET,AA);

            //write 0x08 to I2CONCLR to clear the SI flag
            SET_BIT(I2C0CONCLR, SI);
            break;


         //State 0x10 - A repeated start condition has been transmitted.  The Slave
         //Address and Read or Write bit will be transmitted.  An ACK bit will be 
         //received
        case 0x10:
             //write the Slave Address with R/W bit to I2DAT
             I2C0DAT = i2c0TxSlaveAddress

            //write 0x04 to I2CONSET to set the AA bit
            SET_BIT(I2C0CONSET,AA);

            //write 0x08 to I2CONCLR to clear the SI flag
            SET_BIT(I2C0CONCLR, SI);
            break;

        //State 0x18 - Previous state was 0x08 or 0x10.  Slave Address and Read or 
        //Write has been transmitted.  An ACK has been received. The first data byte 
        //will be transmitted, an ACK bit will be received.
        case 0x18:
            if(i2c0DataCounter < i2c0DataLength) {
                I2C0DAT = i2cTransmitData[i2c0DataCounter];
                SET_BIT(I2C0CONSET,AA);
                i2c0DataCounter++;
            }
            SET_BIT(I2C0CONCLR, SI);
            break;

        //State 0x20 - Slave Address + Write has been transmitted.  NOT ACK has been 
        //received. A Stop condition will be transmitted.
        case 0x20:
            SET_BIT(I2C0CONSET, STO);
            SET_BIT(I2C0CONSET, AA);
            SET_BIT(I2C0CONCLR, SI);
            break;

        //State 0x28 - Data has been transmitted, ACK has been received. If the 
        //transmitted data was the last data byte then transmit a Stop condition, 
        //otherwise transmit the next data byte.
        case 0x28:
            if(i2c0DataCounter == i2c0DataLength) {
                SET_BIT(I2C0CONSET, STO);
                SET_BIT(I2C0CONSET, AA);
            } else {
                if(i2c0DataCounter < i2c0DataLength) {
                    I2C0DAT = i2cTransmitData[i2c0DataCounter];
                    SET_BIT(I2C0CONSET,AA);
                    i2c0DataCounter++;
                }
            }
            SET_BIT(I2C0CONCLR, SI);
            break;

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

/*SLAVE FUNCTIONALITY IS JUST A STUB FOR NOW
//takes an int containing the slave address the LPC214x should respond to
void initI2C(char *myI2Cchannel, int mySlaveAddress) {
//Load mySlaveAddress to correct I2ADR (slave address register)
//correct per channel given in myI2Cchannel

//enable the I2C interrupt

//put 0x44 in the correct I2CONSET

}
*/  //end SLAVE FUNCTIONALITY IS JUST A STUB FOR NOW


/*
 * I2CMasterTX
 * Master Transmit - Begin a master transmit by setting up the buffer,
 * pointer, and data count, then sending a START
 * takes a string containing the I2C channel to be set up
 * takes an int (should this be byte?) vector containing the data to send
 * takes an int containing the length of the vector (is this needed?)
 */
void I2CMasterTX(enum I2Cchannel myI2Cchannel, int deviceAddr; int *myDataToSend, int dataLength) {

    uint32_t i,j;

    //set up the data to be transmitted in the Master Transmit buffer
    for(i=0; i<dataLength; i++) {
        i2c0TransmitData[i] = myDataToSent[i];
    }

    //initialize master data counter
    i2c0DataCounter = dataLength;

    //set up the Slave Address to transmit data to, and add the Write bit
    i2c0TxSlaveAddress = deviceAddr;
    i2c0TxSlaveAddress &= WRITEMASK;

    //write 0x20 to I2CONSET to set the STA bit
    SET_BIT(I2C0CONSET, STA);

} 

//Master Recieve - Begin a master recieve by setting up the buffer,
//pointer, and data count, then sending a START
//takes a string containing the I2C channel to be set up
//takes an int (should this be byte?) vector containing the data to recieve
//takes a pointer to an int to contain the length of the received data (is this needed?)
void I2CmasterRecieve(enum I2Cchannel myI2Cchannel, int *myDataToSend, int *dataLength) {

i2c0TxSlaveAddres |= READMASK;
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
//this is moving to the ISR funciton.

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

