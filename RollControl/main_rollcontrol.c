/*
 FreeRTOS.org V5.1.2 - Copyright (C) 2003-2009 Richard Barry.

 This file is part of the FreeRTOS.org distribution.

 FreeRTOS.org is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 FreeRTOS.org is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with FreeRTOS.org; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 A special exception to the GPL can be applied should you wish to distribute
 a combined work that includes FreeRTOS.org, without being obliged to provide
 the source code for any proprietary components.  See the licensing section
 of http://www.FreeRTOS.org for full details of how and when the exception
 can be applied.

 ***************************************************************************
 ***************************************************************************
 *                                                                         *
 * Get the FreeRTOS eBook!  See http://www.FreeRTOS.org/Documentation      *
 *                                                                         *
 * This is a concise, step by step, 'hands on' guide that describes both   *
 * general multitasking concepts and FreeRTOS specifics. It presents and   *
 * explains numerous examples that are written using the FreeRTOS API.     *
 * Full source code for all the examples is provided in an accompanying    *
 * .zip file.                                                              *
 *                                                                         *
 ***************************************************************************
 ***************************************************************************

 Please ensure to read the configuration and relevant port sections of the
 online documentation.

 http://www.FreeRTOS.org - Documentation, latest information, license and
 contact details.

 http://www.SafeRTOS.com - A version that is certified for use in safety
 critical systems.

 http://www.OpenRTOS.com - Commercial support, development, porting,
 licensing and training services.
 */

/* Scheduler includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"
#include "portmacro.h"

/* Demo app includes. */
#include "BlockQ.h"
#include "death.h"
#include "blocktim.h"
#include "flash.h"
//#include "partest.h"
#include "GenQTest.h"
#include "QPeek.h"
#include "dynamic.h"
#include <stdint.h>
#include <stdbool.h>
#include "debug.h"
#include "serial/serial.h"
#include "peripherals/ssp.h"
#include "printf/uart0PutChar2.h"
#include "printf/printf2.h"
#include "peripherals/pwm.h"
#include "rollcontrol.h"

#include "PathPlanning0.h"
#include "RollEstimator.h"
#include "VelocityEstimator.h"
#include "SensorCalibration0.h"
#include "ServoDrive0.h"
#include "ControlModel.h"

#define ROLL_CONTROL_STACK_SIZE 1024

// Constants to setup I/O. 
#define mainTX_ENABLE	( ( unsigned portLONG ) (1<<4) )
#define mainRX_ENABLE	( ( unsigned portLONG ) (1<<6) )
/*
 #define mainTX_ENABLE	( ( unsigned portLONG ) 0x0001 )
 #define mainRX_ENABLE	( ( unsigned portLONG ) 0x0004 )
 #define mainTX1_ENABLE	( ( unsigned portLONG ) 0x10000 )
 #define mainRX1_ENABLE	( ( unsigned portLONG ) 0x40000 )
 */

/* Demo application definitions. */
#define mainQUEUE_SIZE						( 3 )
#define mainCHECK_DELAY						( ( portTickType ) 5000 / portTICK_RATE_MS )
#define mainBASIC_WEB_STACK_SIZE            ( configMINIMAL_STACK_SIZE * 6 )

/* Task priorities. */
#define mainQUEUE_POLL_PRIORITY				( tskIDLE_PRIORITY + 2 )
#define mainCHECK_TASK_PRIORITY				( tskIDLE_PRIORITY + 3 )
#define mainBLOCK_Q_PRIORITY				( tskIDLE_PRIORITY + 2 )
#define mainFLASH_PRIORITY                  ( tskIDLE_PRIORITY + 2 )
#define mainCREATOR_TASK_PRIORITY           ( tskIDLE_PRIORITY + 3 )
#define mainGEN_QUEUE_TASK_PRIORITY			( tskIDLE_PRIORITY ) 

/* Constants to setup the PLL. */
//#define mainPLL_MUL			( ( unsigned portLONG ) ( 8 - 1 ) )
//#define mainPLL_DIV			( ( unsigned portLONG ) 0x0000 )
//#define mainCPU_CLK_DIV		( ( unsigned portLONG ) 0x0003 )

