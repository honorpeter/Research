/*
 * =====================================================================================
 *
 *       Filename:  bilinear.c
 *
 *    Description:  Bilinear interpolation source file
 *
 *        Version:  1.0
 *        Created:  11/02/2014 01:18:40 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "debug.h"
#include "bilinear.h"

int bilinear_horz_execute(Image *pIn, Image *pOut, float scale)
{

  int row_out = 0;
  int col_out = 0;
  float col_in = 0.0;
  UINT col_min = 0;
  UINT col_max = 0;
  UINT col_max_prev = 1000000;
  UCHAR *pixelOut = NULL;
  UCHAR *pixelIn = NULL;

  DEBUG_PRINT("Beginning horizontal bilinear interpolation\n");
  /*-----------------------------------------------------------------------------
   *  Input checking
   *-----------------------------------------------------------------------------*/
  if(!pIn){
    fprintf(stderr, "Image *pIn passed in as NULL\n");
    return -1;
  }
  if(!pOut){
    fprintf(stderr, "Image *pOut passed in as NULL\n");
    return -1;
  }
  if(scale < 1){
    fprintf(stderr, "Scale cannot be less than 1!\n");
    return -1;
  }
  if(pOut->data != NULL){
    DEBUG_PRINT("Data in output image is not NULL, clearing the data!\n");
    ImageCleanup(pOut);
  }


  /*-----------------------------------------------------------------------------
   *  Calculate new image size
   *-----------------------------------------------------------------------------*/
  pOut->width = pIn->width * scale;
  pOut->height = pIn->height;
  pOut->channels = pIn->channels;
  pOut->bitsPerChannel = pIn->bitsPerChannel;
  pOut->config = pIn->config;


  /*-----------------------------------------------------------------------------
   *  Allocate output image
   *-----------------------------------------------------------------------------*/
  pOut->data = (UCHAR*)malloc(pOut->width*pOut->height*sizeof(UCHAR));
  if(!pOut->data){
    fprintf(stderr, "Failed to allocate output data\n");
    return -1;
  }

  /*-----------------------------------------------------------------------------
   *  Iterate over the output image and fill it in with the interoplated data
   *-----------------------------------------------------------------------------*/
  pixelOut = pOut->data;
  for(row_out = 0; row_out < pOut->height; row_out++){
    pixelIn = pIn->data + (row_out)*pIn->width;
    for(col_out = 0; col_out < pOut->width; col_out++){

      /*-----------------------------------------------------------------------------
       *  Map the output pixel to the input
       *-----------------------------------------------------------------------------*/
      col_in = (float)(col_out)/scale;
      col_min = floor(col_in);
      col_max = col_min + 1;
      if(col_max_prev == col_min){
        pixelIn++;
      }
      *pixelOut = (UCHAR)((col_max-col_in)*(*pixelIn) + (col_in-col_min)*(*(pixelIn+1)));
      col_max_prev = col_max;
      pixelOut++;
    }
  }
  DEBUG_PRINT("Completed horizontal bilinear interpolation\n");
  return 0;
}

int bilinear_vert_execute(Image *pIn, Image *pOut, float scale)
{

  int row_out = 0;
  int col_out = 0;
  float row_in = 0.0;
  UINT row_min = 0;
  UINT row_max = 0;
  UCHAR *pixelOut = NULL;
  UCHAR *pixelIn_upper = NULL;
  UCHAR *pixelIn_lower = NULL;
  UCHAR zero = 0;

  /*-----------------------------------------------------------------------------
   *  Input checking
   *-----------------------------------------------------------------------------*/
  DEBUG_PRINT("Beginning vertical bilinear interpolation\n");
  if(!pIn){
    fprintf(stderr, "Image *pIn passed in as NULL\n");
    return -1;
  }
  if(!pOut){
    fprintf(stderr, "Image *pOut passed in as NULL\n");
    return -1;
  }
  if(scale < 1){
    fprintf(stderr, "Scale cannot be less than 1!\n");
    return -1;
  }
  if(pOut->data != NULL){
    DEBUG_PRINT("Data in output image is not NULL, clearing the data!\n");
    ImageCleanup(pOut);
  }


  /*-----------------------------------------------------------------------------
   *  Calculate new image size
   *-----------------------------------------------------------------------------*/
  pOut->width = pIn->width;
  pOut->height = pIn->height*scale;
  pOut->channels = pIn->channels;
  pOut->bitsPerChannel = pIn->bitsPerChannel;
  pOut->config = pIn->config;

  /*-----------------------------------------------------------------------------
   *  Allocate output image
   *-----------------------------------------------------------------------------*/
  pOut->data = (UCHAR*)malloc(pOut->width*pOut->height*sizeof(UCHAR));
  if(!pOut->data){
    fprintf(stderr, "Failed to allocate output data\n");
    return -1;
  }

  /*-----------------------------------------------------------------------------
   *  Iterate over the output image and fill it in with the interoplated data
   *-----------------------------------------------------------------------------*/
  pixelOut = pOut->data;
  for(row_out = 0; row_out < pOut->height; row_out++){
    /*-----------------------------------------------------------------------------
     *  Map the output pixel to the input
     *-----------------------------------------------------------------------------*/
    row_in = (float)(row_out)/scale;
    row_min = floor(row_in);
    row_max = row_min+1;

    pixelIn_upper = pIn->data + (row_min)*pIn->width;
    pixelIn_lower = pIn->data + (row_max)*pIn->width;

    if(row_out == pOut->height-1){
      pixelIn_lower = &zero;
    }

    for(col_out = 0; col_out < pOut->width; col_out++){
      *pixelOut = (row_max-row_in)*(*pixelIn_upper) + (row_in-row_min)*(*pixelIn_lower);
      pixelIn_upper++;
      if(row_out != pOut->height-1){
        pixelIn_lower++;
      }
      pixelOut++;
    }
  }
  DEBUG_PRINT("Completed vertical bilinear interpolation\n");
  return 0;
}

