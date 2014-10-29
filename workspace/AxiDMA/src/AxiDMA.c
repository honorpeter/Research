/*
 * =====================================================================================
 *
 *       Filename:  AxiDMA.c
 *
 *    Description:  Source file for userspace driver for AXI DMA
 *
 *        Version:  1.0
 *        Created:  09/15/2014 11:05:16 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */

#include <fcntl.h>
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>

#include "AxiDMA.h"

int AxiDMA_Init(AxiDMA_info *info, UINT baseAddr, int length, UINT b1Addr, UINT b2Addr)
{
  info->baseAddr = baseAddr;
  info->length = length;
  fprintf(stdout, "Opening /dev/mem\n");
  info->dmaHandler = open("/dev/mem", O_RDWR);
  fprintf(stdout, "/dev/mem open\n");
  fprintf(stdout, "mmaping dmaVirtualAddress: ");
  info->dmaVirtualAddress = (UINT*)mmap(NULL, 
                                        DMAMapLength,
                                        PROT_READ | PROT_WRITE, 
                                        MAP_SHARED, 
                                        info->dmaHandler, 
                                        (off_t)info->baseAddr);
  fprintf(stdout, "DONE\n");

  if(info->dmaVirtualAddress == MAP_FAILED){
    perror("dmaVirtualAddress mapping for absolute memory access failed.\n");
    return(-1);
  }

  fprintf(stdout, "mmaping buffer1VirtualAddress: ");
  info->buffer1VirtualAddress = (UINT*)mmap(NULL,
                                            info->length,
                                            PROT_READ | PROT_WRITE,
                                            MAP_SHARED,
                                            info->dmaHandler,
                                            (off_t)b1Addr);
  fprintf(stdout, "DONE\n");
  
  if(info->buffer1VirtualAddress == MAP_FAILED){
    perror("buffer1VirtualAddress mapping for absolute memory access failed.\n");
    return(-2);
  }

  fprintf(stdout, "mmaping buffer2VirtualAddress: ");
  info->buffer2VirtualAddress = (UINT*)mmap(NULL,
                                            info->length,
                                            PROT_READ | PROT_WRITE,
                                            MAP_SHARED,
                                            info->dmaHandler,
                                            (off_t)b2Addr);
  
  fprintf(stdout, "DONE\n");
  if(info->buffer2VirtualAddress == MAP_FAILED){
    perror("buffer2VirtualAddress mapping for absolute memory access failed.\n");
    return(-3);
  }
  
  return(0);
}

void AxiDMA_Clear(AxiDMA_info *info)
{
  munmap((void*)info->dmaVirtualAddress, DMAMapLength);
  munmap((void*)info->buffer1VirtualAddress, info->length);
  munmap((void*)info->buffer2VirtualAddress, info->length);
  close(info->dmaHandler);
}

UINT AxiDMA_Get(AxiDMA_info *info, int num)
{ 
  if(num >= 0 && num < DMA_REG_COUNT ){
    return(info->dmaVirtualAddress[num]);
  }
  return 0;
}

void AxiDMA_Set(AxiDMA_info *info, int num, UINT val)
{
  if(num >= 0 && num < DMA_REG_COUNT){
    info->dmaVirtualAddress[num] = val;
  }
}

void AxiDMA_WriteStart(AxiDMA_info *info, UINT addr)
{
  AxiDMA_Disp(info, "status", 0x04/4);
  AxiDMA_Disp(info, "control", 0x00/4);


  /*-----------------------------------------------------------------------------
   *  Start MM2S channel - Set the Run/Stop bit to 1
   *  MM2S_DMACR.RS = 1
   *  Check that DMASR.Halted = 0
   *-----------------------------------------------------------------------------*/


  /*-----------------------------------------------------------------------------
   *  Write source address to MM2S_SA register
   *-----------------------------------------------------------------------------*/

  
  /*-----------------------------------------------------------------------------
   *  Write number of bytes to transfer in MM2S_LENGTH register
   *-----------------------------------------------------------------------------*/
}

void AxiDMA_ReadStart(AxiDMA_info *info, UINT addr)
{

  /*-----------------------------------------------------------------------------
   *  Start S2MM channel by setting run/stop bit to 1 
   *  S2MM_DMACR.RS = 1
   *  check that DMASR.Halted = 0
   *-----------------------------------------------------------------------------*/
  AxiDMA_Disp(info,"status ", S2MM_DMASR_OFFSET/DMA_REG_SIZE);
  AxiDMA_Disp(info,"control ", S2MM_DMACR_OFFSET/DMA_REG_SIZE);

  AxiDMA_Set(info, S2MM_DMACR_OFFSET/DMA_REG_SIZE, 0x01);
  while((AxiDMA_Get(info, S2MM_DMASR_OFFSET/DMA_REG_SIZE) & 1) == 1);

  AxiDMA_Disp(info,"status ", S2MM_DMASR_OFFSET/DMA_REG_SIZE);
  AxiDMA_Set(info, S2MM_DMASR_OFFSET/DMA_REG_SIZE, 0xFFFFFFFF); // clear pending interrupts
  AxiDMA_Disp(info,"status ", S2MM_DMASR_OFFSET/DMA_REG_SIZE);
  
  /*-----------------------------------------------------------------------------
   *  Write destination address to S2MM_DA register
   *-----------------------------------------------------------------------------*/
  AxiDMA_Set(info, S2MM_DA_OFFSET/DMA_REG_SIZE, addr);
  AxiDMA_Disp(info, "dest ", S2MM_DA_OFFSET/DMA_REG_SIZE);

  /*-----------------------------------------------------------------------------
   *  Write length in bytes to S2MM_LENGTH register
   *-----------------------------------------------------------------------------*/
  AxiDMA_Set(info, S2MM_LENGTH_OFFSET/DMA_REG_SIZE, info->length);
  AxiDMA_Disp(info, "length ", S2MM_LENGTH_OFFSET/DMA_REG_SIZE);

  AxiDMA_Disp(info, "status ", S2MM_DMASR_OFFSET/DMA_REG_SIZE);
  AxiDMA_Disp(info, "control ", S2MM_DMACR_OFFSET/DMA_REG_SIZE);
}

int AxiDMA_IsRunning(AxiDMA_info *info)
{
  return((AxiDMA_Get(info, S2MM_DMASR_OFFSET/DMA_REG_SIZE)&1) == 1);
}

int AxiDMA_IsDone(AxiDMA_info *info)
{
  return((AxiDMA_Get(info, S2MM_DMASR_OFFSET/DMA_REG_SIZE)&0x1000) == 1);
}

void AxiDMA_Disp(AxiDMA_info *info, char *str, int num)
{
  printf("%s(%02x)=%08x\n", str, num, AxiDMA_Get(info, num));
}
