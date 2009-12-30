#include "rollControl10khz.h"

__attribute__ ((interrupt ("FIQ"))) void vRollControl10khzFIQ( void )
{
	FIO0SET = (1<<6);

	//Do somthing at 10khz
	static uint32_t irqCounter = 0;
	irqCounter++;
	if( irqCounter >= 1000 ) {
		//Do somthing at 100hz
		irqCounter = 0;
	}

	//------------------------------------------
	//Debug LED
	static uint32_t debugLEDCounter = 0;
	debugLEDCounter++;

	if( debugLEDCounter == 5000 ) {
		FIO1SET = (1<<19);//turn on led on olimex 2378 dev board
	} else if( debugLEDCounter >= 10000 ) {
		FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board
		debugLEDCounter = 0;
	}
	//------------------------------------------


	FIO0CLR = (1<<6);
	// Ready for the next interrupt.
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