//Get 48mhz for 
#define mainPLL_MUL			( ( unsigned portLONG ) ( 11 ) )
#define mainPLL_DIV			( ( unsigned portLONG ) 0x0000 )
#define mainCPU_CLK_DIV		( ( unsigned portLONG ) 0x0005 )

//#define PCLK ((12 * (mainPLL_MUL+1) * 2) / (mainPLL_DIV + 1)) / mainCPU_CLK_DIV

#define mainPLL_ENABLE		( ( unsigned portLONG ) 0x0001 )
#define mainPLL_CONNECT		( ( ( unsigned portLONG ) 0x0002 ) | mainPLL_ENABLE )
#define mainPLL_FEED_BYTE1	( ( unsigned portLONG ) 0xaa )
#define mainPLL_FEED_BYTE2	( ( unsigned portLONG ) 0x55 )
#define mainPLL_LOCK		( ( unsigned portLONG ) 0x4000000 )
#define mainPLL_CONNECTED	( ( unsigned portLONG ) 0x2000000 )
#define mainOSC_ENABLE		( ( unsigned portLONG ) 0x20 )
#define mainOSC_STAT		( ( unsigned portLONG ) 0x40 )
#define mainOSC_SELECT		( ( unsigned portLONG ) 0x01 )

/* Constants to setup the MAM. */
#define mainMAM_TIM_3		( ( unsigned portCHAR ) 0x03 )
#define mainMAM_MODE_FULL	( ( unsigned portCHAR ) 0x02 )

#define PCLK    configCPU_CLOCK_HZ

uint32_t microsecondsToCPUTicks(const uint32_t microseconds)
{
	uint32_t ret = (configCPU_CLOCK_HZ / 1000000) * microseconds;
	return (ret);
}

uint32_t millisecondsToCPUTicks(const uint32_t miliseconds)
{
	uint32_t ret = (configCPU_CLOCK_HZ / 1000) * miliseconds;
	return (ret);
}

#define ROLL_SENSOR_BAUD_RATE_PRESCALER 2 // BRP set for sensors. Must be an EVEN number

volatile uint32_t g_most_recent_buffer = 0;
volatile uint32_t g_task_reading_flag = 0;

volatile struct data_sample g_sample_data_A = DATA_SAMPLE_INITIALIZER;
volatile struct data_sample g_sample_data_B = DATA_SAMPLE_INITIALIZER;

#define LONG_TIME 0xFFFF
#define TICKS_TO_WAIT    10

xSemaphoreHandle xSemaphore = NULL;

#define BIN14_SCALER_VALUE   16384


void setServoDutyCycle(const uint16_t u16ServoTimeMillisecondsBin14)
{
	//The passed in value is 2^14 times larger then need be
	//Note: the millisecondsToCPUTicks function has an output max value of about 3 billion when were running at 48mhz, which is within range of a uint32_t...
	const uint32_t duty_cycle_in_ticks = millisecondsToCPUTicks(
			u16ServoTimeMillisecondsBin14) / BIN14_SCALER_VALUE;

	setPWMDutyCycle(PWM1_1, duty_cycle_in_ticks);
}

//static void testSSP0(void)
//{
//	uint16_t data = 0x5A;
//
//	transmitSSP0_SPI_1byte(data);
//}

extern uint16_t u16RawAccelADC;
extern uint16_t u16RawGyroADC;

