

#include "ssp.h"
#include "gpdmaExterns.h"

#ifndef NULL
# define NULL 0
#endif


/******************************************************************************
* Function name:	isSSP0_TX_FIFO_Empty
*
* Descriptions:		Returns 1 if SSP0 transmit FIFO is empty
*
******************************************************************************/
bool isSSP0_TX_FIFO_Empty(void) {
	if( SSP0SR & (1<<0) ) {
		return(true);
	} else {
		return(false);
	}
}


/******************************************************************************
* Function name:	isSSP0TransmitFIFOEmpty
*
* Descriptions:		Returns 1 if SSP0 transmit FIFO is empty
*
******************************************************************************/
bool isSSP0TransmitFIFOEmpty(void) {
	return( (SSP0SR & 0x1) == 1 );
}


/******************************************************************************
* Function name:	isSSP0TransmitFIFONotFull
*
* Descriptions:		Returns 1 if SSP0 transmit FIFO is not full
*
******************************************************************************/
bool isSSP0TransmitFIFONotFull(void) {
	return( (SSP0SR & (1<<1)) != 0 );
}


/******************************************************************************
 * Description: This is used to take the SSEL output line low, there by selecting the SPI perepherial in question. 
 *      Note: it's implimented as gpio to allow for multi-byte transfers to devices that don't allow an edge transition between bytes.
 * 
 * Parameters:
 *    -status: true to take the line high, false to take the line low.
 * 
 * Return Value(s): none
 * 
 *****************************************************************************/
static void setSSP0ChipSelect(const bool status) {
	if( status ) {
		//FIO0SET |= (1<<15);
		FIO1SET |= (1<<21);
	} else {
		//FIO0CLR |= (1<<15);
		FIO1CLR |= (1<<21);
	}
}


/******************************************************************************
 * Description: This is used to take the SSEL output line low, there by selecting the SPI perepherial in question. 
 *      Note: it's implimented as gpio to allow for multi-byte transfers to devices that don't allow an edge transition between bytes.
 * 
 * Parameters:
 *    -status: true to take the line high, false to take the line low.
 * 
 * Return Value(s): none
 * 
 *****************************************************************************/
static void setSSP1ChipSelect(const bool status) {
	if( status ) {
		FIO0SET |= (1<<6);
	} else {
		FIO0CLR |= (1<<6);
	}
}

/*
static void waitForSSP0TransmitFifoEmpty(void) {
	while( (SSP0SR & (1<<0)) == 0 || (SSP0SR & (1<<4)) == 1) {}//wait for transmit fifo to empty
}

static void waitForSSP1TransmitFifoEmpty(void) {
	while( (SSP1SR & (1<<0)) == 0 || (SSP1SR & (1<<4)) == 1) {}//wait for transmit fifo to empty
}
*/


/******************************************************************************
 * Description: Initialized the SSP0 control into SPI mode. 
 * 
 * Parameters:
 *    -ssp0SerialClockRate: Further divider of output of pre-scalar 
 *    -ssp0ClockPrescalar: Prescaler going into the SSP peripheral, must be between 2 and 255
 * 
 * Return Value(s): none 
 * 
 *****************************************************************************/
