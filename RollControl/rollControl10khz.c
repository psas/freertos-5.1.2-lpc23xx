


#include "rollControl10khz.h"

#define FIQ_INTERVAL_DIVISOR   10
#define FIRTAPS   17

#define ADC_CNV_HIGH		FIO0SET = (1 << 16)		// P0.16 UExt pin10, ADC pin8
#define ADC_CNV_LOW			FIO0CLR = (1 << 16)		// P0.16 UExt pin10, ADC pin8
#define ADC_DATA_READY		(FIO2PIN & (1 << 9))	// P2.9  ?Ext pin??, sensor SDO pin, input

extern volatile uint32_t g_most_recent_buffer;
extern volatile uint32_t g_task_reading_flag;

extern volatile struct data_sample g_sample_data_A;
extern volatile struct data_sample g_sample_data_B;

extern xSemaphoreHandle xSemaphore;

const uint32_t au32b[FIRTAPS] = {
0.00865822050850897 * 65535,
0.012654161713971 * 65535,
0.0239618473313426 * 65535,
0.0411021366654104 * 65535,
0.0615768996608007 * 65535,
0.0822677064911721 * 65535,
0.0999488591888209 * 65535,
0.111826167628214 * 65535,
0.116008001623518 * 65535,
0.111826167628214 * 65535,
0.0999488591888209 * 65535,
0.0822677064911721 * 65535,
0.0615768996608007 * 65535,
0.0411021366654104 * 65535,
0.0239618473313426 * 65535,
0.012654161713971 * 65535,
0.00865822050850897 * 65535};


uint32_t au32GyroRegs[FIRTAPS] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
uint32_t au32AccelRegs[FIRTAPS] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

uint16_t u16RawAccelADC = 0;
uint16_t u16RawGyroADC = 0;

void Read_SSP0(unsigned char * readPtr)
{
	// Read data from buffer
	*readPtr = (unsigned char) SSP0DR;
}

unsigned char isSSP0ReadFIFODataPresent(void)
{
	return (unsigned char) ((SSP0SR & (1<<2)) >> 2); // Check 2nd bit (read FIFO RNE)
}


