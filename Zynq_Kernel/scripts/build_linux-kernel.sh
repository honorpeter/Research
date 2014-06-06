#!/bin/bash
# File:     build_linux-kernel.sh
# Author:   Jared Bold
# Date Created:   6/5/2014
# Date Modified:  6/5/2014
#
# Description:
#   Script for building the linux kernel
DEST=/home/jared/Research/Zynq_Kernel/outputs
DEST_FILE=$DEST/uImage.bin
SRC_DIR=/home/jared/Research/Zynq_Kernel/xilinx_linux
IMG_FILE=$SRC_DIR/arch/arm/boot/uImage

MAKE=make
CONFIG=xilinx_zynq_defconfig
ADDR=0x8000
OUTPUT=uImage
ARCH=arm

pushd $SRC_DIR
$MAKE clean

$MAKE ARCH=$ARCH $CONFIG
$MAKE ARCH=$ARCH menuconfig

$MAKE -j 4 ARCH=$ARCH UIMAGE_LOADADDR=$ADDR $OUTPUT

if [ ! -e $IMG_FILE ]; then
  echo "Error generating uImage file, is mkimage in the path?"
  exit
fi

if [ ! -e $DEST ]; then
  echo "Creating destination directory."
  mkdir -p $DEST
  cp $IMG_FILE $DEST_FILE
elif [ -e $DEST_FILE ]; then
  echo "uImage file found in destination directory!"
  echo -n "Overwrite the file (y/n) "
  read SEL

  if [ $SEL == "y" ]; then 
    cp $IMG_FILE $DEST_FILE
  fi
else
  cp $IMG_FILE $DEST_FILE
fi

popd

