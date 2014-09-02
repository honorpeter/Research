/*
 * =====================================================================================
 *
 *       Filename:  bilinear.h
 *
 *    Description:  Header file for bilinear interpolation 
 *
 *        Version:  1.0
 *        Created:  08/31/2014 04:07:13 PM
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

#define BILINEAR_SUCCESS 0
#define BILINEAR_FAILURE -1

int bilinear_inplace(Image* pImg, float scale); /* Performs bilinear interpolation in place */
int bilinear(Image* pInput, Image* pOutput, float scale); /* Performat bilinear interpolation */

#endif // !_BILINEAR_H_
