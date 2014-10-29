/*
 * =====================================================================================
 *
 *       Filename:  filter.c
 *
 *    Description:  Source file for 5x5 Symmetric Filter
 *
 *        Version:  1.0
 *        Created:  09/20/2014 06:28:59 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#include <stdio.h>
#include <stdlib.h>
#include "debug.h"
#include "filter.h"

void filter_Init(filter_params *params, int a, int b, int c, int d, int e, int f, int shift)
{
  params->a = a;
  params->b = b;
  params->c = c;
  params->d = d;
  params->e = e;
  params->f = f;
  params->shift = shift;
} 

int filter_Execute(filter_params *params, Image *input, Image *output)
{
  unsigned int h = 0;
  unsigned int w = 0;
  unsigned int channels = 0;

  unsigned int row = 0;
  unsigned int col = 0;

  unsigned char *pixelIn = NULL;
  unsigned char *pixelOut = NULL;
  unsigned char *sl1 = NULL;
  unsigned char *sl2 = NULL;
  unsigned char *sl3 = NULL;
  unsigned char *sl4 = NULL;
  unsigned char *sl5 = NULL;

  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int e = 0;
  int f = 0;
  int shift = 0;

  int A = 0;
  int B = 0;
  int C = 0;
  int D = 0;
  int E = 0;
  int F = 0;
  
  int sum = 0;

  /*-----------------------------------------------------------------------------
   *  Input checking
   *-----------------------------------------------------------------------------*/
  if(!params){
    fprintf(stderr, "Filter parameters passed in NULL pointer\n");
    return -1;
  }
  if(!input){
    fprintf(stderr, "Input image passed in NULL pointer\n");
    return -1;
  }
  if(!output){
    fprintf(stderr, "Output image passed in NULL pointer\n");
    return -1;
  }
  
  /*-----------------------------------------------------------------------------
   *  Store parameters
   *-----------------------------------------------------------------------------*/
  h = input->height;
  w = input->width;
  channels = input->channels;

  if(channels != 1){
    fprintf(stderr, "Only 1 channel grayscale images are supported!\n");
    return -1;
  }

  a = params->a;
  b = params->b;
  c = params->c;
  d = params->d;
  e = params->e;
  f = params->f;
  shift = params->shift;

  /*-----------------------------------------------------------------------------
   *  Prepare output image
   *-----------------------------------------------------------------------------*/
  if(output->data != NULL){
    fprintf(stderr, "Output image is not empty! Image will be overwritten.\n");
    ImageCleanup(output);
  }
  output->height = h;
  output->width = w;
  output->channels = 1;
  output->bitsPerChannel = input->bitsPerChannel;
  output->config = input->config;
  output->data = (unsigned char*)malloc(h*w);
  if(!output->data){
    fprintf(stderr, "Failed to allocate output data image buffer\n");
    return -1;
  }


  /*-----------------------------------------------------------------------------
   *  Perform the filtering
   *-----------------------------------------------------------------------------*/
  pixelIn = input->data;
  pixelOut = output->data;
  sl1 = input->data - 2*w;
  sl2 = input->data - w;
  sl3 = input->data;
  sl4 = input->data + w;
  sl5 = input->data + 2*w;
  for(row = 0; row < h; row++){                 /* Slowscan loop */
    for(col = 0; col < w; col++){               /* Fastscan loop */
      if(row<2 || row > h-3 || col<2 || col > w-3){ /* Copy pixels if on border */
        *pixelOut = *sl3;
      }
      else{
        A = a*(sl3[0]);
        B = b*(sl2[0] + sl3[-1] + sl3[1] + sl4[0]);
        C = c*(sl2[-1] + sl2[1] + sl4[-1] + sl4[1]);
        D = d*(sl1[0] + sl3[-2] + sl3[2] + sl5[0]);
        E = e*(sl1[-1] + sl1[1] + sl2[-2] + sl2[2] + sl4[-2] + sl4[2] + sl5[-1] + sl5[1]);
        F = f*(sl1[-2] + sl1[2] + sl5[-2] + sl5[2]);
        sum = A + B + C + D + E + F;
        *pixelOut = sum >> shift;
      }
      sl1++;
      sl2++;
      sl3++;
      sl4++;
      sl5++;
      pixelOut++;
    }
  }
  return 0;

}
