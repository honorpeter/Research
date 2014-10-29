/*
 * =====================================================================================
 *
 *       Filename:  main.c
 *
 *    Description:  This is test program to verify the functionality of the axi_counter
 *                  hardware instantiated in the Zynq PL
 *
 *        Version:  1.0
 *        Created:  09/11/2014 06:38:29 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */

#include <fcntl.h>    // required for open
#include <stdlib.h>
#include <stdio.h>


/*-----------------------------------------------------------------------------
 *  Function: Main
 *
 *-----------------------------------------------------------------------------*/
int main(int argc, char *argv[])
{

  /*-----------------------------------------------------------------------------
   *  Variables
   *-----------------------------------------------------------------------------*/
  int pMemFd = 0;
  volatile uint32_t* dma;
  volatile uint8_t* readData;
  
  /*-----------------------------------------------------------------------------
   *  Initialize the DMA
   *-----------------------------------------------------------------------------*/
  // open /dev/mem
  pMemFd = open("/dev/mem", ,O_RDWR|O_SYNC);
  if(pMemFd == -1){
    fprintf(stderr, "Failed to open /dev/mem\n");
    return -1;
  }



  return(0);
}
