/*
 * =====================================================================================
 *
 *       Filename:  debug.h
 *
 *    Description:  Debug header
 *
 *        Version:  1.0
 *        Created:  08/29/2014 01:09:27 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#ifndef _DEBUG_H_
#define _DEBUG_H_
#include <stdio.h>

#ifdef DEBUG
  #define DEBUG_TEST 1
#else
  #define DEBUG_TEST 0
#endif

#define DEBUG_PRINT(fmt, ...) do{ if(DEBUG_TEST) fprintf(stderr, "%s:%d:%s(): " fmt, __FILE__, \
                                __LINE__, __func__, ##__VA_ARGS__); } while (0)


#endif // !_DEBUG_H_