static void rollControlTask(void *pvParameters)
{
	const int debugLedCounterThreshold = 1000;

	int x = 0;
	signed portCHAR theChar;
	signed portBASE_TYPE status;
	uint32_t pwmDutyCycle = 1000;
	const uint16_t taskTimeMs = 1; // Task runs every millisecond
	int32_t targetPositionBin7 = 0;
	int32_t overridePositionBin11 = 0;

	// Initialize all control models
	PathPlanning0_initialize();
	SensorCalibration0_initialize();
	RollEstimator_initialize();
	VelocityEstimator_initialize();
	ServoDrive0_initialize();
	ControlModel_initialize();

	for (;;) {
		/* We want this task to run every 10 ticks of a timer.  The semaphore
		 was created before this task was started.

		 Block waiting for the semaphore to become available. */

		if (xSemaphoreTake( xSemaphore, LONG_TIME ) == pdTRUE) {
			FIO1SET = (1 << 29);//turn on debug GPIO line

/*
			FIO0SET = (1<<13);//turn on led on olimex 2378 dev board
			FIO0CLR = (1<<13);//turn on led on olimex 2378 dev board
*/

			static uint32_t debugLEDCounter = 0;


			//if (debugLEDCounter % 100 == 0) {
				//testSSP0();
			//}

			//------------------------------------------

			//Debug LED
			debugLEDCounter++;

			if (debugLEDCounter == debugLedCounterThreshold) {
				FIO0SET = (1 << 13); // Turn on led on olimex 2378 dev board
			} else if (debugLEDCounter >= (debugLedCounterThreshold * 2)) {
				FIO0CLR = (1 << 13); // Turn off led on olimex 2378 Sdev board
				debugLEDCounter = 0;
			}

			//------------------------------------------
			struct data_sample most_recent_sample;

			g_task_reading_flag = 1;
			if (g_most_recent_buffer == A_BUFFER) {
				most_recent_sample = g_sample_data_A;
			} else {
				most_recent_sample = g_sample_data_B;
			}
			g_task_reading_flag = 0;

			// TODO Move and change logic??
			// Read Button1, pin P0.30
			uint8_t u8IsLaunchDetected = 0;
			if((FIO0PIN & (1 << 30)) > 0){
				u8IsLaunchDetected = 0; // P0.30 HIGH, so not pressed / 'Is Launched'
			} else{
				u8IsLaunchDetected = 1; // P0.30 LOW, so pressed / 'NOT Is Launched'
			}

			//************** Sensor Calibration ***************
			//************* Set Inputs for Model **************
			SensorCalibration0_U.u16RawAccelerometerADC = u16RawAccelADC;
			SensorCalibration0_U.u16RawRateGyroADC = u16RawGyroADC;
			SensorCalibration0_U.u8IsLaunchDetected = u8IsLaunchDetected;

			//***************** Execute Model *****************
			SensorCalibration0_step();

			//************ Get Outputs from Model *************
//			SensorCalibration0_Y.s16AccelerometerMPSSBin7;
//			SensorCalibration0_Y.s16GyroRPSBin11;


			//************* Roll State Estimator **************
			//************* Set Inputs for Model **************
			RollEstimator_U.s16RollRateRadPerSecondBin11 = SensorCalibration0_Y.s16GyroRPSBin11;
			RollEstimator_U.u8IsLaunchDetected = u8IsLaunchDetected;

			//***************** Execute Model *****************
			RollEstimator_step();

			//************ Get Outputs from Model *************
//			RollEstimator_Y.s16RollPositionRadsBin13;
//			RollEstimator_Y.s16RollRateRadsPerSecBin11;
//			RollEstimator_Y.s16RollAcclRadsPerSecond2Bin5;


			//*********** Velocity State Estimator ************
			//************* Set Inputs for Model **************
			VelocityEstimator_U.s16AccelerometerMPSSBin7 = SensorCalibration0_Y.s16AccelerometerMPSSBin7;
			VelocityEstimator_U.u8IsLaunchDetected = u8IsLaunchDetected;

			//***************** Execute Model *****************
			VelocityEstimator_step();

			//************ Get Outputs from Model *************
//			VelocityEstimator_Y.s16PositionMetersBin2;
//			VelocityEstimator_Y.s16VelocityMPSBin6;
//			VelocityEstimator_Y.s16AccelerationMPSSBin7;


			//***************** Path Planning *****************
			//************* Set Inputs for Model **************
			PathPlanning0_U.u8IsLaunchDetected = u8IsLaunchDetected;
			PathPlanning0_U.u16LoopTimeMs = taskTimeMs;

			//***************** Execute Model *****************
			PathPlanning0_step();

			//************ Get Outputs from Model *************
			targetPositionBin7 = PathPlanning0_Y.s16TargetPositionBin7;
//			PathPlanning0_Y.s32MissionTimeMSec;
//			PathPlanning0_Y.u8ServoOverrideFlag;
			overridePositionBin11 = PathPlanning0_Y.s16FinOverridePositionBin11;


			//******************** Control ********************
			//************* Set Inputs for Model **************
//			ControlModel_U.s16TargetPositionBin7
//			ControlModel_U.s16PositionMetersBin2
//			ControlModel_U.s16VelocityMPSBin6
//			ControlModel_U.s16AccelerationMPSSBin7
//			ControlModel_U.s16RollPositionRadsBin13 = RollEstimator_Y.s16RollPositionRadsBin13;
			ControlModel_U.s16RollRateRadsPerSecBin11 = RollEstimator_Y.s16RollRateRadsPerSecBin11;
			ControlModel_U.s16RollAcclRadsPerSecond2Bin5 = RollEstimator_Y.s16RollAcclRadsPerSecond2Bin5;
			ControlModel_U.u8IsLaunchDetected = u8IsLaunchDetected;
			ControlModel_U.s16TargetTestRateRPSBin11 = 0;//178;


			//***************** Execute Model *****************
			ControlModel_step();

			//************ Get Outputs from Model *************
			//ControlModel_Y.s16TotalFinTorqueCmdNMBin10;


			//****************** Servo Drive ******************
			//************* Set Inputs for Model **************
//			ServoDrive0_U.s16TotalFinTorqueCmdNMBin10 = 0; // TODO Tie to control output!!!
			ServoDrive0_U.s16TotalFinTorqueCmdNMBin10 = ControlModel_Y.s16TotalFinTorqueCmdNMBin10;
			ServoDrive0_U.s16FinAngleCmdBin11 = PathPlanning0_Y.s16FinOverridePositionBin11;
			ServoDrive0_U.u8FinAngleOverride = PathPlanning0_Y.u8ServoOverrideFlag;
			ServoDrive0_U.u16MachBin15 = 0; // TODO Tie to Velocity Estimator!!!

			//***************** Execute Model *****************
			ServoDrive0_step();

			//************ Get Outputs from Model *************
			setServoDutyCycle( ServoDrive0_Y.u16ServoPulseWidthBin14 );



			static unsigned int debugMSGCounter = 0;
			if (debugMSGCounter == 500)
			{
//				printf2("\f\rGyro %d\r\n", u16RawGyroADC);
//				printf2("Accel %d\r\n", u16RawAccelADC);

//				printf2("\f\rGyro Bin11 %d\r\n", SensorCalibration0_Y.s16GyroRPSSBin11);
//				printf2("Accel Bin7 %d\r\n", SensorCalibration0_Y.s16AccelerometerMPSSBin7);

				printf2("\f\rGyro Posn Bin13 %d\r\n", RollEstimator_Y.s16RollPositionRadsBin13); //u16RawGyroADC
				printf2("Gyro Rate Bin11 %d\r\n", RollEstimator_Y.s16RollRateRadsPerSecBin11);
				printf2("Cntrl Torque Bin10 %d\r\n", ControlModel_Y.s16TotalFinTorqueCmdNMBin10);

//				printf2("\f\rVert Posn Bin2 %d\r\n", VelocityEstimator_Y.s16PositionMetersBin2);
//				printf2("Vert Rate Bin6 %d\r\n", VelocityEstimator_Y.s16VelocityMPSBin6);
//				printf2("Vert Accel Bin7 %d\r\n", VelocityEstimator_Y.s16AccelerationMPSSBin7);
				if(u8IsLaunchDetected){
					printf2("Launched");
				} else{
					printf2("Calibrating");
				}
				debugMSGCounter = 0;
			}
			debugMSGCounter++;



			// ***************** Display test code *******************
			/*static int16_t lastTargetPosition = INT16_MAX;
			if (targetPositionBin7 != lastTargetPosition) {
				printf2("Setting target position to %d\r\n",
						targetPositionBin7);
				printf2("Position update time %d\r\n\n", PathPlanning0_Y.s32MissionTimeMSec);
				lastTargetPosition = targetPositionBin7;
			}

			static int16_t lastOverridePosition = INT16_MAX;
			if (overridePositionBin11 != lastOverridePosition) {
				printf2("Setting override position to %d\r\n",
						overridePositionBin11);
				printf2("Position update time %d\r\n\n", PathPlanning0_Y.s32MissionTimeMSec);
				lastOverridePosition = overridePositionBin11;
			}

			static uint16_t u16TempCounter;
			if (u16TempCounter == 0)
			{
				printf2("Current mission time %d\r\n\n", PathPlanning0_Y.s32MissionTimeMSec);
				u16TempCounter = 10000;
			}
			else
			{
				u16TempCounter--;
			}//*/

			/* We have finished our task.  Return to the top of the loop where
			 we will block on the semaphore until it is time to execute
			 again.  Note when using the semaphore for synchronisation with an
			 ISR in this manner there is no need to 'give' the semaphore back. */


			FIO1CLR = (1 << 29);//turn off debug GPIO line

		}

		/*
		 //vSerialPutString(0, "Testing...\r\n", 50);
		 x++;

		 if (x == interval) {
		 //FIO1SET = (1<<19);//turn on led on olimex 2378 dev board

		 pwmDutyCycle += 100;
		 if(pwmDutyCycle > 2000 ) {
		 pwmDutyCycle = 1000;
		 }
		 setPWMDutyCycle(PWM1_1, microsecondsToCPUTicks(pwmDutyCycle));

		 } else if (x >= (interval*2)) {
		 //FIO1CLR = (1<<19);//turn off led on olimex 2378 Sdev board

		 x = 0;
		 printf2("Blinky Light Task...\r\n");

		 status = xSerialGetChar(0, &theChar, 1);
		 if( status == pdTRUE ) {
		 printf2("You typed the character: '%c'\r\n", theChar);
		 }
		 }

		 */
	}
}

