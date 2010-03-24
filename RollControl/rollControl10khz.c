#include "rollControl10khz.h"



extern volatile uint32_t g_most_recent_buffer;
extern volatile uint32_t g_task_reading_flag;

extern volatile struct data_sample g_sample_data_A;
extern volatile struct data_sample g_sample_data_B;


extern xSemaphoreHandle xSemaphore;

#define FIQ_INTERVAL_DIVISOR   10

uint32_t adc_fir_coefficients[FIQ_INTERVAL_DIVISOR];
uint32_t gyro_fir_coefficients[FIQ_INTERVAL_DIVISOR];

extern volatile uint32_t go_flag;

void vRC(void) {
	FIO0SET = (1<<6);

	static struct data_sample the_decimated_sample = DATA_SAMPLE_INITIALIZER;
	static uint32_t irqCounter = 0;
	static signed portBASE_TYPE xHigherPriorityTaskWoken;

	//Do somthing at 10khz

	//Triger conversion

	//Pull last data from the SPI FIFO
	uint32_t adc_spi_sample = 111;
	uint32_t gyro_spi_sample = 111;

	//Multiply and accumilate FIR accumulator
	the_decimated_sample.adc_reading += (adc_spi_sample * adc_fir_coefficients[irqCounter]);
	the_decimated_sample.gyro_reading += (gyro_spi_sample * gyro_fir_coefficients[irqCounter]);

	//Wait for conversion result, poll GPIO pin

	//Write 4 dummy bytes, triggering the data transfer from the sensor, leaving it in the FIFO for the next ISR fireing


	irqCounter++;

	xHigherPriorityTaskWoken = pdFALSE;
	if( irqCounter >= FIQ_INTERVAL_DIVISOR ) {
		//Do somthing at 1000hz
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
		//go_flag = 1;
	}


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


