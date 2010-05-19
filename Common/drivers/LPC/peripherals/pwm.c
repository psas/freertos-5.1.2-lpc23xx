#ifndef PWM_C_
#define PWM_C_

#include "pwm.h"

void setupPWMPinSetup2378(const enum PWM_Channel chan)
{
	switch(chan) {
		case(PWM1_0):
			//this is not an actual output
			break;
		case(PWM1_1):
			PINSEL3 |= (1<<5);//P1.18 to be PWM1.1
			PINSEL3 &= ~(1<<4);
			break;
		case(PWM1_2):
			PINSEL3 |= (1<<9);//P1.20 to be PWM1.2
			PINSEL3 &= ~(1<<8);
			break;
		case(PWM1_3):
			PINSEL3 |= (1<<11);//P1.21 to be PWM1.3
			PINSEL3 &= ~(1<<10);
			break;
		case(PWM1_4):
			PINSEL3 |= (1<<15);//P1.23 to be PWM1.4
			PINSEL3 &= ~(1<<14);
			break;
		case(PWM1_5):
			PINSEL3 |= (1<<17);//P1.24 to be PWM1.5
			PINSEL3 &= ~(1<<16);
			break;
		case(PWM1_6):
			PINSEL3 |= (1<<21);//P1.26 to be PWM1.6
			PINSEL3 &= ~(1<<20);
			break;
	}
}

void setupPWMChannelPeripheral(const enum PWM_Channel chan, const uint32_t dutyCycle)
{
	setPWMDutyCycle(chan, dutyCycle);
	
	switch(chan) {
		case(PWM1_0):
			//this is not an actual output
			break;
		case(PWM1_1):
			PWM1PCR |= (1<<9); //Enable PWM Output
			break;	
		case(PWM1_2):
			PWM1PCR |= (1<<10); //Enable PWM Output
			break;
		case(PWM1_3): 
			PWM1PCR |= (1<<11); //Enable PWM Output
			break;
		case(PWM1_4):
			PWM1PCR |= (1<<12); //Enable PWM Output
			break;
		case(PWM1_5):
			PWM1PCR |= (1<<13); //Enable PWM Output
			break;
		case(PWM1_6):
			PWM1PCR |= (1<<14); //Enable PWM Output
			break;
	}
}

/**
 * This is specitfic to the 2378, and assumes which PX.Y pins are to be output on
 */
void setupPWMChannel(const enum PWM_Channel chan, const uint32_t dutyCycle)
{
	setupPWMChannelPeripheral(chan, dutyCycle);
	setupPWMPinSetup2378(chan);
}


/*
 * The PWMMR{#} registers indicate the duty cycle (in ticks) that the PWM signal will be high.
 * After assigning the appropiate PWMMR{#} register, you must set the PWMLER bit to latch the new
 * value into the PWM counter register upon the next period elapsing.
 */
void setPWMDutyCycle(const enum PWM_Channel chan, const uint32_t dutyCycleTicks) {
	switch(chan) {
		case(PWM1_0):
			PWM1MR0 = dutyCycleTicks;
			PWM1LER |= (1<<0);//indicate to the hardware to re-latch the register values
			break;	
		case(PWM1_1):
			PWM1MR1 = dutyCycleTicks;
			PWM1LER |= (1<<1);//indicate to the hardware to re-latch the register values
			break;
		case(PWM1_2):
			PWM1MR2 = dutyCycleTicks;
			PWM1LER |= (1<<2);//indicate to the hardware to re-latch the register values
			break;
		case(PWM1_3):
			PWM1MR3 = dutyCycleTicks;
			PWM1LER |= (1<<3);//indicate to the hardware to re-latch the register values
			break;
		case(PWM1_4):
			PWM1MR4 = dutyCycleTicks;
			PWM1LER |= (1<<4);//indicate to the hardware to re-latch the register values
			break;
		case(PWM1_5):
			PWM1MR5 = dutyCycleTicks;
			PWM1LER |= (1<<5);//indicate to the hardware to re-latch the register values
			break;
		case(PWM1_6):
			PWM1MR6 = dutyCycleTicks;
			PWM1LER |= (1<<6);//indicate to the hardware to re-latch the register values
			break;
	}	
}



/*
 * chan - The channel that you want to setup
 * interupt - if true, an interupt will be generated on PWM state transition, see manual for details
 * reset - if true, the PWM cycle will start over again after period has elapsed, see manual for details
 * stop - stops the PWM at the end of the cycle
 * 
 */
void setPWMMatchReg(const enum PWM_Channel chan, const bool interupt, const bool reset, const bool stop) {
	//see page 261 of the user manual to see where these are derived from
	long boolval = (1<<0);
	boolval = (boolval << (chan	 * 3));
	
	if( interupt ) {
		PWM1MCR |= boolval;	
	} else {
		PWM1MCR &= ~(boolval);
	}
	
	boolval = (boolval << 1);
	if( reset ) {
		PWM1MCR |= boolval;	
	} else {
		PWM1MCR &= ~(boolval);
	}
	
	boolval = (boolval << 1);
	if( stop ) {
		PWM1MCR |= boolval;	
	} else {
		PWM1MCR &= ~(boolval);
	}	
}




/*
 * This function is used to setup the PWM pre-scalar and period of the PWN signal.
 * The period is in the PWMMR0 register, and the the prescalar in PWMPR register.
 */
void PWMinit(const uint32_t prescalar, const uint32_t periodTicks)
{
	PCLKSEL0 = (PCLKSEL0 & ~(3<<12)) | (1<<12);//set pwm to run at CCLK speed
	PWM1PR = prescalar; /* Load prescaler  */

	PCONP |= (1<<6);//Make sure PWM is powered on.... 

	//disable all pwm outputs and set single edge mode, this driver only works with single edge
	//manual says we shouldn't mess with the other bits in the register
	int i;
	for (i = 2; i <= 6; i++) {
		PWM1PCR &= ~(1<<i);//Select single edge control
	}
	for (i = 9; i <= 14; i++) {
		PWM1PCR &= ~(1<<i);//Disable pwm output
	}

	//PWMMCR = PWMMR0R_BIT;
	PWM1MCR = 0x0; //clear everything

	setPWMMatchReg(PWM1_0, false, true, false); //this is what sets up the period to automaticly restart upon timer expiration
	setPWMDutyCycle(PWM1_0, periodTicks); //this actually sets the period value

	PWM1TCR = 0x00000002;/* Reset counter and prescaler           */
	PWM1TCR = 0x00000009;/* enable counter and PWM, release counter from reset */
}

#endif /*PWM_C_*/