void initSSP0(
		const uint8_t dataSize, /*default 7, equivalent to 8 bits per transfer*/
		const uint8_t frameFormat, /*Default to 0 for SPI frame format*/
		const bool clockOutPolarity,/*Default to false*/
		const bool clockPhase,/*Default to false*/
		const bool slaveOutDisable,/*default to false*/
		const uint8_t ssp0ClocksPerBit,
		const uint8_t ssp0ClockPrescalar,
		const bool masterMode,
		const bool cphaFlag/*Default false*/
		)
{
	PCONP |= (1 << 21);//Power up SSP0
	PCLKSEL1 |= (1 << 10);//Configure SSP0 to run at CCLK speed

	/*if (!masterMode) {
		PINMODE3 |= (1 << 9);//P1.20, Disable pullup and pull down resistors, make floating
	}
	PINMODE3 |= (1 << 11);//P1.21, Disable pullup and pull down resistors, make floating
	PINMODE3 |= (1 << 15);//P1.23, Disable pullup and pull down resistors, make floating
	PINMODE3 |= (1 << 17);//P1.24, Disable pullup and pull down resistors, make floating

	if (!masterMode) {
		PINSEL3 |= (1 << 11) | (1 << 10); //Configure P1.21 in SSEL0 mode
	} else {
		FIO1DIR |= (1 << 21);//set to GPIO output fio for P1.21
	}
	PINSEL3 |= (1 << 9) | (1 << 8); //Configure P1.20 in SCK0 mode
	PINSEL3 |= (1 << 14) | (1 << 15); //Configure P1.23 in MISO0 mode
	PINSEL3 |= (1 << 16) | (1 << 17); //Configure P1.24 in MOSI0 mode*/

	setSSP0ChipSelect(true);

	//PINMODE0 |= (1<<31);//P0.15, Disable pullup and pull down resistors, make floating
	//PINMODE1 |= (1<<1);//P0.16, Disable pullup and pull down resistors, make floating
	//PINMODE1 |= (1<<3);//P0.17, Disable pullup and pull down resistors, make floating
	//PINMODE1 |= (1<<5);//P0.18, Disable pullup and pull down resistors, make floating


	SSP0CR0 = 0;
	SSP0CR0 |= (dataSize & 0x0F);//Set bits per transfer
	SSP0CR0 |= (frameFormat & 0x03);
	SSP0CR0 |= (ssp0ClocksPerBit << 8);//Set the serial clock rate
	if (clockOutPolarity) {
		SSP0CR0 |= (1 << 6);
	}
	if (clockPhase) {
		SSP0CR0 |= (1 << 7);
	}

	SSP0CPSR = ssp0ClockPrescalar;
	if (masterMode) {
		SSP0CR1 &= ~(1 << 2); //set master mode
	} else {
		SSP0CR1 |= (1 << 2); //set slave mode
	}

	if (cphaFlag) {
		SSP0CR0 |= (1 << 7);
	} else {
		SSP0CR0 &= ~(1 << 7);
	}

	if (slaveOutDisable) {
		SSP0CR1 |= (1 << 3);
	} else {
		SSP0CR1 &= ~(1 << 3);
	}

	SSP0CR1 |= (1 << 1);//Enable SSP0

	for (int i = 0; i < 8; i++) {
		SSP0DR; /* clear the RxFIFO */
	}
}


/******************************************************************************
* Function name:	appendToSSP0TransmitFIFO
*
* Descriptions:		Adds data to transmit FIFO
*
 *****************************************************************************/
void appendToSSP0TransmitFIFO(const uint16_t data) {
	SSP0DR = data;
}


/******************************************************************************
 * Description: Initialized the SSP1 control into SPI mode. 
 * 
 * Parameters:
 *    -ssp1SerialClockRate: Further divider of output of pre-scalar 
 *    -ssp1ClockPrescalar: Prescaler going into the SSP peripheral, must be between 2 and 255
 * 
 * Return Value(s): none 
 * 
 *****************************************************************************/
void initSSP1(const uint8_t ssp1SerialClockRate, const uint8_t ssp1ClockPrescalar, const bool masterMode, const bool cphaFlag) {
	PCONP |= (1<<10);//Power up SSP1
	PCLKSEL0 |= (1<<20);//Configure SSP1 to run at CCLK speed
	
	if( ! masterMode ) {
		PINMODE0 |= (1<<13);//P0.6, Disable pullup and pull down resistors, make floating
	}
	PINMODE0 |= (1<<15);//P0.7, Disable pullup and pull down resistors, make floating
	PINMODE0 |= (1<<17);//P0.8, Disable pullup and pull down resistors, make floating
	PINMODE0 |= (1<<19);//P0.9, Disable pullup and pull down resistors, make floating
	

	if( ! masterMode ) {
		PINSEL0 |= (1<<13);//Configure P0.6 in SSEL1 mode
	} else {
		FIO0DIR |= (1<<6);//set to GPIO output fio for P0.6
	}
	PINSEL0 |= (1<<15);//Configure P0.7 in SCK1 mode
	PINSEL0 |= (1<<17);//Configure P0.8 in MISO1 mode
	PINSEL0 |= (1<<19);//Configure P0.9 in MOSI1 mode
	
	setSSP1ChipSelect(true);
	
	SSP1CR0 = 0;
	SSP1CR0 |= 7; //set 8-bit transfers
	SSP1CR0 |= (ssp1SerialClockRate<<8);//Set the serial clock rate
	
	SSP1CPSR = ssp1ClockPrescalar;
	
	if( masterMode ) {
		SSP1CR1 &= ~(1<<2);
	} else {
		SSP1CR1 |= (1<<2);
	}
	
	if( cphaFlag ) {
		SSP1CR0 |= (1<<7);
	} else {
		SSP1CR0 &= ~(1<<7);
	}
	
	SSP1CR1 |= (1<<1);//Enable SSP1
	

	for (int i = 0; i < 8; i++) {
		SSP1DR; /* clear the RxFIFO */
	}
}


