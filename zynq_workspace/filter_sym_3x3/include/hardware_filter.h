/*
 * =====================================================================================
 *
 *       Filename:  hardware_filter.h
 *
 *    Description:  hardware filter include file
 *
 *        Version:  1.0
 *        Created:  10/15/2014 11:19:17 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology 
 *
 * =====================================================================================
 */
#ifdef ZYNQ
#ifndef _HARDWARE_FILTER_H_
#define _HARDWARE_FILTER_H_
#include "image.h"
#include "libxdma.h"
typedef struct{
  uint32_t *src_ptr;
  uint32_t *dst_ptr;
  unsigned int src_size;
  unsigned int dst_size;
}hardware_config;

int hardware_filter_init(Image *input, hardware_config *ptr);
int hardware_filter_execute(hardware_config *ptr);
int harware_filter_cleanup(Image *in, Image *out, hardware_config *ptr);

#endif // !_HARDWARE_FILTER_H_
#endif // ZYNQ
