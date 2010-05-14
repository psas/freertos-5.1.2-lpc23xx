#ifndef SSP_H_
#define SSP_H_

#include "lpc23xx.h"
#include "gpdma.h"
#include <stdint.h>
#include <stdbool.h>

#define SSP_EIGHT_BITS   7
#define SSP_SPI_FORMAT  0
#define SSP_MASTER   true



bool isSSP0_TX_FIFO_Empty(void);

void initSSP0(
		const uint8_t dataSize, /*default 7, equivlant to 8 bits per transfer*/
		const uint8_t frameFormat, /*Default to 0 for SPI frame format*/
		const bool clockOutPolarity,/*Default to false*/
		const bool clockPhase,/*Default to false*/
		const bool slaveOutDisable,/*default to false*/
		const uint8_t ssp0ClocksPerBit,
		const uint8_t ssp0ClockPrescalar,
		const bool masterMode,
		const bool cphaFlag/*Default false*/
		);

void initSSP1(const uint8_t ssp1SerialClockRate, const uint8_t ssp1ClockPrescalar, const bool masterMode, const bool cphaFlag);

bool transmitSSP0_SPI_BufferViaDMA0(const uint8_t *data, const uint16_t numBytes);
bool transmitSSP0_SPI_BufferViaDMA1(const uint8_t *data, const uint16_t numBytes);
bool transmitSSP1_SPI_BufferViaDMA(const uint8_t *data, const uint16_t numBytes);


bool readSSP0_SPI(const uint32_t timeout, uint16_t  *dest );
bool readSSP1_SPI(const uint32_t timeout, uint16_t  *dest );

bool transmitSSP0_SPI_1byte(const uint16_t byte1);
bool transmitSSP1_SPI_1byte(const uint16_t byte1);

void appendToSSP0TransmitFIFO(const uint16_t data);
void appendToSSP1TransmitFIFO(const uint16_t data);

bool enqueueSSP0_SPI(const uint16_t byte1);

bool readSSP0_SPI(const uint32_t timeout, uint16_t  *dest );
bool readSSP1_SPI(const uint32_t timeout, uint16_t  *dest );

void clearFIFO_SSP0(void);
void clearFIFO_SSP1(void);

bool ssp0_SPI_transfer(
		const uint8_t *outData, const uint8_t numOutBytes, 
		uint8_t *inData, const uint8_t inDataSize, 
		const uint8_t extraInBytesToRead );

bool ssp1_SPI_transfer(
		const uint8_t *outData, const uint8_t numOutBytes, 
		uint8_t *inData, const uint8_t inDataSize, 
		const uint8_t extraInBytesToRead );

#endif /*SSP_H_*/
