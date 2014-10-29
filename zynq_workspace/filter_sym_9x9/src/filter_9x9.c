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
#include "filter_9x9.h"

void filter_9x9_Init(filter_params *params, int a, int b, int c, int d, int e, int f, int g,
                                            int h, int i, int j, int k, int l, int m, int n, int o, int shift,int offset)
{
  params->a = a;
  params->b = b;
  params->c = c;
  params->d = d;
  params->e = e;
  params->f = f;
  params->g = g;
  params->h = h;
  params->i = i;
  params->j = j;
  params->k = k;
  params->l = l;
  params->m = m;
  params->n = n;
  params->o = o;
  params->shift = shift;
  params->offset = offset;
} 

int filter_9x9_Execute(filter_params *params, Image *input, Image *output)
{
  unsigned int height = 0;
  unsigned int width = 0;
  unsigned int channels = 0;

  unsigned int row = 0;
  unsigned int col = 0;

  unsigned char *pixelOut = NULL;
  unsigned char *sl1 = NULL;
  unsigned char *sl2 = NULL;
  unsigned char *sl3 = NULL;
  unsigned char *sl4 = NULL;
  unsigned char *sl5 = NULL;
  unsigned char *sl6 = NULL;
  unsigned char *sl7 = NULL;
  unsigned char *sl8 = NULL;
  unsigned char *sl9 = NULL;

  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int e = 0;
  int f = 0;
  int g = 0;
  int h = 0;
  int i = 0;
  int j = 0;
  int k = 0;
  int l = 0;
  int m = 0;
  int n = 0;
  int o = 0;
  int shift = 0;

  long signed A = 0;
  long signed B = 0;
  long signed C = 0;
  long signed D = 0;
  long signed E = 0;
  long signed F = 0;
  long signed G = 0;
  long signed H = 0;
  long signed I = 0;
  long signed J = 0;
  long signed K = 0;
  long signed L = 0;
  long signed M = 0;
  long signed N = 0;
  long signed O = 0;
  
  long signed sum = 0;

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
  height = input->height;
  width = input->width;
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
  g = params->g;
  h = params->h;
  i = params->i;
  j = params->j;
  k = params->k;
  l = params->l;
  m = params->m;
  n = params->n;
  o = params->o;
  shift = params->shift;

  /*-----------------------------------------------------------------------------
   *  Prepare output image
   *-----------------------------------------------------------------------------*/
  if(output->data != NULL){
    DEBUG_PRINT("Output image is not empty! Image will be overwritten.\n");
    ImageCleanup(output);
  }
  output->height = height;
  output->width = width;
  output->channels = 1;
  output->bitsPerChannel = input->bitsPerChannel;
  output->config = input->config;
  output->data = (unsigned char*)malloc(height*width);
  if(!output->data){
    fprintf(stderr, "Failed to allocate output data image buffer\n");
    return -1;
  }


  /*-----------------------------------------------------------------------------
   *  Perform the filtering
   *-----------------------------------------------------------------------------*/
  pixelOut = output->data;
  sl1 = input->data - 4*width;
  sl2 = input->data - 3*width;
  sl3 = input->data - 2*width;
  sl4 = input->data - width;
  sl5 = input->data;
  sl6 = input->data + width;
  sl7 = input->data + 2*width;
  sl8 = input->data + 3*width;
  sl9 = input->data + 4*width;
  for(row = 0; row < height; row++){                 /* Slowscan loop */
    for(col = 0; col < width; col++){               /* Fastscan loop */
      if(row<4 || row > height-5 || col<4 || col > width-5){ /* Copy pixels if on border */
        *pixelOut = *sl5;
      }
      else{
        A = a*(sl5[0]);
        B = b*(sl5[-1]+sl5[1]+sl4[0]+sl6[0]);
        C = c*(sl4[-1]+sl4[1]+sl6[-1]+sl6[1]);
        D = d*(sl3[0]+sl5[-2]+sl5[2]+sl7[0]);
        E = e*(sl3[-1]+sl3[1]+sl4[-2]+sl4[2]+sl6[-2]+sl6[2]+sl7[-1]+sl7[1]);
        F = f*(sl3[-2]+sl3[2]+sl7[-2]+sl7[2]);
        G = g*(sl2[0]+sl5[-3]+sl5[3]+sl8[0]);
        H = h*(sl2[-1]+sl2[1]+sl4[-3]+sl4[3]+sl6[-3]+sl6[3]+sl8[-1]+sl8[1]);
        I = i*(sl2[-2]+sl2[2]+sl3[-3]+sl3[3]+sl7[-3]+sl7[3]+sl8[-2]+sl8[2]);
        J = j*(sl2[-3]+sl2[3]+sl8[-3]+sl8[3]);
        K = k*(sl1[0]+sl5[-4]+sl5[4]+sl9[0]);
        L = l*(sl1[-1]+sl1[1]+sl4[-4]+sl4[4]+sl6[-4]+sl6[4]+sl9[-1]+sl9[1]);
        M = m*(sl1[-2]+sl1[2]+sl3[-4]+sl3[4]+sl7[-4]+sl7[4]+sl9[-2]+sl9[2]);
        N = n*(sl1[-3]+sl1[3]+sl2[-4]+sl2[4]+sl8[-4]+sl8[4]+sl9[-3]+sl9[3]);
        O = o*(sl1[-4]+sl1[4]+sl9[-4]+sl9[4]);
        sum = A + B + C + D + E + F + G + H + I + J + K + L + M + N + O;
        sum = (sum >> shift) + (long)params->offset;
        DEBUG_PRINT("(%d,%d): %ld\n", row, col, sum);
        if(sum > 255){
          *pixelOut = 255;
        }
        else if(sum < 0){
          *pixelOut = 0;
        }
        else{
          *pixelOut = sum;
        }

      }
      sl1++;
      sl2++;
      sl3++;
      sl4++;
      sl5++;
      sl6++;
      sl7++;
      sl8++;
      sl9++;
      pixelOut++;
    }
  }
  return 0;
}
