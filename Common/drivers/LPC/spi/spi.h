/*
    SPI Library
 */
#ifndef SPI_H_
#define SPI_H_

#include <stdint.h>

#define SPI0_DEBUG 1

#define WAIT_ON_SPIF         while (spi_readStatus() == 0) {} 

void        spi_infoMsg (char *string);
void        spi_errorMsg (char *string);
void        spi_init(void);
int8_t      spi_readStatus (void);
void        spi_setBytesPerTransfer(const int8_t numBytes);
//uint32_t    spi_transferNBytes(const int32_t payload, const int8_t numBytes);
void spi_transferNBytes(const uint8_t *outPayload, const uint8_t outPayloadSize, uint8_t *inPayload, uint8_t inPayloadSize);


#endif

