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


static void resetCANController(const enum CAN_Bus bus);
static void transmitCANMsg(const enum CAN_Bus bus, can_message_t *msg);

static void can_fifo_init(can_queue_t *fifo);
static int can_fifo_put(can_queue_t *fifo, can_message_t *msg);
static int can_fifo_get(can_queue_t *fifo, can_message_t *msg);
static int enqueueRxCAN(const enum CAN_Bus bus, can_message_t *msg);
static int dequeueTxCAN(const enum CAN_Bus bus, can_message_t *msg);

//Static global variables
static can_queue_t can_bus1_tx_fifo;
static can_queue_t can_bus1_rx_fifo;

static can_queue_t can_bus2_tx_fifo;
static can_queue_t can_bus2_rx_fifo;

#define CAN_FIFO_NEXT_IDX(idx)        ((idx + 1) >= CAN_FIFO_SIZE ? 0 : (idx + 1))



/*===========================================================================*/
//                            External Functions
/*===========================================================================*/

void initCANQueues(void)
{
	can_fifo_init(&can_bus1_tx_fifo);
	can_fifo_init(&can_bus1_rx_fifo);
	can_fifo_init(&can_bus2_tx_fifo);
	can_fifo_init(&can_bus2_rx_fifo);
}

int enqueueTxCAN(const enum CAN_Bus bus, can_message_t *msg)
{

	if (bus == CAN_BUS_1) {
		return (can_fifo_put(&can_bus1_tx_fifo, msg));
	} else {
		return (can_fifo_put(&can_bus2_tx_fifo, msg));
	}
}

int dequeueRxCAN(const enum CAN_Bus bus, can_message_t *msg)
{
	if (bus == CAN_BUS_1) {
		return(can_fifo_get(&can_bus1_rx_fifo, msg));
	} else {
		return(can_fifo_get(&can_bus2_rx_fifo, msg));
	}
}

volatile uint32_t g_can_isr_count = 0;


void checkAndFixCANControllerLockup(const enum CAN_Bus bus)
{
	//FIXME this is a temporary function and should go away
	if (bus == CAN_BUS_1) {
		if (CAN1GSR & CANxGSR_DATA_OVERRUN_STATUS_MASK) {
			resetCANController(CAN_BUS_1);
		}
	} else {
		if (CAN2GSR & CANxGSR_DATA_OVERRUN_STATUS_MASK) {
			resetCANController(CAN_BUS_2);
		}
	}
}

