
#ifndef CAN_H_
#define CAN_H_

#include "FreeRTOS.h"
#include "lpc23xx.h"
#include <stdint.h>
#include <stdbool.h>

#define CANxGSR_RECEIVE_BUFFER_STATUS_MASK   (1<<0)
#define CANxGSR_DATA_OVERRUN_STATUS_MASK     (1<<1)
#define CANxGSR_TRANSMIT_BUFFER_STATUS_MASK   (1<<2)
#define CANxGSR_TRANSMIT_COMPLETE_STATUS_MASK (1<<3)
#define CANxGSR_ERROR_STATUS_MASK (1<<6)
#define CANxGSR_BUS_STATUS_MASK (1<<7)


#define CANxCMR_TRANSMISSION_REQUEST      (1<<0)
#define CANxCMR_ABORT_TRANSMISSION        (1<<1)
#define CANxCMR_RELEASE_RECEIVE_BUFFER    (1<<2)
#define CANxCMR_CLEAR_DATA_OVERRUN_MASK   (1<<3)
#define CANxCMR_SELECT_TX_BUFFER_1        (1<<5)
#define CANxCMR_SELECT_TX_BUFFER_2        (1<<6)
#define CANxCMR_SELECT_TX_BUFFER_3        (1<<7)


#define CANxSR_RECEIVE_BUFFER_STATUS          (1<<0)
#define CANxSR_DATA_OVERRRUN_STATUS           (1<<1)
#define CANxSR_TRANSMIT_BUFFER_STATUS_1       (1<<2)
#define CANxSR_TRANSMISSION_COMPLETE_STATUS   (1<<3)
#define CANxSR_RECEIVE_STATUS                 (1<<4)
#define CANxSR_TRANSMIT_STATUS_1              (1<<5)
#define CANxSR_ERROR_STATUS                   (1<<6)
#define CANxSR_BUS_STATUS                     (1<<7)
#define CANxSR_RECEIVE_BUFFER_STATUS2         (1<<8)
#define CANxSR_DATA_OVERRRUN_STATUS2          (1<<9)
#define CANxSR_TRANSMIT_BUFFER_STATUS_2       (1<<10)
#define CANxSR_TRANSMIT_BUFFER_STATUS_3       (1<<11)




#define CANxMOD_RM  (1<<0)
#define CANxMOD_STM  (1<<2)
#define CANxMOD_CDO  (1<<3)

#define CAN_VIC_INTERUPT_BITMASK   (1<<23)

#define CANxIER_RIE     (1<<0)
#define CANxIER_TEI1    (1<<1)
#define CANxIER_TEI2    (1<<9)
#define CANxIER_TEI3    (1<<10)

#define CANxICR_RI      (1<<0)
#define CANxICR_TI1      (1<<1)



enum CAN_Bus {
	CAN_BUS_1,
	CAN_BUS_2,
};

enum CAN_Status {
	CAN_OK,
	CAN_OVERRUN,
	CAN_ERROR
};

typedef struct  {
	uint32_t isPopulated;
	uint32_t id;
	uint32_t dataA;
	uint32_t dataB;
	uint32_t dataLengthCode;
	uint32_t canxRFS;
	uint32_t receiveTimestamp;

	uint32_t canErrorCount;
	uint32_t canDataOverrunCount;
	uint8_t rtr;
} can_message_t;


#define CAN_FIFO_SIZE	16
typedef struct {
	volatile int	head;
	volatile int 	tail;
	volatile can_message_t buff[CAN_FIFO_SIZE];
} can_queue_t;


void checkAndFixCANControllerLockup(const enum CAN_Bus bus);

__attribute__ ((naked)) void canISR(void);
void initCANQueues(void);
void processCANTxQueue(const enum CAN_Bus bus);
int enqueueTxCAN(const enum CAN_Bus bus, can_message_t *msg);
int dequeueRxCAN(const enum CAN_Bus bus, can_message_t *msg);
//clear queue functions


void initializeCAN(const enum CAN_Bus bus, const uint32_t baudRatePrescalar,
		const uint32_t synchronizationJumpWidth, const uint32_t tseg1,
		const uint32_t tseg2, const bool sam );

int readCAN(const enum CAN_Bus bus, can_message_t *dest_can_message);
void transmitCAN( const enum CAN_Bus bus, const uint32_t id,
		          const uint32_t payload1, const uint32_t payload2,
                  const uint8_t dlc, const bool rtr );
void disableCAN(const enum CAN_Bus bus);
void reEnableCAN(const enum CAN_Bus bus);


#endif /*CAN_H_*/
