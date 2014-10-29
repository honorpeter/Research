/*
 * =====================================================================================
 *
 *       Filename:  axi_dma.c
 *
 *    Description:  Source file for AXI DMA userspace driver
 *
 *        Version:  1.0
 *        Created:  10/24/2014 02:03:07 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#include "axi_dma.h"
#include "debug.h"

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

/*-----------------------------------------------------------------------------
 *  Register definitions
 *-----------------------------------------------------------------------------*/
#define AXI_DMA_BASE_ADR            0x40400000
#define AXI_DMA_OFFSET_MM2S_DMACR   0x00/sizeof(uint32_t)
#define AXI_DMA_OFFSET_MM2S_DMASR   0x04/sizeof(uint32_t)
#define AXI_DMA_OFFSET_MM2S_SA      0x18/sizeof(uint32_t)
#define AXI_DMA_OFFSET_MM2S_LENGTH  0x28/sizeof(uint32_t)
#define AXI_DMA_OFFSET_S2MM_DMACR   0x30/sizeof(uint32_t)
#define AXI_DMA_OFFSET_S2MM_DMASR   0x34/sizeof(uint32_t)
#define AXI_DMA_OFFSET_S2MM_DA      0x48/sizeof(uint32_t)
#define AXI_DMA_OFFSET_S2MM_LENGTH  0x58/sizeof(uint32_t)

// CR bit accesses
#define AXI_DMA_RUN_STOP            (1<<0)
#define AXI_DMA_RESET               (1<<2)

// SR bit accesses
#define AXI_DMA_HALTED              (1<<0)
#define AXI_DMA_IDLE                (1<<1)
#define AXI_DMA_SLAVE_ERROR         (1<<6)
#define AXI_DMA_DECODE_ERROR        (1<<7)

#define AXI_DMA_MEMORY_START        0x39000000
#define AXI_DMA_MEMORY_END          0x40000000

#define AXI_DMA_TIMEOUT             1000000

/*-----------------------------------------------------------------------------
 *  Global Variables
 *-----------------------------------------------------------------------------*/
static volatile uint32_t* axi_dma_address_ptr;
static int fd;
static volatile uint32_t *axi_dma_base_reg_ptr;
static volatile uint32_t *axi_dma_base_mem_ptr;

static inline void axi_dma_set_bit(volatile uint32_t *pReg, uint32_t bit);
static inline void axi_dma_clear_bit(volatile uint32_t *pReg, uint32_t bit);
static inline volatile int axi_dma_assert_bit(volatile uint32_t *pReg, uint32_t bit, int val);
static inline volatile int axi_dma_wait(volatile uint32_t *pReg, uint32_t bitmask, int value);

/*-----------------------------------------------------------------------------
 *  axi_dma_alloc
 *-----------------------------------------------------------------------------*/
volatile uint32_t* axi_dma_alloc(size_t size)
{
  volatile uint32_t *ret = NULL;

  if((axi_dma_address_ptr + (size/sizeof(uint32_t))) < axi_dma_base_mem_ptr +(AXI_DMA_MEMORY_END-AXI_DMA_MEMORY_START)){
    ret = axi_dma_address_ptr;
    axi_dma_address_ptr += (size/sizeof(uint32_t));
    DEBUG_PRINT("Successfully allocated %d bytes of memory at %p\n", size, (void*)ret);
  }
  else{
   DEBUG_PRINT("Could not allocate %d bytes of memory!\n", size); 
  }
  return ret;
}


/*-----------------------------------------------------------------------------
 *  axi_dma_init
 *-----------------------------------------------------------------------------*/
int axi_dma_init(void)
{

  /*-----------------------------------------------------------------------------
   *  Create the memory mappings for the AXI DMA registers and the memory 
   *  sandbox
   *-----------------------------------------------------------------------------*/
  fd = open("/dev/mem", O_RDWR|O_SYNC);
  if(fd < 0){
    DEBUG_PRINT("Failed to open /dev/mem.\n");
    return -1;
  }
  else{
    DEBUG_PRINT("Successfully opened /dev/mem.\n");
  }
  axi_dma_base_reg_ptr = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, AXI_DMA_BASE_ADR);
  if(axi_dma_base_reg_ptr == NULL){
    DEBUG_PRINT("Failed to mmap the axi dma registers to user space\n");
    return -1;
  }
  else{
    DEBUG_PRINT("Successfully mmapped the axi dma registers to userspace at %p\n", (void*)axi_dma_base_reg_ptr);
  }
  axi_dma_base_mem_ptr = mmap(0, AXI_DMA_MEMORY_END - AXI_DMA_MEMORY_START, PROT_READ|PROT_WRITE, MAP_SHARED, fd, AXI_DMA_MEMORY_START); 
  if(axi_dma_base_mem_ptr == NULL){
    DEBUG_PRINT("Failed ot mmap the memory sandbox to user space\n");
    return -1;
  }
  else{
    DEBUG_PRINT("Mapped the sandbox memory to %p\n", (void*)axi_dma_base_mem_ptr);
  }

  /*-----------------------------------------------------------------------------
   *  Reset the axi dma
   *-----------------------------------------------------------------------------*/
  axi_dma_set_bit(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_DMACR, AXI_DMA_RESET);

  /*-----------------------------------------------------------------------------
   *  Reset the memory allocation pointer to starting value
   *-----------------------------------------------------------------------------*/
  axi_dma_address_ptr = axi_dma_base_mem_ptr;
  return 0;
}


/*-----------------------------------------------------------------------------
 *  axi_dma_configure
 *-----------------------------------------------------------------------------*/
