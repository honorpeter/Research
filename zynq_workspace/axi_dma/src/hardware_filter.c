/*
 * =====================================================================================
 *
 *       Filename:  hardware_filter.c
 *
 *    Description:  hardware filter implemenation
 *
 *        Version:  1.0
 *        Created:  10/15/2014 11:25:27 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#ifdef ZYNQ
#include "hardware_filter.h"
#include <stdio.h>
#include <stdlib.h>

int hardware_filter_init(Image *input, hardware_config *ptr)
{
  int input_size = 0;
  int output_size = 0;
  int r = 0;
  int c = 0;
  int plus_rows = 2;

  unsigned char *pImg_us = NULL;
  uint8_t *pImg_ks = NULL;

  if(!input){
    return -1;
  }
  if(!ptr){
    return -1;
  }
  switch(input->width){
    case 512:
      if(system("cat filter_512.bit > /dev/xdevcfg")<0){
        return -1;
      }
      break;
    case 1024:
      if(system("cat filter_1024.bit > /dev/xdevcfg")<0){
        return -1;
      }
      break;
    case 2048:
      if(system("cat filter_2048.bit > /dev/xdevcfg")<0){
        return -1;
      }
      break;
    default:
      return -1;
  }
  xdma_alloc_reset();
  ptr->src_size = input->width*(input->height+plus_rows);
  ptr->dst_size = input->width*(input->height+plus_rows);

  ptr->src_ptr = (uint32_t*)xdma_alloc(ptr->src_size, sizeof(uint8_t));
  ptr->dst_ptr = (uint32_t*)xdma_alloc(ptr->dst_size, sizeof(uint8_t));

  pImg_us = input->data;
  pImg_ks = (uint8_t*)ptr->src_ptr;

  for(r = 0; r < input->height; r++){
    for(c = 0; c < input->width; c++){
      *(pImg_ks++) = *(pImg_us++);
    }
  }
  for(r = 0; r < plus_rows; r++){
    for(c = 0; c < input->width; c++){
      *(pImg_ks)++ = 0;
    }
  }

  return 0;
}

int hardware_filter_execute(hardware_config *ptr)
{
  xdma_perform_transaction(0, XDMA_WAIT_NONE, ptr->src_ptr, ptr->src_size, 
                            ptr->dst_ptr, ptr->dst_size);
}

int hardware_filter_cleanup(Image *inImg, Image *outImg, hardware_config *ptr)
{
  int r = 0;
  int c = 0;
  int plus_rows = 2;

  unsigned char *pImg_us = NULL;
  uint8_t *pImg_ks = NULL;

  if(!inImg){
    return -1;
  }
  if(!outImg){
    return -1;
  }
  if(!ptr){
    return -1;
  }
  if(xdma_init() < 0){
    return -1;
  }
  if(xdma_num_of_devices() < 0){
    fprintf(stderr, "Could not find DMA device\n");
    return -1;
  }

  outImg->height = inImg->height;
  outImg->width = inImg->width;
  outImg->channels = inImg->channels;
  outImg->bitsPerChannel = inImg->bitsPerChannel;
  outImg->data = (unsigned char*)malloc(inImg->height*inImg->width);

  pImg_us = outImg->data;
  pImg_ks = (uint8_t*)(ptr->dst_ptr) + inImg->width*1 + 2;

  for(r = 0; r < outImg->height; r++){
    for(c = 0; c < outImg->width; c++){
      *(pImg_us++) = *(pImg_ks++);
    }
  }

  xdma_alloc_reset();
  xdma_exit();
  return 0;
}
#endif // ZYNQ