/*-----------------------------------------------------------*/

/******************************************************************************
* Function name:	void prvSetupHardware(void)
*
* Description:		Initialize the PLL and flash module for the
* 					application.
******************************************************************************/
static void prvSetupHardware(void)
{
#ifdef RUN_FROM_RAM
	/* Remap the interrupt vectors to RAM if we are are running from RAM. */
	SCB_MEMMAP = 2;
#endif

	/* Disable the PLL. */
	PLLCON = 0;
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;

	/* Configure clock source. */
	SCS |= mainOSC_ENABLE;
	while (!(SCS & mainOSC_STAT))
		;
	CLKSRCSEL = mainOSC_SELECT;

	/* Setup the PLL to multiply the XTAL input by 4. */
	PLLCFG = (mainPLL_MUL | mainPLL_DIV);
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;

	/* Turn on and wait for the PLL to lock... */
	PLLCON = mainPLL_ENABLE;
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;
	CCLKCFG = mainCPU_CLK_DIV;
	while (!(PLLSTAT & mainPLL_LOCK))
		;

	/* Connecting the clock. */
	PLLCON = mainPLL_CONNECT;
	PLLFEED = mainPLL_FEED_BYTE1;
	PLLFEED = mainPLL_FEED_BYTE2;
	while (!(PLLSTAT & mainPLL_CONNECTED))
		;

	/* 
	 This code is commented out as the MAM does not work on the original revision
	 LPC2368 chips.  If using Rev B chips then you can increase the speed though
	 the use of the MAM.

	 Setup and turn on the MAM.  Three cycle access is used due to the fast
	 PLL used.  It is possible faster overall performance could be obtained by
	 tuning the MAM and PLL settings.
	 MAMCR = 0;
	 MAMTIM = mainMAM_TIM_3;
	 MAMCR = mainMAM_MODE_FULL;
	 */
} // End static void prvSetupHardware(void)

