#include "gpdma.h"



//__attribute__ ((section (".usbDmaRamData"), aligned(4))) volatile uint8_t dmaMemoryArrayOut0[DMA_MEMORY_ARRAY_SIZE];
//__attribute__ ((section (".usbDmaRamData"), aligned(4))) volatile uint8_t dmaMemoryArrayOut1[DMA_MEMORY_ARRAY_SIZE];
/*__attribute__ ((section (".usbDmaRamData"), aligned(4))) volatile uint8_t dmaMemoryZeroBuffer[DMA_MEMORY_ARRAY_SIZE];*/


                                                            
/* Description: This function initialized the 2 DMA controllers 
 *   
 * Parameters: none
 * 
 * Return Value(s): none 
 */
void initializeGPDMA(void) {
	PCONP |= (1<29);//Power up gpdma
	PCONP |= (1<31);//Power up DMA'able RAM
	
	//Clear pending interupts
	GPDMA_INT_TCCLR |= 0x03;//Clear both DMA0/1 channels
	GPDMA_INT_ERR_CLR = 0x03;//clear both DMA0/1  errors

	GPDMA_CONFIG |= 0x01;//Enable GPDMA
}




bool isDmaActive(const enum DMA_Channel_Number dmaChannelNumber)
{
	if( dmaChannelNumber == DMA_CHANNEL_0 ) {
		if( GPDMA_CH0_CFG & (1<<17) ) {
			return(true);
		} else {
			return(false);
		}
	} else if( dmaChannelNumber == DMA_CHANNEL_1 ) {
		if( GPDMA_CH1_CFG & (1<<17) ) {
			return(true);
		} else {
			return(false);
		}
	}

	return(true);
}


int memoryToMemoryDMATransfer(const enum DMA_Channel_Number dmaChannelNumber, 
		const void *srcAddress, const void *destAddress,
		const uint8_t srcBurstSize, const uint8_t destBurstSize, 
		const uint8_t srcTransferWidth, const uint8_t destTransferWidth,
		const bool sourceIncrementFlag, const bool destIncrementFlag, 
		const uint32_t transferSize)
	 
{
	volatile unsigned long *gpdma_chX_src = NULL;
	volatile unsigned long *gpdma_chX_dest = NULL;
	volatile unsigned long *gpdma_chX_ctrl = NULL;
	
	if( dmaChannelNumber == DMA_CHANNEL_0 ) {
		gpdma_chX_ctrl = &GPDMA_CH0_CTRL;
		gpdma_chX_src = &GPDMA_CH0_SRC;
		gpdma_chX_dest = &GPDMA_CH0_DEST;
		GPDMA_CH0_CFG = 0;
		
		//Clear pending interupts
		GPDMA_INT_TCCLR = 0x01; //clear on dma 0
		//Clear channels
		GPDMA_INT_ERR_CLR = 0x01; //clear errors on dma 0
		
	} else if( dmaChannelNumber == DMA_CHANNEL_1 ) {
		gpdma_chX_ctrl = &GPDMA_CH1_CTRL;
		gpdma_chX_src = &GPDMA_CH1_SRC;
		gpdma_chX_dest = &GPDMA_CH1_DEST;
		GPDMA_CH1_CFG = 0;
		
		//Clear pending interupts
		GPDMA_INT_TCCLR = 0x02; //clear on dma 1
		//Clear channels
		GPDMA_INT_ERR_CLR = 0x02; //clear errors on dma 1
	} else {
		return(-1);
	}
	


	
	/*Set up DMA channel 0 to stream data from memory to SSP0 */
	*gpdma_chX_src = (unsigned long) srcAddress;
	*gpdma_chX_dest = (unsigned long) destAddress;

	/* The burst size is set to 8, the size is 8 bit too. */
	/* Terminal Count Int enable */
	uint32_t new_ctrl_value = 0;

	new_ctrl_value |= (transferSize & 0x0FFF); //transfer size
	new_ctrl_value |= (srcBurstSize << DMACC0Control_SBSize_BIT) | (destBurstSize << DMACC0Control_DBSize_BIT);
	new_ctrl_value |= (srcTransferWidth << DMACC0Control_SWidth_BIT) | (destTransferWidth << DMACC0Control_DWidth_BIT);
	if( sourceIncrementFlag ) {
		new_ctrl_value |= (1 << DMACC0Control_SI_BIT);
	}
	if( destIncrementFlag ) {
		new_ctrl_value |= (1 << DMACC0Control_DI_BIT);
	}
		
	*gpdma_chX_ctrl = new_ctrl_value;
	
	
	if( dmaChannelNumber == DMA_CHANNEL_0 ) {
		GPDMA_CH0_CFG = 1;//Trigger a memory-to-memory transfer
	} else if( dmaChannelNumber == DMA_CHANNEL_1 ) {
		GPDMA_CH1_CFG = 1;//Trigger a memory-to-memory transfer
	}

	return(0);
}





