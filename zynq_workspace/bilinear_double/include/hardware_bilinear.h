/*
 * =====================================================================================
 *
 *       Filename:  hardware_bilinear.h
 *
 *    Description:  Header file for hardware bilinear interpolation
 *
 *        Version:  1.0
 *        Created:  11/04/2014 06:04:12 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#ifdef ZYNQ
#ifndef _HARDWARE_BILINEAR_H_
#define _HARDWARE_BILINEAR_H_
#include <stdint.h>

#include "image.h"

typedef struct{
  uint32_t *src_ptr;
  uint32_t *dst_ptr;
  unsigned int src_size;
  unsigned int dst_size;
}hardware_config;

int hardware_bilinear_init(Image *input, hardware_config *ptr);
int hardware_bilinear_execute(Image *input, Image *output, hardware_config *ptr, int async);
int hardware_bilinear_cleanup(Image *in, Image *out, hardware_config *ptr);

#endif // !_HARDWARE_BILINEAR_H_
#endif // ZYNQ

