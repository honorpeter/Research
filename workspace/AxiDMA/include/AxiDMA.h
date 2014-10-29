/*
 * =====================================================================================
 *
 *       Filename:  AxiDMA.h
 *
 *    Description:  Axi DMA userspace driver include file
 *
 *        Version:  1.0
 *        Created:  09/15/2014 10:53:47 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */

#ifndef _AXIDMA_H_
#define _AXIDMA_H_

#include <pthread.h>
#include "defs.h"

/*-----------------------------------------------------------------------------
 *  AXI DMA Definitions
 *-----------------------------------------------------------------------------*/
#define DMA_REG_SIZE 4
#define DMA_REG_COUNT 17               // Number of registers associated with simple DMA
#define DMAMapLength DMA_REG_SIZE*DMA_REG_COUNT // Total number of bytes needed to be mapped 

/*-----------------------------------------------------------------------------
 *  AXI DMA Register offsets
 *-----------------------------------------------------------------------------*/
#define MM2S_DMACR_OFFSET     0x00
#define MM2S_DMASR_OFFSET     0x04
#define MM2S_SA_OFFSET        0x18
#define MM2S_LENGTH_OFFSET    0x28

#define S2MM_DMACR_OFFSET     0x30
#define S2MM_DMASR_OFFSET     0x34
#define S2MM_DA_OFFSET        0x48
#define S2MM_LENGTH_OFFSET    0x58



typedef struct{
  UINT  baseAddr;
  int           dmaHandler;
  int           length;
  UINT  *dmaVirtualAddress;
  UINT  *buffer1VirtualAddress;
  UINT  *buffer2VirtualAddress;

  pthread_mutex_t lock;
}AxiDMA_info;

int AxiDMA_Init(AxiDMA_info *info, 
                UINT baseAddr,
                int size, 
                UINT b1Addr, 
                UINT b2Addr   );

void AxiDMA_Clear(AxiDMA_info *info);
UINT AxiDMA_Get(AxiDMA_info *info, int num);
void AxiDMA_Set(AxiDMA_info *info, int num, UINT val);
void AxiDMA_ReadStart(AxiDMA_info *info, UINT adr);
void AxiDMA_WriteStart(AxiDMA_info *info, UINT adr);
int AxiDMA_IsRunning(AxiDMA_info *info);
int AxiDMA_IsDone(AxiDMA_info *info);
void AxiDMA_Disp(AxiDMA_info *info, char *str, int num);

#endif // !_AXIDMA_H_ 