/******************************************************************************
 * Description: FIXME document this
 * 
 * Parameters:
 * 
 * Return Value(s): 
 * 
 *****************************************************************************/
/*
bool transmitSSP1_SPI_BufferViaDMA(const uint8_t *data, const uint16_t numBytes) {
	//configure dma controller
	//trigger dma transfer
	//wait for dma transfer to finish
	
	//GPDMA_CONFIG &= ~(0x01);//Disable GPDMA
	
	
	GPDMA_CH0_CFG &= ~(GPDMA_CHx_CFG_GPDMA_ENABLE_MASK);//Disable DMA channel 0
	GPDMA_CH1_CFG &= ~(GPDMA_CHx_CFG_GPDMA_ENABLE_MASK);//Disable DMA channel 1

	
	GPDMA_CH0_DEST = (unsigned long)&SSP1DR;
	GPDMA_CH0_CFG |= (0x01 << 11);	//Configure DMA Channel 0 to be memory to peripheral flow control
	GPDMA_CH0_CFG |= (1<<2);//Configure Dest Peripheral to be SSP1/TX
	GPDMA_CH0_CFG |= (1<<7);//Configure Dest Peripheral to be SSP1/TX
	
	
	for(int i = 0; i < numBytes; i++ ) {
		dmaMemoryArrayOut0[i] = data[i];
	}
	
	GPDMA_CH0_SRC = (uint32_t) dmaMemoryArrayOut0;
	GPDMA_CH0_DEST = (uint32_t) &SSP1DR;
	
	GPDMA_CH0_CTRL =
		(numBytes & 0x0FFF) //transfer size
		| (1 << DMACC0Control_SBSize_BIT) //source burst size, burst size of SSP1 = 4bytes, 1/2fifo length
		| (1 << DMACC0Control_DBSize_BIT) //dest. burst size, burst size of SSP1 = 4bytes, 1/2fifo length
		| (0 << DMACC0Control_SWidth_BIT) //source transfer width, transfer width of SSP1 = 1 bytes
		| (0 << DMACC0Control_DWidth_BIT) //dest. transfer width, transfer width of SSP1 =  1 bytes
		| (1 << DMACC0Control_SI_BIT) //source increment, increment thru the DMA memory range
		| (0 << DMACC0Control_DI_BIT) //dest. increment, always send to the SSP1DR register
		| (1 << DMACC0Control_I_BIT);
	
	
	GPDMA_CH0_CFG |= GPDMA_CHx_CFG_GPDMA_ENABLE_MASK;
	
	GPDMA_CONFIG |= 0x01;//Enable GPDMA
	
	SSP1DMACR = (1<<1);//Enable the SSP1 DMA transmit FIFO.

	return(true);
}


bool transmitSSP0_SPI_BufferViaDMA0(const uint8_t *data, const uint16_t numBytes) {
	//configure dma controller
	//trigger dma transfer
	//wait for dma transfer to finish
	
	//GPDMA_CONFIG &= ~(0x01);//Disable GPDMA
	
	
	GPDMA_CH0_CFG &= ~(GPDMA_CHx_CFG_GPDMA_ENABLE_MASK);//Disable DMA channel 0
	GPDMA_CH1_CFG &= ~(GPDMA_CHx_CFG_GPDMA_ENABLE_MASK);//Disable DMA channel 1

	
	GPDMA_CH0_CFG |= (0x01 << 11);	//Configure DMA Channel 0 to be memory to peripheral flow control
	GPDMA_CH0_CFG = GPDMA_CH0_CFG & ~(0x0F << 1);//Configure Dest Peripheral to be SSP0/TX
	GPDMA_CH0_CFG = GPDMA_CH0_CFG & ~(0x0F << 6);//Configure Dest Peripheral to be SSP0/TX
	
	
	if( data != dmaMemoryArrayOut0 ) {
		for(int i = 0; i < numBytes; i++ ) {
			dmaMemoryArrayOut0[i] = data[i];
		}
	}

	GPDMA_CH0_SRC = (uint32_t) dmaMemoryArrayOut0;
	
	GPDMA_CH0_DEST = (uint32_t) &SSP0DR;
	
	GPDMA_CH0_CTRL =
		(numBytes & 0x0FFF) //transfer size
		| (0 << DMACC0Control_SBSize_BIT) //source burst size, burst size of SSP1 = 4bytes, 1/2fifo length
		| (0 << DMACC0Control_DBSize_BIT) //dest. burst size, burst size of SSP1 = 4bytes, 1/2fifo length
		| (0 << DMACC0Control_SWidth_BIT) //source transfer width, transfer width of SSP0 = 1 bytes
		| (0 << DMACC0Control_DWidth_BIT) //dest. transfer width, transfer width of SSP0 =  1 bytes
		| (1 << DMACC0Control_SI_BIT) //source increment, increment thru the DMA memory range
		| (0 << DMACC0Control_DI_BIT) //dest. increment, always send to the SSP1DR register
		| (1 << DMACC0Control_I_BIT);
	
	
	GPDMA_CH0_CFG |= GPDMA_CHx_CFG_GPDMA_ENABLE_MASK;
		
	GPDMA_CONFIG |= 0x01;//Enable GPDMA
	
	SSP0DMACR = (1<<1);//Enable the SSP0 DMA transmit FIFO.

	return(true);
}




bool transmitSSP0_SPI_BufferViaDMA1(const uint8_t *data, const uint16_t numBytes) {
	//configure dma controller
	//trigger dma transfer
	//wait for dma transfer to finish
	
	//GPDMA_CONFIG &= ~(0x01);//Disable GPDMA
	
	
	GPDMA_CH0_CFG &= ~(GPDMA_CHx_CFG_GPDMA_ENABLE_MASK);//Disable DMA channel 0
	GPDMA_CH1_CFG &= ~(GPDMA_CHx_CFG_GPDMA_ENABLE_MASK);//Disable DMA channel 1

	
	GPDMA_CH1_CFG |= (0x01 << 11);	//Configure DMA Channel 1 to be memory to peripheral flow control
	GPDMA_CH1_CFG = GPDMA_CH1_CFG & ~(0x0F << 1);//Configure Dest Peripheral to be SSP0/TX
	GPDMA_CH1_CFG = GPDMA_CH1_CFG & ~(0x0F << 6);//Configure Dest Peripheral to be SSP0/TX
	
	
	if( data != dmaMemoryArrayOut1 ) {
		for(int i = 0; i < numBytes; i++ ) {
			dmaMemoryArrayOut1[i] = data[i];
		}
	}

	GPDMA_CH1_SRC = (uint32_t) dmaMemoryArrayOut1;
	
	
	GPDMA_CH1_DEST = (uint32_t) &SSP0DR;
	
	GPDMA_CH1_CTRL =
		(numBytes & 0x0FFF) //transfer size
		| (0 << DMACC0Control_SBSize_BIT) //source burst size, burst size of SSP1 = 4bytes, 1/2fifo length
		| (0 << DMACC0Control_DBSize_BIT) //dest. burst size, burst size of SSP1 = 4bytes, 1/2fifo length
		| (0 << DMACC0Control_SWidth_BIT) //source transfer width, transfer width of SSP0 = 1 bytes
		| (0 << DMACC0Control_DWidth_BIT) //dest. transfer width, transfer width of SSP0 =  1 bytes
		| (1 << DMACC0Control_SI_BIT) //source increment, increment thru the DMA memory range
		| (0 << DMACC0Control_DI_BIT) //dest. increment, always send to the SSP1DR register
		| (1 << DMACC0Control_I_BIT);
	
	
	GPDMA_CH1_CFG |= GPDMA_CHx_CFG_GPDMA_ENABLE_MASK;
		
	GPDMA_CONFIG |= 0x01;//Enable GPDMA
	
	SSP0DMACR = (1<<1);//Enable the SSP0 DMA transmit FIFO.

	return(true);
}
*/