/******************************************************************************
* Function name:		vRC
*
* Descriptions:		Handle ADC and decimation from interrupt.
******************************************************************************/
void vRC(void) {
	FIO4SET = (1<<31);

	static uint32_t irqCounter = 0;
	static signed portBASE_TYPE xHigherPriorityTaskWoken;
	volatile uint32_t vu32counter = 0;
	uint16_t i = 0;
	uint8_t index = 0;
//	static uint16_t u16RawAccelADC = 0;
//	static uint16_t u16RawGyroADC = 0;
	uint64_t u64GyroMacResult = 0;
	uint64_t u64AccelMacResult = 0;
	uint8_t readValue1;
	uint8_t readValue2;
	uint8_t readValue3;
	uint8_t readValue4;

	// End previous conversion
	// P0.16 pin SSP0: SSEL Wired to CNV on ADC
	ADC_CNV_LOW;

	// Pull last cycle's data from the SPI FIFO
	if( isSSP0ReadFIFODataPresent() )
	{
		Read_SSP0(&readValue1); // Read MSB
		Read_SSP0(&readValue2); // Read LSB
		Read_SSP0(&readValue3); // Read MSB
		Read_SSP0(&readValue4); // Read LSB

		u16RawGyroADC = (readValue1<<8); // Save highest 8 Gyro bits
		u16RawGyroADC |= readValue2; // Save lowest 8 Gyro bits
		u16RawAccelADC = (readValue3<<8); // Save highest 8 Accel bits
		u16RawAccelADC |= (readValue4); // Save lowest 8 Accel bits
	}

	//********************* Test **************************
//	static unsigned int debugMSGCounter = 0;
//	if (debugMSGCounter == 10000)
//	{
//		printf2("Gyro %d\r\n", u16RawGyroADC);
//	}
//	else if (debugMSGCounter >= (10000 * 2))
//	{
//		printf2("Accel %d\r\n\n", u16RawAccelADC);
//		debugMSGCounter = 0;
//	}
//	debugMSGCounter++;

	//*****************************************************

	clearFIFO_SSP0();

	// Trigger conversion. CNV must be high during SPI transfer
	// P0.16 pin SSP0: SSEL Wired to CNV on ADC
	ADC_CNV_HIGH;

	// Wait for conversion result, poll GPIO pin
	vu32counter = 200;
	while (vu32counter>0)
	{
		vu32counter--;
		if( ADC_DATA_READY > 0 ) // If data ready pin P2.9
		{// When reading is done, get out
			break;
			//vu32counter = 0;
		}
	}

	// Write 4 dummy bytes, triggering the data transfer from the sensors,
	// leaving the data in the FIFO for the next ISR firing
	for( index = 0 ; index < 4 ; index++ )
	{
		if ( isSSP0TransmitFIFONotFull() )
		{
			enqueueSSP0_SPI(0x00); // Dummy write
		}
		else
		{
			index = 4;
		}
	}

	// Insert the new sample into the register array
	au32GyroRegs[irqCounter] = u16RawGyroADC;
	au32AccelRegs[irqCounter] = u16RawAccelADC;

	// Update interrupt counter
	irqCounter++;

	// Run FIR, transfer data and wake task (release semaphore)
	xHigherPriorityTaskWoken = pdFALSE;

	if( irqCounter >= FIQ_INTERVAL_DIVISOR )
	{
		u64GyroMacResult = 0;
		u64AccelMacResult = 0;

		// Calculate the output sample at 1000hz
		// Multiply and accumulate FIR accumulator
		for ( i = 0; i < FIRTAPS; ++i ) {
			u64GyroMacResult += au32b[i] * au32GyroRegs[i];
			u64AccelMacResult += au32b[i] * au32AccelRegs[i];
		}

		// Move the old samples up for the next MAC cycle
		for ( i = FIQ_INTERVAL_DIVISOR; i < FIRTAPS; ++i ) {
			au32GyroRegs[i] = au32GyroRegs[i - FIQ_INTERVAL_DIVISOR];
			au32AccelRegs[i] = au32AccelRegs[i - FIQ_INTERVAL_DIVISOR];
		}

		irqCounter = 0;

		// Store the result to a protected ping-pong buffer
		if ( g_task_reading_flag ) {
			if( g_most_recent_buffer == B_BUFFER ) {
				g_sample_data_A.gyro_reading = u64GyroMacResult >> 16;
				g_sample_data_A.adc_reading = u64AccelMacResult >> 16;
			} else {
				g_sample_data_B.gyro_reading = u64GyroMacResult >> 16;
				g_sample_data_B.adc_reading = u64AccelMacResult >> 16;
			}

			g_most_recent_buffer = !g_most_recent_buffer;
		} else {
			if( g_most_recent_buffer == A_BUFFER ) {
				g_sample_data_A.gyro_reading = u64GyroMacResult >> 16;
				g_sample_data_A.adc_reading = u64AccelMacResult >> 16;
			} else {
				g_sample_data_B.gyro_reading = u64GyroMacResult >> 16;
				g_sample_data_B.adc_reading = u64AccelMacResult >> 16;
			}
		}

		/* Unblock the task by releasing the semaphore. */
		xSemaphoreGiveFromISR( xSemaphore, &xHigherPriorityTaskWoken );
	} // End if( irqCounter >= FIQ_INTERVAL_DIVISOR )

	//********************* Test **************************
	//Debug LED
	static uint32_t debugLEDCounter = 0;
	debugLEDCounter++;

	if( debugLEDCounter == 500 ) {
		FIO1SET = (1<<19);//turn on led on olimex 2378 dev board
	} else if( debugLEDCounter >= 1000 ) {
		FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board
		debugLEDCounter = 0;
	}
	//*****************************************************
	FIO4CLR = (1<<31);

	/* If xHigherPriorityTaskWoken was set to true you
	we should yield.  The actual macro used here is
	port specific. */
	//portYIELD_FROM_ISR( xHigherPriorityTaskWoken );
	if( xHigherPriorityTaskWoken ) {
		portYIELD_FROM_ISR();
	}

	// Ready for the next interrupt.
}




__attribute__ ((interrupt ("FIQ"))) void vRollControl10khzFIQ( void )
{
	vRC();
	T1IR = 2;
	VICVectAddr = 0;
}


void configure10khzTimer1(void)
{
	PCLKSEL0 = (PCLKSEL0 & (~(0x3 << 4))) | (0x01 << 4);
	T1TCR = 2;// Stop and reset the timer
	T1CTCR = 0; // Timer mode

	// A 10khz tick does not require the use of the timer prescale.  This is
	// defaulted to zero but can be used if necessary.
	T1PR = 0;

	// Calculate the match value required for our wanted tick rate.
	T1MR1 = (configCPU_CLOCK_HZ / 10000);

	// Generate tick with timer 0 compare match.
	T1MCR = (3 << 3); // Reset timer on match and generate interrupt

	VICIntSelect |= 1<<5;//Configure as an FIQ
	VICVectAddr5 = (portLONG ) vRollControl10khzFIQ;

	// Setup the VIC for the timer1.
	VICIntEnable |= (1<<5);

	VICVectCntl5 = 1;//Set the priority

	// Start the timer - interrupts are disabled when this function is called
	 //so it is okay to do this here.
	T1TCR = 0x01;
}


