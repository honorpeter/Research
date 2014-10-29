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
#include "bilinear_double.h"
#include "image.h"
#include "debug.h"
#include "hardware_bilinear_horz_double.h"

int user_interface();
void software_bilinear_double(const char*);
void hardware_software_bilinear_double(const char*);
void verify_hardware(const char*);
void software_hardware_exhaustive(const char*);

int main(int argc, char* argv[])
{
  int ui_choice = 0;
  int exit = 0;
  char *input;

  if(argc != 2){
    fprintf(stderr, "Must specify the input image\n");
    return -1;
  }
  input = argv[1];

  while(!exit){
    ui_choice = user_interface();

    switch(ui_choice){
      case 0:
        exit = 1;
        break;
      case 1: 
       software_bilinear_double(input); 
       break;
      case 2:
       hardware_sofware_bilinear_double(input);
       break;
      case 3:
       verify_hardware(input);
       break;
      case 4:
       software_hardware_exhaustive(input);
       break;
      default:
       exit = 1;
    }
  }
  return 0;
}

int user_interface(void){
  int ret = 0;
  int val = 0;
  fprintf(stdout, "\nBilinear Interpolation - scale by 2\n");
  fprintf(stdout, "1) Run C version\n");
  fprintf(stdout, "2) Run Hardware/Software version\n");
  fprintf(stdout, "3) Verify Hardware\n");
  fprintf(stdout, "4) Run each 500 times\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "0) Exit\n");
  fprintf(stdout, ": ");

  val = scanf("%d", &ret);
  if(val != 1){
    ret = -1;
  }
  fprintf(stdout, "\n");
  return ret;
}

void software_bilinear_double(const char *input)
{
  filter_params filter;
  Image iImage = IMAGE_INITIALIZER;
  Image oImage = IMAGE_INITIALIZER;
  Benchmark b;
  int val = 0;

  initBenchmark(&b, "Software Bilinear Intropolation", "");

  filter_Init(&filter, 4, 2, 1, 4);
  ImageRead(input, &iImage);

  startBenchmark(&b);
  val = bilinear_double_Execute(&iImage, &oImage);
  stopBenchmark(&b);

  if(val != 0){
    fprintf(stderr, "software_bilinear_double: ERROR: Interpolation failed.\n");
  }

  printBenchmark(&b);
  ImageWrite("software_bilinear.tif",&oImage);
  ImageCleanup(&oImage);
  ImageCleanup(&iImage);
}
void hardware_software_bilinear_double(const char *input)
{
  #ifdef ZYNQ
  Image iImage = IMAGE_INITIALIZER;
  Image oImage = IMAGE_INITIALIZER;
  hardware_config hard_config;
  Benchmark b;
  int val = 0;

  initBenchmark(&b, "Hardware Software Bilinear Interoplation", "");
  ImageRead(input, &iImage);
  if(hardware_bilinear_horz_double_init(&iImage, &hard_config) != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Failed to initialize hardware driver\n");
    return;
  }

  startBenchmark(&b);
  val = hardware_bilinear_horz_double_execute(&hard_config);
  stopBenchmark(&b);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Filter failed.\n");
  }

  val = hardware_bilinear_horz_double_cleanup(&iImage, &oImage, &hard_config);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware software interpolation failed to clean up.\n");
  }

  printBenchmark(&b);
  ImageWrite("hardware_bilinear.tif",&oImage);
  ImageCleanup(&oImage);
  ImageCleanup(&iImage);
  #else
  fprintf(stderr, "Hardware software bilinear not supported on x86 platform\n");
  #endif

}
void verify_hardware(const char *input)
{
  #ifdef ZYNQ
  hardware_config hard_config;
  filter_params filter;
  Image iImage = IMAGE_INITIALIZER;
  Image oImage_software = IMAGE_INITIALIZER;
  Image oImage_hardware = IMAGE_INITIALIZER;
  unsigned char *hImage = NULL;
  unsigned char *sImage = NULL;
  int i = 0;
  int val = 0;
  int r = 0;
  int c = 0;
  int error = 0;

  ImageRead(input, &iImage);

  filter_Init(&filter, 4, 2, 1, 4);
  if(hardware_filter_init(&iImage, &hard_config) != 0){
    fprintf(stderr, "hardware_3x3_filter: ERROR: Failed to initialize hardware driver\n");
    return;
  }

  val = hardware_filter_execute(&hard_config);
  if(val != 0){
    fprintf(stderr, "hardwaree_3x3_filter: ERROR: Filter failed.\n");
  }
  val = hardware_filter_cleanup(&iImage, &oImage_hardware, &hard_config);

  val = filter_Execute(&filter, &iImage, &oImage_software);
  if(val != 0){
    fprintf(stderr, "software_3x3_filter: ERROR: Filter failed.\n");
  }

  hImage = oImage_hardware.data;
  sImage = oImage_software.data;
  for(r = 0; r < oImage_software.height; r++){
    for(c = 0; c < oImage_software.width; c++, sImage++, hImage++){
      if((r <= 2) || (r >= oImage_software.height-3)){
        continue;
      }
      if((c <= 2) || (c >= oImage_software.width-3)){
        continue;
      }
      if(*(hImage) != *(sImage)){
        fprintf(stderr, "Mismatch: Row %d, Col %d, %d != %d\n", r, c, *sImage, *hImage);
        error = 1;
      }
    }
  }
  if(!error){
    fprintf(stdout, "Images verified correct!\n");
  }

  ImageCleanup(&oImage_software);
  ImageCleanup(&oImage_hardware);
  ImageCleanup(&iImage);

  #else
  fprintf(stderr, "Hardware verification of 3x3 filter not supported on x86 platform\n");
  #endif


}
void software_hardware_exhaustive(const char *input)
{
  #ifdef ZYNQ
  const int nRuns = 500;
  int i = 0;
  hardware_config hard_config;
  filter_params filter;
  Image iImage = IMAGE_INITIALIZER;
  Image oImage = IMAGE_INITIALIZER;
  int val = 0;
  volatile int j = 0;
  Benchmark b_software;
  Benchmark b_hardware;

  initBenchmark(&b_software, "Software 3x3 filter", "");
  initBenchmark(&b_hardware, "Hardware 3x3 filter", "");

  ImageRead(input, &iImage);

  filter_Init(&filter, 4, 2, 1, 4);

  val = hardware_filter_init(&iImage, &hard_config);
  fprintf(stdout, "Running hardware %d times\n", nRuns);
  startBenchmark(&b_hardware);
  for(i = 0; i < nRuns; i++){
    val = hardware_filter_execute(&hard_config);
  }
  stopBenchmark(&b_hardware);
  val = hardware_filter_cleanup(&iImage, &oImage, &hard_config);
  fprintf(stdout, "Hardware runs complete\n");
  fprintf(stdout, "Runnning software %d times\n", nRuns);
  for(i = 0; i < nRuns; i++){
    val = filter_Execute(&filter, &iImage, &oImage);
  }
  stopBenchmark(&b_software);
  fprintf(stdout, "Software runs complete\n");

  printBenchmarkAvg(&b_hardware,nRuns);
  printBenchmarkAvg(&b_software,nRuns);
  
  #else
  fprintf(stderr, "Hardware exhaustive run not supported on x86 platform\n");
  #endif


}