/*
static void clearSSP0_ReceiveFifo(void) {
	while(SSP0SR & (1<<2)) {
		SSP0DR;
	}
}

static void clearSSP1_ReceiveFifo(void) {
	while(SSP1SR & (1<<2)) {
		SSP1DR;
	}
}
*/


/******************************************************************************
 * Description: Trys to read data (4 to 16 bits, depending on configuration of peripheral) from the SPI data register,
 *              trys timeout number of times, return false if no data is read, or true if data is read. 
 * 
 * Parameters:
 *      -timeout: number of times to try
 *      *dest: Destination address to store the response data into.
 *      *dr: Pointer to the SSP# data register to read from
 *      *sr: Pointer to the SSP# register to poll while waiting.
 * 
 * Return Value(s): True if read successful, false otherwise. 
 * 
 *****************************************************************************/
static bool readSSPx_SPI(const uint32_t timeout, uint16_t  *dest, volatile unsigned long *dr, volatile unsigned long *sr )
{
	int cntr = 0;
	while( (*sr & (1<<2)) == 0 ) {
		cntr++;
		if( cntr > timeout ) {
			//printf2("spi read timeout expired\r\n");
			return(false);
		}
	}
	
	*dest = *dr;
	return(true);
}


/******************************************************************************
 * Description: This function is used to transfer a series of bytes, and subsequently read back zero-or-more bytes.
 *        The first numOutBytes
 * 
 * Parameters:
 *    *outData: Pointer to the start address of data to be transfered out.
 *    numOutBytes: The number of bytes, starting at *outData, to be transmitted
 *    *inData: Location in ram to place data read in, including data read while transmitting out data.
 *    inDataSize: the size of the inData array
 *    extraInBytesToRead: The number of bytes to read after sending the outData buffer out.
 *    *dr: Pointer to the SSP# data register to read from
 *    *sr: Pointer to the SSP# register to poll while waiting.
 * 
 * Return Value(s): True if transmission and reading was successful, false otherwise.
 *                  The first numOutBytes bytes of *inData will be the data that was clocked in while writing the outData buffer.
 *                  The following extraInBytesToRead of *inData will be the data clocked in while only reading data.
 * 
 *****************************************************************************/
