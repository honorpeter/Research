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
  int d;
  int e;
  int f;
  int g;
  int h;
  int i;
  int j;
  int k;
  int l;
  int m;
  int n;
  int o;
  int shift;
  int offset;
}filter_params;

void filter_9x9_Init(filter_params* params,int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k,
                                        int l, int m, int n, int o, int shift, int offset);
int filter_9x9_Execute(filter_params* params, Image* input, Image* output);
void filter_9x9_display(filter_params* params);

#endif // !_FILTER_H_

