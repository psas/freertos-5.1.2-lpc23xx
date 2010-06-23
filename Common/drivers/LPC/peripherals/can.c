/******************************************************************************
 * Module:                       can.c
 *
 * Description: This module is used to provide access to the CAN peripherals
 *     on NXP LPC2xxx series micro-controllers.
 *
 *
 *****************************************************************************/
// Includes
#include "can.h"

// Local prototypes
static int readCAN1(can_message_t *dest_can_message);
static int readCAN2(can_message_t *dest_can_message);

/*===========================================================================*/
//                            External Functions
/*===========================================================================*/

/******************************************************************************
 * Description: This function is used to initialize the CAN peripheral.
 *
 * Parameters: none
 *
 * Return Value(s): none
 *****************************************************************************/
void initializeCAN ( const enum CAN_Bus bus,
                     const uint32_t baudRatePrescalar,
                     const uint32_t synchronizationJumpWidth,
                     const uint32_t tseg1,
                     const uint32_t tseg2,
                     const bool sampleThreeTimes )
{
	//Set can PCLK to = CCLK for the acceptance filter
	PCLKSEL0 |= (1<<30); // This should be under init filters

	if( bus == CAN_BUS_1 )
	{
		PCLKSEL0 |= (1<<26);//Set can PCLK to = CCLK
		PCONP |= (1<<13);//Power ON the can1 peripheral
	}
	else
	{
		PCLKSEL0 |= (1<<28);//Set can PCLK to = CCLK
		PCONP |= (1<<14);//Power ON the can2 peripheral
	}

	uint32_t canxBtrVal = 0;
	canxBtrVal |= (baudRatePrescalar<<0);//Set baud rate pre-scalar
	canxBtrVal |= (tseg1<<16);//Set TSEG1
	canxBtrVal |= (tseg2<<20);//Set TSEG2
	canxBtrVal |= (synchronizationJumpWidth<<14);//Set SJW
	if( sampleThreeTimes ) {
		canxBtrVal |= (1<<23);
	}

	// Set CAN into reset mode, allows modification of CAN configuration registers
	if( bus == CAN_BUS_1 ) {
		CAN1MOD = 1; //Disable the CANx receiver

		// Disable CAN Receive Interrupt
		CAN1IER = 0;

		// Reset Error Counter
		CAN1GSR = 0;

		CAN1BTR = canxBtrVal; // Set the bitrate value

	} else {
		CAN2MOD = 1; //Disable the CANx receiver
		// Disable CAN Receive Interrupt
		CAN2IER = 0;

		// Reset Error Counter
		CAN2GSR = 0;

		CAN2BTR = canxBtrVal; // Set the bitrate value
	}

	CAN_AFMR = 0x02; //Disable address filtering, Receive all messages
	
	//Set CAN into operational mode, lock some CAN configuration regs
	if( bus == CAN_BUS_1 ) {
		CAN1MOD |= CANxMOD_STM;
		CAN1MOD &= ~(CANxMOD_RM);
	} else {
		CAN2MOD |= CANxMOD_STM;
		CAN2MOD &= ~(CANxMOD_RM);
	}
}


/******************************************************************************
 * Description: This function is used to read a message from the
 *     read FIFO in the CAN controller.
 *
 * Parameters: none
 *
 * Return Value(s):
 *
 *****************************************************************************/
int readCAN(const enum CAN_Bus bus, can_message_t *dest_can_message)
{
	if( bus == CAN_BUS_1 ) {
		return(readCAN1(dest_can_message));
	} else {
		return(readCAN2(dest_can_message));
	}
}


/******************************************************************************
 * Description: This function sends a CAN message.
 *
 * Parameters:
 *      -
 * Return Value(s): If it wrote a can message, then non-zero, if it did not
 * write a CAN message, returns zero.
 *****************************************************************************/
void transmitCAN( const enum CAN_Bus bus,
                  const uint32_t id,
                  const uint32_t payload1,
                  const uint32_t payload2,
                  const uint8_t dlc,
                  const bool rtr )
{
	if( bus == CAN_BUS_1 ) {
		CAN1TFI1 = ((dlc & 0x0F)<<16);//Set the DLC
		if( rtr ) {
			CAN1TFI1 |= (1<<30);
		}
		CAN1TID1 = id;//ID number
		CAN1TDA1 = payload1;
		CAN1TDA2 = payload2;
		CAN1CMR = 0x21; //Select TX buffer 1 and trigger transmission
	} else {
		CAN2TFI1 = ((dlc & 0x0F)<<16);//Set the DLC
		if( rtr ) {
			CAN2TFI1 |= (1<<30);
		}
		CAN2TID1 = id;//ID number
		CAN2TDA1 = payload1;
		CAN2TDA2 = payload2;
		CAN2CMR = 0x21; //Select TX buffer 1 and trigger transmission
	}
}


