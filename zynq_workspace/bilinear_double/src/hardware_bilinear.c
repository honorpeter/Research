/*
 * =====================================================================================
 *
 *       Filename:  hardware_bilinear.c
 *
 *    Description:  Hardware bilinear source file
 *
 *        Version:  1.0
 *        Created:  11/04/2014 06:10:37 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */

#ifdef ZYNQ
#include <stdio.h>
#include <stdlib.h>

#include "axi_dma.h"
#include "debug.h"
#include "hardware_bilinear.h"

int hardware_bilinear_init(Image *input, hardware_config *ptr)
{
  /*-----------------------------------------------------------------------------
   *  Variables
   *-----------------------------------------------------------------------------*/
  int input_size = 0;
  int output_size = 0;
  int r = 0;
  int c = 0;
  
  unsigned char *pImg_us = NULL; // User space image
  uint8_t *pImg_ks = NULL;        // Kernel space image

  /*-----------------------------------------------------------------------------
   *  Validate inputs
   *-----------------------------------------------------------------------------*/
  if(!input){
    fprintf(stderr, "hardware_bilinear_init: input passed in as NULL\n");
    return -1;
  }
  if(!ptr){
    fprintf(stderr, "hardware_bilinear_init: hardware config passed in as NULL\n");
    return -1;
  }

  /*-----------------------------------------------------------------------------
   *  Write the bit file
   *-----------------------------------------------------------------------------*/
    if(system("cat bilinear.bit > /dev/xdevcfg")<0){
      return -1;
    }

  

  /*-----------------------------------------------------------------------------
   *  Initialize the AXI DMA
   *-----------------------------------------------------------------------------*/
  axi_dma_init();

  /*-----------------------------------------------------------------------------
   *  Determine the sizes for the input and output images
   *-----------------------------------------------------------------------------*/
  ptr->src_size = input->width*input->height;
  ptr->dst_size = (input->width*2)*input->height; // Only double width (horz interp)

  /*-----------------------------------------------------------------------------
   *  Allocate the space in kernel memory
   *-----------------------------------------------------------------------------*/
  ptr->src_ptr = (uint32_t*)axi_dma_alloc(ptr->src_size * sizeof(uint8_t));
  ptr->dst_ptr = (uint32_t*)axi_dma_alloc(ptr->dst_size * sizeof(uint8_t));

  /*-----------------------------------------------------------------------------
   *  Copy the user space image to kernel space
   *-----------------------------------------------------------------------------*/
  pImg_us = input->data;
  pImg_ks = (uint8_t*)ptr->src_ptr;
  for(r = 0; r < input->height; r++){
    for(c = 0; c < input->width; c++){
      *(pImg_ks++) = *(pImg_us++);
    }
  }

  return 0;
}

int hardware_bilinear_execute(Image *input, Image *output, hardware_config *ptr, int async)
{
  /*-----------------------------------------------------------------------------
   *  Validate inputs
   *-----------------------------------------------------------------------------*/
  if(!input){
    fprintf(stderr, "hardware_bilinear_execute: input passed in as NULL\n");
    return -1;
  }
  if(!output){
    fprintf(stderr, "hardware_bilinear_execute: output passed in as NULL\n");
    return -1;
  }
  if(!ptr){
    fprintf(stderr, "hardware_bilinear_execute: hardware config passed in as NULL\n");
    return -1;
  }


  /*-----------------------------------------------------------------------------
   *  Generate output dimensions
   *-----------------------------------------------------------------------------*/
  output->width = input->width*2;
  output->height = input->height;
  output->data = (unsigned char*)ptr->dst_ptr+4;
  output->channels = input->channels;
  output->bitsPerChannel = input->bitsPerChannel;
  output->config = input->config;

  /*-----------------------------------------------------------------------------
   *  Begin transaction, don't wait
   *-----------------------------------------------------------------------------*/
  axi_dma_perform_transaction(ptr->src_ptr, ptr->src_size, ptr->dst_ptr, ptr->dst_size, async);
  DEBUG_PRINT("SRC Prt: %p\n", ptr->src_ptr);
  DEBUG_PRINT("SRC Size: %d\n", ptr->src_size);
  DEBUG_PRINT("dst Prt: %p\n", ptr->dst_ptr);
  DEBUG_PRINT("dst Size: %d\n", ptr->dst_size);
  return 0;
}

int hardware_bilinear_cleanup(Image *in, Image *out, hardware_config *ptr)
{
  axi_dma_cleanup();
  //free(ptr->src_ptr);
  //free(ptr->dst_ptr);
  ptr->src_ptr = NULL;
  ptr->dst_ptr = NULL;

  out->data = NULL;
  ImageCleanup(out);


  return 0;
}
#endif // ZYNQ