void enableSerial0(void)
{
	PCLKSEL0 = (PCLKSEL0 & ~(3 << 6)) | (1 << 6);//set uart to run at CCLK speed, UART0
	PINSEL0 |= mainTX_ENABLE;
	PINSEL0 |= mainRX_ENABLE;
}

/******************************************************************************
* Function name:	void setPinsForApplication(void)
*
* Description:		Initialize the target processor for the specific
* 					application by setting up IO pins
******************************************************************************/
void setPinsForApplication(void)
{
	SCS |= 1; //Configure FIO

//	FIO0DIR |= (1 << 6);
//	FIO0DIR |= (1 << 13);//Set USBLINK led to output gpio on 2378 dev board
//	FIO1DIR |= (1 << 19);
//	FIO1DIR |= (1 << 29);//Debug IO line for o-scope verification, EXT2-11 on the olimex 2378 dev board

	FIO1SET = (1 << 19);		// Turn off STAT LED
    FIO1DIR |= (1 << 19);		// Set STAT LED pin as an output

    FIO1SET = (1 << 29);
    FIO1DIR |= (1 << 29);		// Debug IO line for o-scope verification, EXT2-11 on the olimex 2378 dev board

    FIO0SET = (1 << 13);		// Turn off USB_LINK LED
    FIO0DIR |= (1 << 13);		// Set USB_LINK LED pin as an output

    FIO0CLR = (1 << 0);			// Turn off P0.0
    FIO0DIR |= (1 << 0);		// Set P0.0 pin as an output

    FIO0CLR = (1 << 1);			// Turn off P0.1
    FIO0DIR |= (1 << 1);		// Set P0.1 pin as an output

    FIO0DIR &= ~(1 << 29);		// Set P0.29 pin as an input on pin But1 for launch detect

    FIO0DIR &= ~(1 << 6);		// Leave P0.6 as an input

    FIO0CLR = (1 << 16);		// Turn off P0.16 pin SSP0: SSEL Wired to CNV on ADC
    FIO0DIR |= (1 << 16);		// Set P0.16 pin as an output

    FIO0CLR = (1 << 7);			// Turn off P0.7
    FIO0DIR |= (1 << 7);		// Set P0.7 pin as an output

    FIO0CLR = (1 << 8);			// Turn off P0.8
    FIO0DIR |= (1 << 8);		// Set P0.8 pin as an output

    FIO2CLR = (1 << 0);			// Turn off P2.0
    FIO2DIR |= (1 << 0);		// Set P2.0 pin as an output for PWM1.1

    FIO0DIR &= ~(1 << 9);		// Leave P0.9 as an input: SDO from ADC, also tied to IRQ
    FIO2DIR &= ~(1 << 9);		// Leave P2.9 pin as an input to poll ADC data ready (IRQ)

	PINSEL0 = (0x00000000 | (2 << 8) | (2 << 10) | (2 << 30)); // CAN-TD2/CAN-RD2/SSP0-SCK0 = '10b (function 2)

	//PINSEL1 = (0x00000000 | (2 << 0) | (2 << 2) | (2 << 4)); // SSEL0/MISO0/MOSI0 = '10b (function 2)
	//PINSEL1 = (0x00000000 | (2 << 2) | (2 << 4)); // MISO0/MOSI0 = '10b (function 2)
	PINSEL1 = (0x00000000 | (2 << 2)); // MISO0 = '10b (function 2) MOSI0 is not used on roll control

	PINSEL4 = (0x00000000 | (1 << 0)); // PWM1.1 bits 1:0

    return;
} // End void setPinsForApplication(void)