/******************************************************************************
 * Description: This function is used to disable the CAN controller.
 *
 * Parameters: none
 *
 * Return Value(s): none
 *****************************************************************************/
void disableCAN(const enum CAN_Bus bus)
{
	// Disable the CAN module by setting the RM bit
	if( bus == CAN_BUS_1 ) {
		CAN1MOD |= CANxMOD_RM;
	} else {
		CAN2MOD |= CANxMOD_RM;
	}
}


/******************************************************************************
 * Description: This function is used to re-enable the CAN controller. The
 *     controller must have been previously initialized.
 *
 * Parameters: none
 *
 * Return Value(s): none
 *****************************************************************************/
void reEnableCAN(const enum CAN_Bus bus)
{
	//Set CAN into operational mode by clearing RM bit
	if( bus == CAN_BUS_1 ) {
		CAN1MOD &= ~(CANxMOD_RM);
	} else {
		CAN2MOD &= ~(CANxMOD_RM);
	}
}


/*===========================================================================*/
//                            Internal Functions
/*===========================================================================*/


/******************************************************************************
 * Description: This function is used to read from the CAN controller.
 *    
 * Parameters: none
 *   
 * Return Value(s): Zero if nothing was read, non-zero if something of
 * interest came in on the CAN controller
 *****************************************************************************/
static int readCAN1(can_message_t *dest_can_message)
{
	dest_can_message->isPopulated = 0;

	const uint32_t tempCAN1GSR = CAN1GSR;

	if( tempCAN1GSR & CANxGSR_DATA_OVERRUN_STATUS_MASK ) {
		return(CAN_OVERRUN);
	}
	
	if( tempCAN1GSR & CANxGSR_ERROR_STATUS_MASK ) {
		return(CAN_ERROR);
	}
	
	if ((tempCAN1GSR & CANxGSR_RECEIVE_BUFFER_STATUS_MASK) ) {//Check to see if a CAN has been received
		dest_can_message->id = CAN1RID;
		dest_can_message->dataA = CAN1RDA;
		dest_can_message->dataB = CAN1RDB;
		dest_can_message->dataLengthCode = (CAN1RFS & (0xF<<16)) >> 16;
		dest_can_message->canxRFS = CAN1RFS;
		dest_can_message->isPopulated = 1;

		CAN1CMR = 0x04;//Release the receive buffer after reading it and reset data overrun.
	}
	
	
	if ( tempCAN1GSR & CANxGSR_ERROR_STATUS_MASK) {//data error check
		CAN1CMR = CANxCMR_CLEAR_DATA_OVERRUN_MASK; //clear data overrun
	}

	return(CAN_OK);
}


/******************************************************************************
 * Description: This function is used to read a message from the
 *     read FIFO in the CAN controller.
 *
 * Parameters: none
 *
 * Return Value(s):
 *
 *****************************************************************************/
static int readCAN2(can_message_t *dest_can_message)
{
	dest_can_message->isPopulated = 0;

	const uint32_t tempCAN2GSR = CAN2GSR;

	if (tempCAN2GSR & CANxGSR_DATA_OVERRUN_STATUS_MASK) {
		disableCAN(CAN_BUS_2);
		CAN2CMR = CANxCMR_CLEAR_DATA_OVERRUN_MASK; //clear data overrun
		reEnableCAN(CAN_BUS_2);
		return (CAN_OVERRUN);
	}

	if (tempCAN2GSR & CANxGSR_ERROR_STATUS_MASK) {
		return (CAN_ERROR);
	}

	if ((tempCAN2GSR & CANxGSR_RECEIVE_BUFFER_STATUS_MASK)) {//Check to see if a CAN has been received
		dest_can_message->id = CAN2RID;
		dest_can_message->dataA = CAN2RDA;
		dest_can_message->dataB = CAN2RDB;
		dest_can_message->dataLengthCode = (CAN2RFS & (0xF << 16)) >> 16;
		dest_can_message->canxRFS = CAN2RFS;
		dest_can_message->isPopulated = 1;

		CAN2CMR = (1<<2);//Release the receive buffer after reading it and reset data overrun.
	}

	if (tempCAN2GSR & CANxGSR_ERROR_STATUS_MASK) {//data error check
		CAN2CMR = CANxCMR_CLEAR_DATA_OVERRUN_MASK; //clear data overrun
	}

	return (CAN_OK);
}






