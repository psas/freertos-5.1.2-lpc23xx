#include "rollControl10khz.h"



extern volatile uint32_t g_most_recent_buffer;
extern volatile uint32_t g_task_reading_flag;

extern volatile struct data_sample g_sample_data_A;
extern volatile struct data_sample g_sample_data_B;


extern xSemaphoreHandle xSemaphore;

#define FIQ_INTERVAL_DIVISOR   10

uint32_t accel_fir_coefficients[FIQ_INTERVAL_DIVISOR];
uint32_t gyro_fir_coefficients[FIQ_INTERVAL_DIVISOR];


#define ADC_CNV_HIGH		FIO0SET = (1 << 16)		// P0.16 UExt pin10, ADC pin8
#define ADC_CNV_LOW			FIO0CLR = (1 << 16)		// P0.16 UExt pin10, ADC pin8
#define ADC_DATA_READY		(FIO2PIN & (1 << 9))	// P2.9  ?Ext pin??, sensor SDO pin, input

void Read_SSP0(unsigned char * readPtr)
{
	// Read data from buffer
	*readPtr = (unsigned char) SSP0DR;
}

unsigned char isSSP0ReadFIFOEmpty(void)
{
	return (unsigned char) ((SSP0SR & (1<<2)) >> 2); // Check 2nd bit (read FIFO RNE)
}

uint16_t u16RawAccelADC = 0;
uint16_t u16RawGyroADC = 0;

void vRC(void) {
	FIO0SET = (1<<6);

	static struct data_sample the_decimated_sample = DATA_SAMPLE_INITIALIZER;
	static uint32_t irqCounter = 0;
	static signed portBASE_TYPE xHigherPriorityTaskWoken;
	volatile uint32_t vu32counter = 0;
//	static uint16_t u16RawAccelADC = 0;
//	static uint16_t u16RawGyroADC = 0;
	uint8_t readValue1;
	uint8_t readValue2;
	uint8_t readValue3;
	uint8_t readValue4;

	// Run at 10khz

	// End previous conversion
	// P0.16 pin SSP0: SSEL Wired to CNV on ADC
	ADC_CNV_LOW;

	// Pull last cycle's data from the SPI FIFO
	if( isSSP0ReadFIFOEmpty() )
	{
		Read_SSP0(&readValue1); // Read MSB
		Read_SSP0(&readValue2); // Read LSB
		Read_SSP0(&readValue3); // Read MSB
		Read_SSP0(&readValue4); // Read LSB

		u16RawGyroADC = (readValue1<<8); // Save highest 8 bits
		u16RawGyroADC |= readValue2; // Save lowest 8 bits
		u16RawAccelADC = (readValue3<<8); // Save highest 8 bits
		u16RawAccelADC |= (readValue4); // Save lowest 8 bits
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

	clearFIFO_SSP0(); // TODO This function has no escape!!! (dangerous 'while' if PCLK is not running)

	// Trigger conversion. CNV must be high during SPI transfer
	// P0.16 pin SSP0: SSEL Wired to CNV on ADC
	ADC_CNV_HIGH;

	// Multiply and accumulate FIR accumulator
	the_decimated_sample.adc_reading += (u16RawAccelADC * accel_fir_coefficients[irqCounter]);
	the_decimated_sample.gyro_reading += (u16RawGyroADC * gyro_fir_coefficients[irqCounter]);

	// Wait for conversion result, poll GPIO pin
	vu32counter = 200;
	while (vu32counter>0)
	{
		vu32counter--;
		if( ADC_DATA_READY ) // If data ready pin P2.9
		{// When reading is done, get out
			vu32counter = 0;
		}
	}

	// Write 4 dummy bytes, triggering the data transfer from the sensor,
	// leaving it in the FIFO for the next ISR firing
	if ( isSSP0TransmitFIFOEmpty() )
	{
		transmitSSP0_SPI_1byte(0x00); // Dummy write
		transmitSSP0_SPI_1byte(0x00); // Dummy write
		transmitSSP0_SPI_1byte(0x00); // Dummy write
		transmitSSP0_SPI_1byte(0x00); // Dummy write
	}
	else
	{
		// TODO Somehow reset / recover. Clear buffer?
	}

	// Update interrupt counter
	irqCounter++;

	// Transfer data and wake task (release semaphore)
	xHigherPriorityTaskWoken = pdFALSE;
	if( irqCounter >= FIQ_INTERVAL_DIVISOR )
	{
		//Do something at 1000hz
		irqCounter = 0;

		if ( g_task_reading_flag ) {
			if( g_most_recent_buffer == B_BUFFER ) {
				g_sample_data_A = the_decimated_sample;
			} else {
				g_sample_data_B = the_decimated_sample;
			}

			g_most_recent_buffer = !g_most_recent_buffer;
		} else {
			if( g_most_recent_buffer == A_BUFFER ) {
				g_sample_data_A = the_decimated_sample;
			} else {
				g_sample_data_B = the_decimated_sample;
			}
		}

		//Reset the accumulators
		the_decimated_sample = DATA_SAMPLE_INITIALIZER;

		/* Unblock the task by releasing the semaphore. */
		xSemaphoreGiveFromISR( xSemaphore, &xHigherPriorityTaskWoken );
	} // End if( irqCounter >= FIQ_INTERVAL_DIVISOR )


	//------------------------------------------
	//Debug LED
	static uint32_t debugLEDCounter = 0;
	debugLEDCounter++;

	if( debugLEDCounter == 500 ) {
		FIO1SET = (1<<19);//turn on led on olimex 2378 dev board
	} else if( debugLEDCounter >= 1000 ) {
		FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board
		debugLEDCounter = 0;
	}
	//------------------------------------------




	/* If xHigherPriorityTaskWoken was set to true you
	we should yield.  The actual macro used here is
	port specific. */
	//portYIELD_FROM_ISR( xHigherPriorityTaskWoken );
	if( xHigherPriorityTaskWoken ) {
		portYIELD_FROM_ISR();
	}

	FIO0CLR = (1<<6);
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