/******************************************************************************
* Function name:		GPIOResetPins
*
* Descriptions:		Initialize all pins to a safe state. Called immediately
* 					at startup.
******************************************************************************/
void GPIOResetPins( void )
{
	// Set up GPIO ports 0 and 1 for desired access speed

	// Set system control reg to reset value (0x00)
	SCS |= 0x00000001;		// GPIOM set for high speed access

	// Reset all GPIO pins to default: primary function
	PINSEL0 = 0x00000000;
    PINSEL1 = 0x00000000;
    PINSEL2 = 0x00000000;
    PINSEL3 = 0x00000000;
    PINSEL4 = 0x00000000;
    PINSEL5 = 0x00000000;
    PINSEL6 = 0x00000000;
    PINSEL7 = 0x00000000;
    PINSEL8 = 0x00000000;
    PINSEL9 = 0x00000000;
    PINSEL10 = 0x00000000;

    // PINMODEx sets pull-up/down for each pin

    IODIR0 = 0x00000000;
    IODIR1 = 0x00000000;
	IOCLR0 = 0xFFFFFFFF;
    IOCLR1 = 0xFFFFFFFF;

    FIO0MASK = 0x00000000; // Allow changes to all ports
    FIO1MASK = 0x00000000;
    FIO2MASK = 0x00000000;
    FIO3MASK = 0x00000000;
    FIO4MASK = 0x00000000;

    FIO0DIR = 0x00000000; // Set all ports to inputs
    FIO1DIR = 0x00000000;
    FIO2DIR = 0x00000000;
    FIO3DIR = 0x00000000;
    FIO4DIR = 0x00000000;

    FIO0CLR = 0xFFFFFFFF; // Clear all port output registers
    FIO1CLR = 0xFFFFFFFF;
    FIO2CLR = 0xFFFFFFFF;
    FIO3CLR = 0xFFFFFFFF;
    FIO4CLR = 0xFFFFFFFF;

    return;
} // End void GPIOResetPins( void )

