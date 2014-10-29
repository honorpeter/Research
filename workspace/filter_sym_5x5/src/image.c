/*
 * =====================================================================================
 *
 *       Filename:  image.c
 *
 *    Description:  Holds image functions
 *
 *        Version:  1.0
 *        Created:  08/29/2014 12:41:14 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Jared Bold
 *   Organization:  Rochester Institute of Technology
 *
 * =====================================================================================
 */
#include <tiffio.h>
#include <stdlib.h>
#include <stdio.h>

#include "debug.h"
#include "image.h"

const Image IMAGE_INITIALIZER = {.height=0, .width=0, .channels=0, .data=NULL};

/*-----------------------------------------------------------------------------
 *  Function: Image_cleanup
 *  Parameters: Image* img  - The image to be cleaned up
 *
 *  Returns:  int           - See defines in image.h
 *
 *  Description:
 *    Resets values to defaults and deletes any allocated data
 *-----------------------------------------------------------------------------*/
int ImageCleanup(Image *pImg)
{

  int ret = IMAGE_SUCCESS;
  DEBUG_PRINT("ENTERING ImageCleanup\n");
  /*-----------------------------------------------------------------------------
   * If data has been allocated, then delete it 
   *-----------------------------------------------------------------------------*/
  if(pImg->data != NULL){
    DEBUG_PRINT("Deleting the image data\n");
    free(pImg->data);
  }

  /*-----------------------------------------------------------------------------
   *  Reset all variables to init state
   *-----------------------------------------------------------------------------*/
  *pImg = IMAGE_INITIALIZER;

  DEBUG_PRINT("EXITING ImageCleanup\n");
  return ret;
}



/*-----------------------------------------------------------------------------
 *  Function: IMAGE_READ
 *  Parameters: char* fileName  - The name of the image file to read
 *              Image* img      - The image struct to store the image in
 *
 *  Returns:  int               - See defines in image.h
 *
 *  Description:
 *    Reads in the image file stored at fileName and stores the information in 
 *    img.  Returns success if successful, otherwise returns an error code
 *-----------------------------------------------------------------------------*/
int ImageRead(char *fileName, Image *img)
{
  
  /*-----------------------------------------------------------------------------
   *  Varibles
   *-----------------------------------------------------------------------------*/
  int ret = IMAGE_SUCCESS;
  TIFF* pImg = NULL;
  UINT row = 0;

  UINT width = 0;
  UINT height = 0;
  UCHAR* data = NULL; 
  short config = 0;
  short channels = 0;
  short bpc = 0;
  
  DEBUG_PRINT("ENTERING ImageRead\n");
  if(!fileName || !img){
    DEBUG_PRINT("fileName or img is NULL!\n");
    ret = IMAGE_FAILURE;
  }

  /*-----------------------------------------------------------------------------
   *  Open the Tiff file
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    pImg = TIFFOpen(fileName, "r");
    if(pImg == NULL){
      DEBUG_PRINT("File %s not found!\n",fileName);
      ret = IMAGE_FILENOTFOUND;
    }
  }

  /*-----------------------------------------------------------------------------
   *  Read in the tags
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    TIFFGetField(pImg, TIFFTAG_IMAGELENGTH, &height);
    DEBUG_PRINT("height = %u\n", height);
    TIFFGetField(pImg, TIFFTAG_IMAGEWIDTH, &width);
    DEBUG_PRINT("width = %u\n", width);
    TIFFGetField(pImg, TIFFTAG_PLANARCONFIG, &config);
    DEBUG_PRINT("planar config = %d\n", config);
    TIFFGetField(pImg, TIFFTAG_SAMPLESPERPIXEL, &channels);
    DEBUG_PRINT("channels = %d\n", channels);
    TIFFGetField(pImg, TIFFTAG_BITSPERSAMPLE, &bpc);
    DEBUG_PRINT("bits per channel = %d\n", bpc);
  }

  /*-----------------------------------------------------------------------------
   *  Validate that the tags indicate that this is a file we support
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    if( config != PLANARCONFIG_CONTIG ||
        bpc != 8){
      DEBUG_PRINT("Image file not in contiguous configuration\n");
      ret = IMAGE_FAILURE;
    }
  }


  /*-----------------------------------------------------------------------------
   *  Allocate the required space for the image
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    //data = _TIFFmalloc(TIFFScanLineSize(pImg));
    data = malloc(sizeof(UCHAR)*width*height*channels);
    if(data == NULL){
      ret = IMAGE_FAILURE;
      DEBUG_PRINT("Failed to allocate data buffer\n");
    }
  }

  /*-----------------------------------------------------------------------------
   *  Read in the pixel data
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    DEBUG_PRINT("Reading in pixel data\n");
    for(row = 0; row < height; row++){
      if(TIFFReadScanline(pImg, &data[row*width*channels], row,0) < 0){
        break;
      }
    }
    DEBUG_PRINT("Rows Read = %d\n",row);
    DEBUG_PRINT("Completed reading in pixel data\n");
  }


  /*-----------------------------------------------------------------------------
   *  Store the image variables
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    img->height = height;
    img->width = width;
    img->channels = channels;
    img->bitsPerChannel = bpc;
    img->config = config;
    img->data = data;
  }

  /*-----------------------------------------------------------------------------
   *  Close the Tiff file
   *-----------------------------------------------------------------------------*/
  if(pImg != NULL){
    DEBUG_PRINT("Closing the image file\n");
    TIFFClose(pImg);
  }
  DEBUG_PRINT("EXITING ImageRead\n"); 
  return ret;
}


