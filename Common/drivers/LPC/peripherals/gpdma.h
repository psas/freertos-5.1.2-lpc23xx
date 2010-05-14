#ifndef GPDMA_H_
#define GPDMA_H_

#include "lpc23xx.h"
#include <stdint.h>
#include <stdbool.h>

enum DMA_Channel_Number {
	DMA_CHANNEL_0,
	DMA_CHANNEL_1
};


#define GPDMA_CHx_CFG_GPDMA_ENABLE_MASK      ((uint32_t) 0x01)
#define GPDMA_CHx_CFG_GPDMA_ACTIVE_MASK   (1<<17)

#define DMACC0Control_SBSize_BIT 12
#define DMACC0Control_DBSize_BIT 15
#define DMACC0Control_SWidth_BIT 18
#define DMACC0Control_DWidth_BIT 21
#define DMACC0Control_SI_BIT 26
#define DMACC0Control_DI_BIT 27
#define DMACC0Control_I_BIT 31


//Note: dont go above 4096 bytes because thats the buffer size on the FTID chip
#define DMA_MEMORY_ARRAY_SIZE   4000

void initializeGPDMA(void);

bool isDmaActive(const enum DMA_Channel_Number dmaChannelNumber);

int memoryToMemoryDMATransfer(const enum DMA_Channel_Number dmaChannelNumber, 
		const void *srcAddress, const void *destAddress,
		const uint8_t srcBurstSize, const uint8_t destBurstSize, 
		const uint8_t srcTransferWidth, const uint8_t destTransferWidth,
		const bool sourceIncrementFlag, const bool destIncrementFlag, 
		const uint32_t transferSize);
#endif /*GPDMA_H_*/