int axi_dma_perform_transaction(volatile uint32_t *pSrc, size_t src_size, volatile uint32_t *pDst, size_t dst_size, int trans_type)
{

  uint32_t *src_addr;
  uint32_t *dst_addr;
  /*-----------------------------------------------------------------------------
   *  Validate the inputs
   *-----------------------------------------------------------------------------*/
  axi_dma_set_bit(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_DMACR, AXI_DMA_RESET);
  if(!pSrc){
    DEBUG_PRINT("Source pointer is NULL.\n");
    return -1;
  }
  if(!pDst){
    DEBUG_PRINT("Destination pointer is NULL.\n");
    return -1;
  }
  if((trans_type != AXI_DMA_TRANS_ASYNC) && (trans_type != AXI_DMA_TRANS_SYNC)){
    DEBUG_PRINT("Invalid transaction type %d\n", trans_type);
    return -1;
  }

  if(pSrc > pDst){
    dst_addr = (uint32_t*)AXI_DMA_MEMORY_START;
    src_addr = (uint32_t*)(AXI_DMA_MEMORY_START + (pSrc-pDst));
  }
  else{
    src_addr = (uint32_t*)AXI_DMA_MEMORY_START;
    dst_addr = (uint32_t*)(src_addr + (pDst-pSrc));
  }

  DEBUG_PRINT("src data location: %p\n", src_addr);
  DEBUG_PRINT("dst data location: %p\n", dst_addr);
  /*-----------------------------------------------------------------------------
   *  Start the axi dma channel rx
   *-----------------------------------------------------------------------------*/
  axi_dma_set_bit(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DMACR, AXI_DMA_RUN_STOP);
  if(axi_dma_wait(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DMASR, AXI_DMA_HALTED, 0) < 0){
    DEBUG_PRINT("Timeout expired waiting for RX halt to deassert\n");
    DEBUG_PRINT("S2MM_DMASR: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DMASR));
    return -1;
  }
    DEBUG_PRINT("S2MM_DMASR: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DMASR));

  /*-----------------------------------------------------------------------------
   *  Write the destination address
   *-----------------------------------------------------------------------------*/
  *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DA) = (uint32_t)dst_addr;
  DEBUG_PRINT("DA: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DA));

  
  /*-----------------------------------------------------------------------------
   *  Write the destination length
   *-----------------------------------------------------------------------------*/
  *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_LENGTH) = (uint32_t)(dst_size);
  DEBUG_PRINT("DS: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_LENGTH));

  /*-----------------------------------------------------------------------------
   *  Start the axi dma channel tx
   *-----------------------------------------------------------------------------*/
  axi_dma_set_bit(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_DMACR, AXI_DMA_RUN_STOP);
  if(axi_dma_wait(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_DMASR, AXI_DMA_HALTED, 0) < 0){
    DEBUG_PRINT("Timeout expired waiting for TX halt to deassert\n");
    DEBUG_PRINT("MM2S_DMASR: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_DMASR));
    return -1;
  }
    DEBUG_PRINT("MM2S_DMASR: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_DMASR));
  /*-----------------------------------------------------------------------------
   *  Write the source address
   *-----------------------------------------------------------------------------*/
  *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_SA) = (uint32_t)src_addr;
  DEBUG_PRINT("DA: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_SA));

  /*-----------------------------------------------------------------------------
   *  Write the source length
   *-----------------------------------------------------------------------------*/
  *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_LENGTH) = (uint32_t)(src_size);
  DEBUG_PRINT("DS: %8X\n", *(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_MM2S_LENGTH));
  
  if(trans_type == AXI_DMA_TRANS_SYNC){
    if(axi_dma_wait(axi_dma_base_reg_ptr+AXI_DMA_OFFSET_S2MM_DMACR, AXI_DMA_RUN_STOP,0) < 0){
      DEBUG_PRINT("Timeout expired waiting for transaction to complete\n");
    }
  }

  return 0;
}

/*-----------------------------------------------------------------------------
 *  axi_dma_reset
 *-----------------------------------------------------------------------------*/
int axi_dma_reset(void)
{
  return axi_dma_init();
}

/*-----------------------------------------------------------------------------
 *  axi_dma_cleanup
 *-----------------------------------------------------------------------------*/
int axi_dma_cleanup(void)
{
  int ret = 0;
  if(munmap(axi_dma_base_reg_ptr, 4096) < 0){
    DEBUG_PRINT("Failed to unmap the axi dma register memory.\n");
    ret = -1;
  }
  axi_dma_base_reg_ptr = NULL;
  if(munmap(axi_dma_base_mem_ptr, AXI_DMA_MEMORY_END-AXI_DMA_MEMORY_START) < 0){
    DEBUG_PRINT("Failed to unmap the axi dma sandbox memory.\n");
    ret = -1;
  }
  axi_dma_base_mem_ptr = NULL;
  return ret;
}


/*-----------------------------------------------------------------------------
 *  axi_dma_wait
 *-----------------------------------------------------------------------------*/
static inline volatile int axi_dma_wait(volatile uint32_t *pReg, uint32_t bitmask, int value)
{
  const int timeout = AXI_DMA_TIMEOUT;
  int i = 0;
  while(axi_dma_assert_bit(pReg, bitmask, value) != 0){
    i++;
    if(i == timeout){
      DEBUG_PRINT("Timeout occured!\n");
      return -1;
    }
  }
  return 0;
}
static inline void axi_dma_set_bit(volatile uint32_t *pReg, uint32_t bitmask)
{
  *pReg = *pReg | bitmask;
}
static inline void axi_dma_clear_bit(volatile uint32_t *pReg, uint32_t bitmask)
{
  *pReg = *pReg & ~bitmask;
}
static inline volatile int axi_dma_assert_bit(volatile uint32_t *pReg, uint32_t bitmask, int value)
{
  if((*pReg & bitmask) == value){
    return 0;
  }
  return -1;
}