static bool SSPx_SPI_transfer(
		const uint8_t *outData, const uint8_t numOutBytes, 
		uint8_t *inData, const uint8_t inDataSize, 
		const uint8_t extraInBytesToRead, volatile unsigned long *dr, volatile unsigned long *sr )
{
	bool ret = true;
	uint16_t read_data;
	uint8_t currentInDataIndex = 0;
	
	for(int i = 0; i < numOutBytes; i++ ) {
		while( (*sr & (1<<1)) == 0 ) {}//wait for transmit fifo to empty
		*dr = outData[i];//Transmit the data on the SSP1 port
		
		if( ! readSSPx_SPI(100000, &read_data, dr, sr) ) {
			ret = false;
		} else if( currentInDataIndex < inDataSize && inData != NULL ) {
			inData[currentInDataIndex++] = read_data;
		}
	}
	
	for(int i = 0; i < extraInBytesToRead; i++ ) {
		while( (*sr & (1<<1)) == 0 ) {}//wait for transmit fifo to empty
		*dr = 0;
		
		
		if( ! readSSPx_SPI(100000, &read_data, dr, sr) ) {
			ret = false;
		} else if( currentInDataIndex < inDataSize && inData != NULL ) {
			inData[currentInDataIndex++] = read_data;
		}
	}
		
	return(ret);
}


