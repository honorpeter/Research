/*
 * =====================================================================================
 *
 *       Filename:  bilinear.c
 *
 *    Description:  Source file for bilinear interpolation
 *
 *        Version:  1.0
 *        Created:  08/31/2014 04:07:25 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#include <math.h>
#include <stdlib.h>

#include "bilinear.h"
#include "debug.h"

typedef struct{
  float x;
  float y;
}point;


/*-----------------------------------------------------------------------------
 *  Function: bilinear_inplace
 *  Parameter:  Image* pImg   - Image on which bilinear interpolation is to be 
 *                              performed
 *              float scale   - The scale to which the image is to interpolated
 *                              valid range is (0,4]
 *  
 *  Return:     integer       - 0 success, -1 otherwise
 *  
 *  Description:
 *    Performs inplace bilinear interpolation on the input image.
 *-----------------------------------------------------------------------------*/
int bilinear_inplace(Image *pImg, float scale)
{
  int ret = BILINEAR_SUCCESS;
  UCHAR *input = pImg->data;                     /* input pixel data */
  UCHAR *output = NULL;                          /* output pixel data */

  int h_new = 0;                                /* new height of the image */
  int w_new = 0;                                /* new width of the image */

  int h_old = pImg->height;
  int w_old = pImg->width;

  float h_map = 0.0;
  float w_map = 0.0;

  point ul_point;
  point br_point;

  int chan, row, col;
  int x,y;

  int channels = pImg->channels;

  int start_x;
  int end_x;
  int start_y;
  int end_y;

  UCHAR *pA, *pB, *pC, *pD;
  float alpha, beta, gamma, omega;
  float val, den;
  float y_den, x_den;

  /*-----------------------------------------------------------------------------
   *  Check the input arguments first
   *-----------------------------------------------------------------------------*/
  if(!pImg){
    DEBUG_PRINT("Input image is NULL!\n");
    ret = BILINEAR_FAILURE;
  }
  if((scale <= 0) || (scale > 4)){
    DEBUG_PRINT("Scale must be in the range (0,4]\n");
  }

  /*-----------------------------------------------------------------------------
   *  Calculate the dimensions of the new image
   *-----------------------------------------------------------------------------*/
  h_new = ceil(h_old * scale);
  w_new = ceil(w_old * scale);

  /*-----------------------------------------------------------------------------
   *  Calculate the pixel mapping multiplier
   *-----------------------------------------------------------------------------*/
  h_map = (float)(h_new-1)/(float)(h_old-1);
  w_map = (float)(w_new-1)/(float)(w_old-1);

  /*-----------------------------------------------------------------------------
   *  Allocate the new image size
   *-----------------------------------------------------------------------------*/
  output = (UCHAR*)malloc(sizeof(UCHAR)*h_new*w_new*pImg->channels);
  if(output == NULL){
    DEBUG_PRINT("Error allocating output buffer\n");
    ret = BILINEAR_FAILURE;
  }
  DEBUG_PRINT("input width = %d\n",pImg->width);
  DEBUG_PRINT("input height = %d\n",pImg->height);
  DEBUG_PRINT("input channels = %d\n",pImg->channels);

  DEBUG_PRINT("output width = %d\n",w_new);
  DEBUG_PRINT("output height = %d\n",h_new);
  DEBUG_PRINT("output channels = %d\n",pImg->channels);
  
  DEBUG_PRINT("w_map = %f\n", w_map);
  DEBUG_PRINT("h_map = %f\n", h_map);
  /*-----------------------------------------------------------------------------
   *  Initialize the window
   *-----------------------------------------------------------------------------*/
  for(chan = 0; chan < pImg->channels; chan++){
    pA = input + chan;
    pB = input + channels + chan;
    pC = input + (w_old*channels) + chan;
    pD = input + channels + (w_old*channels) + chan;
    for(row = 0; row < pImg->height; row++){
      pB += channels;
      pD += channels;
      for(col = 0; col < pImg->width; col++){

        /*-----------------------------------------------------------------------------
         *  Calculate the translation window
         *-----------------------------------------------------------------------------*/
        ul_point.x = col*w_map;
        ul_point.y = row*h_map;
        br_point.x = (col+1)*w_map;
        br_point.y = (row+1)*h_map;
        

        /*-----------------------------------------------------------------------------
         *  Determine the area we are filling in
         *-----------------------------------------------------------------------------*/
        start_x = ceil(ul_point.x);
        start_y = ceil(ul_point.y);
        end_x = floor(br_point.x);
        end_y = floor(br_point.y);

        DEBUG_PRINT("Input Window: %d,%d,%d,%d\n", row,col,row+1,col+1);
        DEBUG_PRINT("Input[%d][%d] = %d\n", row, col, input[row*w_old*channels + col*channels + chan]);
        DEBUG_PRINT("Mapped Window:%.2f,%.2f,%.2f,%.2f\n", ul_point.x, ul_point.y, br_point.x, br_point.y);
        DEBUG_PRINT("Output Window:%d,%d,%d,%d\n", start_x, start_y, end_x, end_y);

        /*-----------------------------------------------------------------------------
         *  Calculate the denominator value for the interpolation
         *-----------------------------------------------------------------------------*/
        y_den = br_point.y - ul_point.y;
        x_den = br_point.x - ul_point.x;
        den = y_den * x_den;

        /*-----------------------------------------------------------------------------
         *  Fill in the output buffer with interpolated values
         *-----------------------------------------------------------------------------*/
        for(y = start_y; y <= end_y; y++){
          for(x = start_x; x <= end_x; x++){
            if(x >= w_new || y >= h_new){
              continue;
            }

            alpha = x - ul_point.x;
            beta = br_point.x - x;
            gamma = y - ul_point.y;
            omega = br_point.y - y;

            val = (gamma*(alpha*(*pD) + beta*(*pC)) + omega*(alpha*(*pB) + beta*(*pA)))/den;
            output[y*w_new*channels + x*channels + chan] = (UCHAR)round(val);
          }
        }
        pA += channels;
        pC += channels;
        if(col == w_old-2){
          pB = pA;
          pD = pC;
        }
        else{
          pB += channels;
          pD += channels;
        }
      }
      if(row == h_old-2){
        pC = pA;
        pD = pB;
      }
    }
  }
  free(input);
  pImg->data = output;
  pImg->width = w_new;
  pImg->height = h_new;
  
  return ret;
}
