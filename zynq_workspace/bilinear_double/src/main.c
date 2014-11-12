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
#include "hardware_bilinear.h"

int user_interface();
void software_bilinear_double(const char*);
void hardware_software_bilinear_double(const char*);
void verify_hardware(const char*);
void software_hardware_exhaustive(const char*);
void hardware_breakdown(const char*);

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
       hardware_software_bilinear_double(input);
       break;
      case 3:
       verify_hardware(input);
       break;
      case 4:
       software_hardware_exhaustive(input);
       break;
      case 5:
       hardware_breakdown(input);
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
  fprintf(stdout, "5) Hardware/Software breakdown\n");
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
  Image iImage = IMAGE_INITIALIZER;
  Image oImage = IMAGE_INITIALIZER;
  Benchmark b;
  int val = 0;

  initBenchmark(&b, "Software Bilinear Intropolation", "");

  ImageRead(input, &iImage);

  startBenchmark(&b);
  val = bilinear_execute(&iImage, &oImage, 2.0);
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
  Image temp = IMAGE_INITIALIZER;
  hardware_config hard_config;
  Benchmark b;
  int val = 0;
  int val2 = 0;

  initBenchmark(&b, "Hardware Software Bilinear Interoplation", "");
  ImageRead(input, &iImage);

  if(hardware_bilinear_init(&iImage, &hard_config) != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Failed to initialize hardware driver\n");
    return;
  }

  startBenchmark(&b);
  val = hardware_bilinear_execute(&iImage, &temp, &hard_config, 1 );
  val2 = bilinear_vert_execute_volatile(&temp, &oImage, 2.0);
  stopBenchmark(&b);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware failed.\n");
  }
  if(val2 != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Software failed.\n");
  }

  val = hardware_bilinear_cleanup(&iImage, &temp, &hard_config);
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

  Image iImage = IMAGE_INITIALIZER;
  Image oImage_software = IMAGE_INITIALIZER;
  Image oImage_hardware = IMAGE_INITIALIZER;
  Image temp = IMAGE_INITIALIZER;

  unsigned char *hImage = NULL;
  unsigned char *sImage = NULL;
  int i = 0;
  int val = 0;
  int val2 = 0;
  int r = 0;
  int c = 0;
  int error = 0;

  /*-----------------------------------------------------------------------------
   *  Read in the input image
   *-----------------------------------------------------------------------------*/
  ImageRead(input, &iImage);

  /*-----------------------------------------------------------------------------
   *  Initialize the hardware platform
   *-----------------------------------------------------------------------------*/
  if(hardware_bilinear_init(&iImage, &hard_config) != 0){
    fprintf(stderr, "verify_hardware: ERROR: Failed to initialize hardware driver\n");
    return;
  }

  /*-----------------------------------------------------------------------------
   *  Perform hardware/software run
   *-----------------------------------------------------------------------------*/
  val = hardware_bilinear_execute(&iImage, &temp,&hard_config,0);
  val2 = bilinear_vert_execute_volatile(&temp, &oImage_hardware, 2.0);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware failed.\n");
  }
  if(val2 != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Software failed.\n");
  }
  /*-----------------------------------------------------------------------------
   *  Cleanup the hardware because we don't need it any more
   *-----------------------------------------------------------------------------*/
  val = hardware_bilinear_cleanup(&iImage, &temp, &hard_config);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware software interpolation failed to clean up.\n");
  }


  /*-----------------------------------------------------------------------------
   *  Perform software run
   *-----------------------------------------------------------------------------*/
  val = bilinear_execute(&iImage, &oImage_software, 2.0);
  if(val != 0){
    fprintf(stderr, "software_bilinear_double: ERROR: Interpolation failed.\n");
  }

  /*-----------------------------------------------------------------------------
   *  Validate the two runs pixel by pixel
   *-----------------------------------------------------------------------------*/
  hImage = oImage_hardware.data;
  sImage = oImage_software.data;
  if(oImage_hardware.width != oImage_software.width){
    fprintf(stderr, "Mismatch: width\n");
    error = 1;
  }
  if(oImage_hardware.height != oImage_software.height){
    fprintf(stderr, "Mismatch: height\n");
    error = 1;
  }
  for(r = 0; r < oImage_software.height; r++){
    for(c = 0; c < oImage_software.width; c++, sImage++, hImage++){
      if(r >= oImage_software.height-1){
        continue;
      }
      if((c >= oImage_software.width-4)){
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

  /*-----------------------------------------------------------------------------
   *  Cleanup
   *-----------------------------------------------------------------------------*/
  DEBUG_PRINT("cleaning up software image\n");
  ImageCleanup(&oImage_software);
  DEBUG_PRINT("cleaning up hardware image\n");
  ImageCleanup(&oImage_hardware);
  DEBUG_PRINT("cleaning up input image\n");
  ImageCleanup(&iImage);

  #else
  fprintf(stderr, "Hardware verification of bilinear interpolation not supported on x86 platform\n");
  #endif


}
void software_hardware_exhaustive(const char *input)
{
  #ifdef ZYNQ
  const int nRuns = 500;
  int i = 0;
  hardware_config hard_config;
  Image iImage = IMAGE_INITIALIZER;
  Image oImage = IMAGE_INITIALIZER;
  Image temp = IMAGE_INITIALIZER;
  int val = 0;
  int val2 = 0;
  volatile int j = 0;
  Benchmark b_software;
  Benchmark b_hardware;

  initBenchmark(&b_software, "Software bilinear interpolation", "");
  initBenchmark(&b_hardware, "Hardware/software bilinear interpolation", "");

  ImageRead(input, &iImage);

  /*-----------------------------------------------------------------------------
   *  Initialize hardware
   *-----------------------------------------------------------------------------*/
  if(hardware_bilinear_init(&iImage, &hard_config) != 0){
    fprintf(stderr, "verify_hardware: ERROR: Failed to initialize hardware driver\n");
    return;
  }

  /*-----------------------------------------------------------------------------
   *  Begin the hardware/software iterations
   *-----------------------------------------------------------------------------*/
  fprintf(stdout, "Runnning hardware %d times\n", nRuns);
  startBenchmark(&b_hardware);
  for(i = 0; i < nRuns; i++){
    DEBUG_PRINT("%d\n", i);
    val = hardware_bilinear_execute(&iImage,&temp,&hard_config,0);
    val2 = bilinear_vert_execute_volatile(&temp, &oImage, 2.0);
  }
  stopBenchmark(&b_hardware);

  /*-----------------------------------------------------------------------------
   *  Cleanup the hardware
   *-----------------------------------------------------------------------------*/
  val = hardware_bilinear_cleanup(&iImage, &oImage, &hard_config);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware software interpolation failed to clean up.\n");
  }

  fprintf(stdout, "Hardware runs complete\n");

  fprintf(stdout, "Runnning software %d times\n", nRuns);

  /*-----------------------------------------------------------------------------
   *  Run the software
   *-----------------------------------------------------------------------------*/
  startBenchmark(&b_software);
  for(i = 0; i < nRuns; i++){
    val = bilinear_execute(&iImage, &oImage, 2.0);
  }
  stopBenchmark(&b_software);
  fprintf(stdout, "Software runs complete\n");

  printBenchmarkAvg(&b_hardware,nRuns);
  printBenchmarkAvg(&b_software,nRuns);
  
  #else
  fprintf(stderr, "Hardware exhaustive run not supported on x86 platform\n");
  #endif


}
void hardware_breakdown(const char *input)
{
  #ifdef ZYNQ
  Image iImage = IMAGE_INITIALIZER;
  Image oImage = IMAGE_INITIALIZER;
  Image temp = IMAGE_INITIALIZER;
  hardware_config hard_config;
  Benchmark b;
  Benchmark b2;
  int val = 0;
  int val2 = 0;
  unsigned char *ptmp = NULL;

  initBenchmark(&b, "hardware", "");
  initBenchmark(&b2, "software", "");
  ImageRead(input, &iImage);

  if(hardware_bilinear_init(&iImage, &hard_config) != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Failed to initialize hardware driver\n");
    return;
  }

  startBenchmark(&b);
  val = hardware_bilinear_execute(&iImage, &temp, &hard_config, 1 );
  ptmp = (unsigned char*)malloc(sizeof(UCHAR)*temp.width*temp.height);
  memcpy(ptmp, temp.data,temp.width*temp.height);
  temp.data = ptmp;
  stopBenchmark(&b);
  startBenchmark(&b2);
  val2 = bilinear_vert_execute_volatile(&temp, &oImage, 2.0);
  stopBenchmark(&b2);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware failed.\n");
  }
  if(val2 != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Software failed.\n");
  }

  val = hardware_bilinear_cleanup(&iImage, &temp, &hard_config);
  if(val != 0){
    fprintf(stderr, "hardware_software_bilinear_double: ERROR: Hardware software interpolation failed to clean up.\n");
  }

  printBenchmark(&b);
  printBenchmark(&b2);
  ImageWrite("hardware_bilinear.tif",&oImage);
  ImageCleanup(&oImage);
  ImageCleanup(&iImage);
  #else
  fprintf(stderr, "Hardware software bilinear not supported on x86 platform\n");
  #endif

}