/*-----------------------------------------------------------------------------
 *  Function: ImageWrite
 *  Parameters: char* fileName    - The file to write the image to
 *              Image* img        - Pointer to the image object to be written
 *
 *  Return:     int               - See defines in image.h
 *
 *  Description:
 *    Writes the image stored in the img object to the file listed in fileName.
 *-----------------------------------------------------------------------------*/
int ImageWrite(char *fileName, Image *img)
{
  int ret = IMAGE_SUCCESS;
  int row = 0;
  TIFF *pImg= NULL;

  DEBUG_PRINT("ENTERING ImageWrite\n");

  if(!fileName || !img){
    ret = IMAGE_FAILURE;
    DEBUG_PRINT("fileName or pImg passed in as NULL\n");
  }

  /*-----------------------------------------------------------------------------
   *  Open the output file
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    pImg = TIFFOpen(fileName, "wb");
    if(pImg == NULL){
      DEBUG_PRINT("File %s could not be opened for writing\n", fileName);
      ret = IMAGE_FILEBUSY;
    }
  }


  /*-----------------------------------------------------------------------------
   *  Write the tags
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    TIFFSetField(pImg, TIFFTAG_IMAGELENGTH, img->height);
    DEBUG_PRINT("img->height = %d\n",img->height);
    TIFFSetField(pImg, TIFFTAG_IMAGEWIDTH, img->width);
    DEBUG_PRINT("img->width = %d\n", img->width);
    TIFFSetField(pImg, TIFFTAG_PLANARCONFIG, img->config);
    DEBUG_PRINT("img->config = %d\n", img->config);
    TIFFSetField(pImg, TIFFTAG_SAMPLESPERPIXEL, img->channels);
    DEBUG_PRINT("img->channels = %d\n", img->channels);
    TIFFSetField(pImg, TIFFTAG_BITSPERSAMPLE, img->bitsPerChannel);
    DEBUG_PRINT("img->bitsPerChannel = %d\n", img->bitsPerChannel);
    TIFFSetField(pImg, TIFFTAG_PHOTOMETRIC, 1);
    TIFFSetField(pImg, TIFFTAG_ROWSPERSTRIP, 1);
  }


  /*-----------------------------------------------------------------------------
   *  Write the pixel data
   *-----------------------------------------------------------------------------*/
  if(ret == IMAGE_SUCCESS){
    DEBUG_PRINT("Writing out the pixel data\n");
    for(row = 0; row < img->height; row++){
      if(TIFFWriteScanline(pImg, (void*)&img->data[row*img->width*img->channels], row, 0) < 0){
        break;
      }
    }
  }


  /*-----------------------------------------------------------------------------
   *  Close the output file
   *-----------------------------------------------------------------------------*/
  if(pImg != NULL){
    TIFFClose(pImg);
  }
  return ret;
}
