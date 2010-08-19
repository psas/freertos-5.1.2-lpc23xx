/*
    SPI Library
 */
#ifndef SPI_H_
#define SPI_H_

#include <stdint.h>
#include "semphr.h"

#define SPI0_DEBUG 0

#define WAIT_ON_SPIF         while (spi_readStatus() == 0) {} 

xSemaphoreHandle spi_semaphore;

void        spi_isr(void) __attribute__ ((naked));
void        spi_infoMsg (char *string);
void        spi_errorMsg (char *string);
void        spi_init(void);
void        spi_initInt(void);
int8_t      spi_readStatus (void);
void        spi_setBytesPerTransfer(const int8_t numBytes);
void        spi_transferNBytesInt(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize);
void        spi_transferNBytesBW(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize);


#endif

