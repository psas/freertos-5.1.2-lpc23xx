
#ifndef CAN_H_
#define CAN_H_

#include "FreeRTOS.h"
#include "lpc23xx.h"
#include <stdint.h>
#include <stdbool.h>

#define CANxGSR_RECEIVE_BUFFER_STATUS_MASK (1<<0)
#define CANxGSR_DATA_OVERRUN_STATUS_MASK (1<<1)
#define CANxGSR_TRANSMIT_BUFFER_STATUS_MASK (1<<2)
#define CANxGSR_TRANSMIT_COMPLETE_STATUS_MASK (1<<3)
#define CANxGSR_ERROR_STATUS_MASK (1<<6)
#define CANxGSR_BUS_STATUS_MASK (1<<7)

#define CANxCMR_CLEAR_DATA_OVERRUN_MASK (1<<3)

#define   CANxMOD_RM  (1<<0)
#define   CANxMOD_STM  (1<<2)


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
} can_message_t;


void initializeCAN(const enum CAN_Bus bus, const uint32_t baudRatePrescalar,
		const uint32_t synchronizationJumpWidth, const uint32_t tseg1, const uint32_t tseg2, const bool sam );


















#endif /*CAN_H_*/