/******************************************************************************
 * Function name:	ssp0_SPI_transfer
 *
 * Description: See docs for SSPx_SPI_transfer()
 *
 *****************************************************************************/
bool ssp0_SPI_transfer(
		const uint8_t *outData, const uint8_t numOutBytes, 
		uint8_t *inData, const uint8_t inDataSize, 
		const uint8_t extraInBytesToRead )
{
	setSSP0ChipSelect(false);
	bool ret = SSPx_SPI_transfer(outData, numOutBytes, inData, inDataSize, extraInBytesToRead, &SSP0DR, &SSP0SR);
	setSSP0ChipSelect(true);
	return(ret);
}


/******************************************************************************
 * Function name:	ssp1_SPI_transfer
 *
 * Description: See docs for SSPx_SPI_transfer
 *
 *****************************************************************************/
bool ssp1_SPI_transfer(
		const uint8_t *outData, const uint8_t numOutBytes, 
		uint8_t *inData, const uint8_t inDataSize, 
		const uint8_t extraInBytesToRead )
{
	setSSP1ChipSelect(false);
	bool ret = SSPx_SPI_transfer(outData, numOutBytes, inData, inDataSize, extraInBytesToRead, &SSP1DR, &SSP1SR);
	setSSP1ChipSelect(true);
	return(ret);
}


/******************************************************************************
 * Function name:	readSSP0_SPI
 *
 * Description: See docs for readSSPx_SPI()
 *
 *****************************************************************************/
bool readSSP0_SPI(const uint32_t timeout, uint16_t  *dest ) {
	return(readSSPx_SPI(timeout, dest, &SSP0DR, &SSP0SR));
}


/******************************************************************************
 * Function name:	readSSP1_SPI
 *
 * Description: See docs for readSSPx_SPI()
 *
 *****************************************************************************/
bool readSSP1_SPI(const uint32_t timeout, uint16_t  *dest ) {
	return(readSSPx_SPI(timeout, dest, &SSP1DR, &SSP1SR));
}


/******************************************************************************
* Function name:	clearFIFO_SSP0
*
* Descriptions:		Empties FIFO buffer, a maximum of 8 entries
*
******************************************************************************/
void clearFIFO_SSP0(void)
{
	volatile uint16_t trash;
	uint8_t index;
	for( index=0 ; (index<8 && ((SSP0SR & (1<<2)) == 0)) ; index++ )
	{
		trash = SSP0DR;
	}
}


/******************************************************************************
* Function name:	clearFIFO_SSP1
*
* Descriptions:		Empties FIFO buffer, a maximum of 8 entries
*
******************************************************************************/
void clearFIFO_SSP1(void)
{
	volatile uint16_t trash;
	uint8_t index;
	for( index=0 ; (index<8 && ((SSP1SR & (1<<2)) == 0)) ; index++ )
	{
		trash = SSP1DR;
	}
}


/******************************************************************************
 * Description: Triggers a transmission of data out the SSP0 spi port
 * 
 * Parameters: 
 *     byte1: data to be transfered
 * 
 * Return Value(s): True, or never returns... 
 * 
 *****************************************************************************/
bool transmitSSP0_SPI_1byte(const uint16_t byte1) {
	while( (SSP0SR & (1<<1)) == 0 ); // Wait until transmit fifo is not full TNF
	SSP0DR = byte1;//Transmit the data on the SSP1 port
	return(true);
}


/******************************************************************************
* Function name:	enqueueSSP0_SPI
*
* Descriptions:		Adds one byte to SPI transmit buffer
*
******************************************************************************/
bool enqueueSSP0_SPI(const uint16_t byte1) {
	SSP0DR = byte1; // Transmit the data on the SSP1 port
	return(true);
}


/******************************************************************************
 * Description: Triggers a transmission of data out the SSP1 spi port
 *
 * Parameters:
 *     byte1: data to be transfered
 *
 * Return Value(s): True, or never returns...
 *
 *****************************************************************************/
bool transmitSSP1_SPI_1byte(const uint16_t byte1) {
	while( (SSP1SR & (1<<1)) == 0 ); // Wait until transmit fifo is not full TNF
	SSP1DR = byte1; // Transmit the data on the SSP1 port
	return(true);
}