int bilinear_execute(Image *pIn, Image *pOut, float scale)
{
  Image temp = IMAGE_INITIALIZER;
  if(bilinear_horz_execute(pIn, &temp, scale) < 0){
    fprintf(stderr, "Horizontal interpolation failed\n");
    return -1;
  }
  if(bilinear_vert_execute(&temp, pOut, scale) < 0){
    fprintf(stderr, "Vertical interpolation failed\n");
    return -1;
  }
  ImageCleanup(&temp);
  return 0;
}

int bilinear_vert_execute_volatile(Image *pIn, Image *pOut, float scale)
{

  int row_out = 0;
  int col_out = 0;
  float row_in = 0.0;
  UINT row_min = 0;
  UINT row_max = 0;
  UCHAR *pixelOut = NULL;
  UCHAR *pixelIn_upper = NULL;
  UCHAR *pixelIn_lower = NULL;
  UCHAR zero = 0;
  unsigned char *ptmp = NULL;

  /*-----------------------------------------------------------------------------
   *  Input checking
   *-----------------------------------------------------------------------------*/
  DEBUG_PRINT("Beginning vertical bilinear interpolation\n");
  if(!pIn){
    fprintf(stderr, "Image *pIn passed in as NULL\n");
    return -1;
  }
  if(!pOut){
    fprintf(stderr, "Image *pOut passed in as NULL\n");
    return -1;
  }
  if(scale < 1){
    fprintf(stderr, "Scale cannot be less than 1!\n");
    return -1;
  }
  if(pOut->data != NULL){
    DEBUG_PRINT("Data in output image is not NULL, clearing the data!\n");
    ImageCleanup(pOut);
  }


  /*-----------------------------------------------------------------------------
   *  Calculate new image size
   *-----------------------------------------------------------------------------*/
  pOut->width = pIn->width;
  pOut->height = pIn->height*scale;
  pOut->channels = pIn->channels;
  pOut->bitsPerChannel = pIn->bitsPerChannel;
  pOut->config = pIn->config;

  /*-----------------------------------------------------------------------------
   *  Allocate input image
   *-----------------------------------------------------------------------------*/
  ptmp = (unsigned char*)malloc(sizeof(UCHAR)*pIn->width*pIn->height);
  memcpy(ptmp, pIn->data,pIn->width*pIn->height);

  /*-----------------------------------------------------------------------------
   *  Allocate output image
   *-----------------------------------------------------------------------------*/
  pOut->data = (UCHAR*)malloc(pOut->width*pOut->height*sizeof(UCHAR));
  if(!pOut->data){
    fprintf(stderr, "Failed to allocate output data\n");
    return -1;
  }

  /*-----------------------------------------------------------------------------
   *  Iterate over the output image and fill it in with the interoplated data
   *-----------------------------------------------------------------------------*/
  pixelOut = pOut->data;
  for(row_out = 0; row_out < pOut->height; row_out++){
    /*-----------------------------------------------------------------------------
     *  Map the output pixel to the input
     *-----------------------------------------------------------------------------*/
    row_in = (float)(row_out)/scale;
    row_min = floor(row_in);
    row_max = row_min+1;

    pixelIn_upper = ptmp + (row_min)*pIn->width;
    pixelIn_lower = ptmp + (row_max)*pIn->width;
    if(row_out == pOut->height-1){
      pixelIn_lower = &zero;
    }

    for(col_out = 0; col_out < pOut->width; col_out++){
      *pixelOut = (row_max-row_in)*(*pixelIn_upper) + (row_in-row_min)*(*pixelIn_lower);
      pixelIn_upper++;
      if(row_out != pOut->height-1){
        pixelIn_lower++;
      }
      pixelOut++;
    }
  }
  free(ptmp);
  DEBUG_PRINT("Completed vertical bilinear interpolation\n");
  return 0;
}
