/*
 * =====================================================================================
 *
 *       Filename:  filter.h
 *
 *    Description:  Header file for 5x5 Symmmertric filter
 *
 *        Version:  1.0
 *        Created:  09/20/2014 06:24:56 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */

#ifndef _FILTER_H_
#define _FILTER_H_

#include "image.h"

typedef struct{
  int a;
  int b;
  int c;
  int shift;
}filter_params;

void filter_Init(filter_params* params,int a, int b, int c, int shift);
int filter_Execute(filter_params* params, Image* input, Image* output);
void filter_display(filter_params* params);

#endif // !_FILTER_H_

