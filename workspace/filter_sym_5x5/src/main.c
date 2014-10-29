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
#include "filter.h"
#include "image.h"
#include "debug.h"

int main(int argc, char* argv[])
{
  int val = 0;

  char *inFileName = NULL;
  char *outFileName = NULL;

  Image img = IMAGE_INITIALIZER;
  Image outImg = IMAGE_INITIALIZER;
  filter_params fParams;

  Benchmark b1;
  initBenchmark(&b1, "5x5 Symmetric filter", "");

  if(argc != 3){
    fprintf(stderr, "Input and output files must be specified\n");
    return -1;
  }

  inFileName = argv[1];
  outFileName = argv[2];
  DEBUG_PRINT("input: %s\noutput: %s\n", inFileName, outFileName);

  val = ImageRead(inFileName, &img);

  filter_Init(&fParams,0,0,0,0,0,1,2);
  DEBUG_PRINT("Executing Filter\n");
  startBenchmark(&b1);
  val = filter_Execute(&fParams, &img, &outImg);
  stopBenchmark(&b1); 
  DEBUG_PRINT("Filter complete\n");

  if(val != 0){
    fprintf(stderr, "filter_Execute returned %d\n", val);
  }
  printBenchmark(&b1);
  if(val == IMAGE_SUCCESS)
  {
    val = ImageWrite(outFileName, &outImg);
  }

  free(img.data);
  return 0;
}

