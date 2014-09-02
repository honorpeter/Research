/*
 * =====================================================================================
 *
 *       Filename:  image.h
 *
 *    Description:  Describes an image
 *
 *        Version:  1.0
 *        Created:  08/27/2014 08:57:30 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#ifndef _IMAGE_H_
#define _IMAGE_H_
#include "defs.h"

/*-----------------------------------------------------------------------------
 *  RETURN VALUES
 *-----------------------------------------------------------------------------*/
#define IMAGE_SUCCESS       0
#define IMAGE_FAILURE       -1
#define IMAGE_FILENOTFOUND  -2
#define IMAGE_FILEBUSY      -3

typedef struct{
  UINT height;
  UINT width;
  short channels;
  short bitsPerChannel;
  short config;
  UCHAR *data;
}Image;

extern const Image IMAGE_INITIALIZER;           /* Initializer for image object */

int ImageCleanup(Image* img);                  /* Cleans up an image object */

int ImageRead(char* fileName, Image* img);      /* Reads in a TIFF image */
int ImageWrite(char* fileName, Image* imt);     /* Writes out a TIFF image */

#endif // !_IMAGE_H_
