/*
 * =====================================================================================
 *
 *       Filename:  axi_dma.h
 *
 *    Description:  AXI DMA userspace driver header fil
 *
 *        Version:  1.0
 *        Created:  10/24/2014 01:46:04 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#ifndef _AXI_DMA_H_
#define _AXI_DMA_H_

/*-----------------------------------------------------------------------------
 *  Includes
 *-----------------------------------------------------------------------------*/
#include <stdint.h>
#include <stdlib.h>
#include "defs.h"


/*-----------------------------------------------------------------------------
 *  Defines
 *-----------------------------------------------------------------------------*/
#define AXI_DMA_TRANS_ASYNC   0
#define AXI_DMA_TRANS_SYNC    1

volatile uint32_t* axi_dma_alloc(size_t size);

int axi_dma_init(void);
int axi_dma_perform_transaction(volatile uint32_t *pSrc, size_t src_size, volatile uint32_t *pDst, size_t dst_size, int trans_type);
int axi_dma_reset(void);
int axi_dma_cleanup(void);

#endif // !_AXI_DMA_H_

