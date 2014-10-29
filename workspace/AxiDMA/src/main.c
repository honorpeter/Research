/*
 * =====================================================================================
 *
 *       Filename:  main.c
 *
 *    Description:  Test program for userspace dma driver
 *
 *        Version:  1.0
 *        Created:  09/15/2014 12:44:26 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology 
 *
 * =====================================================================================
 */

#include <stdio.h>
#include "AxiDMA.h"

#define DMA_WORD_WIDTH      4 // bytes per word
#define DMA_FRAME_SIZE      16

#define bufferLength        DMA_WORD_WIDTH*DMA_FRAME_SIZE
#define buffer1Addr         0x31000000
#define buffer2Addr         0x32000000
#define DMABaseAddr         0x40400000

int main(void)
{
  AxiDMA_info dma;
  AxiDMA_Init(&dma, DMABaseAddr, bufferLength, buffer1Addr, buffer2Addr);

  AxiDMA_ReadStart(&dma, buffer1Addr);

  fprintf(stdout, "Waiting for end...\n");
  while(AxiDMA_IsDone(&dma)==0);
  fprintf(stdout, "Transaction complete!\n");

  AxiDMA_Clear(&dma);
  return(0);
}