__attribute__ ((naked)) void canISR(void)
{

	/* This ISR can cause a context switch, so the first statement must be a
	call to the portENTER_SWITCHING_ISR() macro.  This must be BEFORE any
	variable declarations. */
	//portENTER_SWITCHING_ISR();
	portSAVE_CONTEXT();

	g_can_isr_count++;

	static can_message_t msg;

	enum CAN_Status r;

	if( CAN1GSR & CANxGSR_RECEIVE_BUFFER_STATUS_MASK ) {
		msg.isPopulated = 0;
		r = readCAN1(&msg);
		if( r == CAN_OK && msg.isPopulated ) {
			enqueueRxCAN(CAN_BUS_1, &msg);
		}

		if( CAN1GSR & CANxGSR_DATA_OVERRUN_STATUS_MASK ) {
			resetCANController(CAN_BUS_1);
		}
	}

	if( CAN2GSR & CANxGSR_RECEIVE_BUFFER_STATUS_MASK ) {
		msg.isPopulated = 0;
		r = readCAN2(&msg);
		if( r == CAN_OK && msg.isPopulated ) {
			enqueueRxCAN(CAN_BUS_2, &msg);
		}

		if( CAN2GSR & CANxGSR_DATA_OVERRUN_STATUS_MASK ) {
			resetCANController(CAN_BUS_2);
		}
	}

	int dequeueStatus = dequeueTxCAN(CAN_BUS_1, &msg);
	if( dequeueStatus ) {
		transmitCANMsg(CAN_BUS_1, &msg);
	}

	dequeueStatus = dequeueTxCAN(CAN_BUS_2, &msg);
	if( dequeueStatus ) {
		transmitCANMsg(CAN_BUS_2, &msg);
	}


	/* Clear the ISR in the VIC. */
	VICVectAddr = 0;

	/* Exit the ISR.  If a task was woken by either a character being received
	or transmitted then a context switch will occur. */
	//portEXIT_SWITCHING_ISR( ( xTaskWokenByTx || xTaskWokenByRx ) );
	portRESTORE_CONTEXT();
}


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
		CAN1MOD = CANxMOD_RM; //Disable the CANx receiver

		// Disable CAN Receive Interrupt
		CAN1IER = 0;

		// Reset Error Counter
		CAN1GSR = 0;

		CAN1BTR = canxBtrVal; // Set the bitrate value

	} else {
		CAN2MOD = CANxMOD_RM; //Disable the CANx receiver
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

static void resetCANController(const enum CAN_Bus bus)
{
	if( bus == CAN_BUS_1 ) {
		CAN1MOD |= CANxMOD_CDO;
		CAN1MOD |= CANxMOD_RM;

		// Disable CAN Receive Interrupt
		const uint32_t old_ier = CAN1IER;
		if( old_ier & CANxIER_RIE ) {
			CAN1IER &= ~(CANxIER_RIE);
		}

		CAN1MOD &= ~(CANxMOD_RM);

		if( old_ier & CANxIER_RIE ) {
			CAN1IER |= CANxIER_RIE;
		}

	} else {
		CAN2MOD |= CANxMOD_CDO;
		CAN2MOD |= CANxMOD_RM;

		// Disable CAN Receive Interrupt
		const uint32_t old_ier = CAN1IER;
		if( old_ier & CANxIER_RIE ) {
			CAN2IER &= ~(CANxIER_RIE);
		}

		if( old_ier & CANxIER_RIE ) {
			CAN2IER |= CANxIER_RIE;
		}

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

static void transmitCANMsg( const enum CAN_Bus bus, can_message_t *msg)
{
	return(transmitCAN(bus, msg->id, msg->dataA, msg->dataB, msg->dataLengthCode, msg->rtr));
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
	checkAndFixCANControllerLockup(bus);//FIXME this needs to be removed after June 28th 2010

	if( bus == CAN_BUS_1 ) {
		CAN1TFI1 = ((dlc & 0x0F)<<16);//Set the DLC
		if( rtr ) {
			CAN1TFI1 |= (1<<30);
		}
		CAN1TID1 = id;//ID number
		CAN1TDA1 = payload1;
		CAN1TDA2 = payload2;
		CAN1CMR = 0x21; //Select TX buffer 1 and trigger transmission

		if( CAN1SR & CANxSR_TRANSMIT_BUFFER_STATUS_1 ) {
			CAN1CMR = CANxCMR_TRANSMISSION_REQUEST | CANxCMR_SELECT_TX_BUFFER_1; //Select TX buffer and trigger transmission
		} else if( CAN1SR & CANxSR_TRANSMIT_BUFFER_STATUS_2 ) {
			CAN1CMR = CANxCMR_TRANSMISSION_REQUEST | CANxCMR_SELECT_TX_BUFFER_2; //Select TX buffer and trigger transmission
		} else if( CAN1SR & CANxSR_TRANSMIT_BUFFER_STATUS_3 ) {
			CAN1CMR = CANxCMR_TRANSMISSION_REQUEST | CANxCMR_SELECT_TX_BUFFER_3; //Select TX buffer and trigger transmission
		}

	} else {
		CAN2TFI1 = ((dlc & 0x0F)<<16);//Set the DLC
		if( rtr ) {
			CAN2TFI1 |= (1<<30);
		}
		CAN2TID1 = id;//ID number
		CAN2TDA1 = payload1;
		CAN2TDA2 = payload2;

		if( CAN2SR & CANxSR_TRANSMIT_BUFFER_STATUS_1 ) {
			CAN2CMR = CANxCMR_TRANSMISSION_REQUEST | CANxCMR_SELECT_TX_BUFFER_1; //Select TX buffer and trigger transmission
		} else if( CAN2SR & CANxSR_TRANSMIT_BUFFER_STATUS_2 ) {
			CAN2CMR = CANxCMR_TRANSMISSION_REQUEST | CANxCMR_SELECT_TX_BUFFER_2; //Select TX buffer and trigger transmission
		} else if( CAN2SR & CANxSR_TRANSMIT_BUFFER_STATUS_3 ) {
			CAN2CMR = CANxCMR_TRANSMISSION_REQUEST | CANxCMR_SELECT_TX_BUFFER_3; //Select TX buffer and trigger transmission
		}
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







static void can_fifo_init(can_queue_t *fifo)
{
	fifo->head = 0;
	fifo->tail = 0;
}

static int can_fifo_put(can_queue_t *fifo, can_message_t *msg)
{
	// check if FIFO has room
	//const int next = (fifo->head + 1) % CAN_FIFO_SIZE;
	const int next = CAN_FIFO_NEXT_IDX(fifo->head);
	if (next == fifo->tail) {
		//fifo->tail = (fifo->tail + 1) % CAN_FIFO_SIZE;//FIXME this needs to be made atomic such that the put/get functions can clobber each others values
		fifo->tail = CAN_FIFO_NEXT_IDX(fifo->tail);//FIXME this needs to be made atomic such that the put/get functions can clobber each others values
	}

	fifo->buff[fifo->head] = *msg;
	fifo->head = next;

	return 1;
}

static int can_fifo_get(can_queue_t *fifo, can_message_t *msg)
{
	// check if FIFO has data
	if (fifo->head == fifo->tail) {
		return 0;
	}

	//const int next = (fifo->tail + 1) % CAN_FIFO_SIZE;
	const int next = CAN_FIFO_NEXT_IDX(fifo->tail);

	*msg = fifo->buff[fifo->tail];
	fifo->tail = next;

	return 1;
}

static int enqueueRxCAN(const enum CAN_Bus bus, can_message_t *msg)
{
	if (bus == CAN_BUS_1) {
		return (can_fifo_put(&can_bus1_rx_fifo, msg));
	} else {
		return (can_fifo_put(&can_bus2_rx_fifo, msg));
	}
}

static int dequeueTxCAN(const enum CAN_Bus bus, can_message_t *msg)
{
	if (bus == CAN_BUS_1) {
		return(can_fifo_get(&can_bus1_tx_fifo, msg));
	} else {
		return(can_fifo_get(&can_bus2_tx_fifo, msg));
	}
}





