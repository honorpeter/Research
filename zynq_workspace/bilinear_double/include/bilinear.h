/*
 * =====================================================================================
 *
 *       Filename:  bilinear.h
 *
 *    Description:  Bilinear interpolation header file
 *
 *        Version:  1.0
 *        Created:  11/02/2014 01:15:29 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold  
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#ifndef _BILINEAR_H_
#define _BILINEAR_H_
#include "image.h"

int bilinear_horz_execute(Image *pIn, Image *pOut, float scale);
int bilinear_vert_execute(Image *pIn, Image *pOut, float scale);
int bilinear_vert_execute_volatile(Image *pIn, Image *pOut, float scale);
int bilinear_execute(Image *pIn, Image *pOut, float scale);

#endif // !_BILINEAR_H_

