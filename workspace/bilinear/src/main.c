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

#include "benchmark.h"
#include "bilinear.h"
#include "image.h"
#include "debug.h"

int main(int argc, char* argv[])
{
  int val = 0;

  char *inFileName = NULL;
  char *outFileName = NULL;

  float scale = 0.0;
  Image img = IMAGE_INITIALIZER;

  Benchmark b1;
  initBenchmark(&b1, "Bilinear Interpolation", "");

  if(argc != 4){
    fprintf(stderr, "Input and output files must be specified\n");
    return -1;
  }

  inFileName = argv[1];
  outFileName = argv[2];
  DEBUG_PRINT("input: %s\noutput: %s\n", inFileName, outFileName);

  scale = atof(argv[3]);
  val = ImageRead(inFileName, &img);

  startBenchmark(&b1);
  bilinear_inplace(&img, scale);
  stopBenchmark(&b1); 

  printBenchmark(&b1);
  if(val == IMAGE_SUCCESS)
  {
    val = ImageWrite(outFileName, &img);
  }

  free(img.data);
  return 0;
}