/*-----------------------------------------------------------*/

//#define PCLK    48000000
int main(void)
{
	GPIOResetPins(); // Set pins to a safe state

	prvSetupHardware(); // Set PLL and timing for this application

	setPinsForApplication(); // Set pins for board layout

	enableSerial0();

	/* We are using the semaphore for synchronization so we create a binary
	 semaphore rather than a mutex.  We must make sure that the interrupt
	 does not attempt to use the semaphore before it is created! */
	vSemaphoreCreateBinary( xSemaphore );

	PWMinit(0, microsecondsToCPUTicks(3300));//3.3ms period, 300hz, given 48mhz CPU clock
	setupPWMChannelPeripheral(PWM1_1, microsecondsToCPUTicks(150));
	//setupPWMPinSetup2378(PWM1_1);

	// Initialize SPI ADC communication
	// Set to 4 MHz baud rate
	//SSPx_Open( MODULE_SSP0, EIGHT_BITS, SSP_SPI_FORMAT, 0, 0, NINE_CLCKS_BIT,
	//                          SSP_MASTER, 0, ROLL_SENSOR_BAUD_RATE_PRESCALER );

	const uint32_t ssp0_serial_clock_rate = 4000000;
	const uint8_t ssp0ClocksPerBit = ((PCLK / ssp0_serial_clock_rate)
			/ ROLL_SENSOR_BAUD_RATE_PRESCALER) - 1;

	initSSP0(SSP_EIGHT_BITS, SSP_SPI_FORMAT, false, false, false,
			ssp0ClocksPerBit, ROLL_SENSOR_BAUD_RATE_PRESCALER, SSP_MASTER,
			false);

	//testSSP0();

	xSerialPortInitMinimal(0, 115200, 250);
	vSerialPutString(0, "Starting up LPC23xx with FreeRTOS\n", 50);

	//configure10khzTimer1();



	xTaskCreate(rollControlTask, (signed portCHAR *) "rollControlTask",
			ROLL_CONTROL_STACK_SIZE, NULL, mainCHECK_TASK_PRIORITY - 1, NULL );

	/* Start the scheduler. */
	vTaskStartScheduler();

	/* Will only get here if there was insufficient memory to create the idle
	 task. */
	return 0;
}
/*-----------------------------------------------------------*/

extern void vRC(void);

void vApplicationTickHook(void)
{
	vRC();

	/*
	 unsigned portBASE_TYPE uxColumn = 0;
	 static xLCDMessage xMessage = { 0, "PASS" };
	 static unsigned portLONG ulTicksSinceLastDisplay = 0;
	 static portBASE_TYPE xHigherPriorityTaskWoken = pdFALSE;

	 // Called from every tick interrupt.  Have enough ticks passed to make it
	 // time to perform our health status check again?
	 ulTicksSinceLastDisplay++;
	 if( ulTicksSinceLastDisplay >= mainCHECK_DELAY )
	 {
	 ulTicksSinceLastDisplay = 0;

	 // Has an error been found in any task?

	 if( xAreBlockingQueuesStillRunning() != pdTRUE )
	 {
	 xMessage.pcMessage = "ERROR - BLOCKQ";
	 }

	 if( xAreBlockTimeTestTasksStillRunning() != pdTRUE )
	 {
	 xMessage.pcMessage = "ERROR - BLOCKTIM";
	 }

	 if( xAreGenericQueueTasksStillRunning() != pdTRUE )
	 {
	 xMessage.pcMessage = "ERROR - GENQ";
	 }

	 if( xAreQueuePeekTasksStillRunning() != pdTRUE )
	 {
	 xMessage.pcMessage = "ERROR - PEEKQ";
	 }

	 if( xAreDynamicPriorityTasksStillRunning() != pdTRUE )
	 {
	 xMessage.pcMessage = "ERROR - DYNAMIC";
	 }

	 xMessage.xColumn++;

	 // Send the message to the LCD gatekeeper for display.
	 xHigherPriorityTaskWoken = pdFALSE;
	 }
	 */
}

