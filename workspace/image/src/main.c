/*
 * =====================================================================================
 *
 *       Filename:  main.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  08/27/2014 09:03:38 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */
#include <stdio.h>
#include <stdlib.h>

#include "image.h"
#include "debug.h"

int main(int argc, char* argv[])
{
  int val = 0;

  char *inFileName = NULL;
  char *outFileName = NULL;

  FILE* pInFile = NULL;
  FILE* pOutFile = NULL;

  Image img = IMAGE_INITIALIZER;

  if(argc != 3){
    fprintf(stderr, "Input and output files must be specified\n");
    return -1;
  }

  inFileName = argv[1];
  outFileName = argv[2];
  DEBUG_PRINT("input: %s\noutput: %s\n", inFileName, outFileName);

  val = ImageRead(inFileName, &img);
  
  if(val == IMAGE_SUCCESS)
  {
    val = ImageWrite(outFileName, &img);
  }

  free(img.data);
  return 0;
}

