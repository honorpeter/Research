#!/bin/bash
# File:     build_u-boot.sh
# Author:   Jared Bold
# Date Created:   6/5/2014
# Date Modified:  6/5/2014
#
# Description:
#   Script for building the u-boot loader for zynq ZC702 board

DEST=/home/jared/Research/Zynq_Kernel/outputs
UBOOT_FILE="u-boot.elf"
SRC_DIR=/home/jared/Research/Zynq_Kernel/xilinx_u-boot
TARGET="zynq_zc70x"
FILE_ORIG="u-boot"

pushd $SRC_DIR
make $TARGET

if [ ! -e $DEST ]; then
  echo "Creating destination directory."
  mkdir -p $DEST
  cp $FILE_ORIG $DEST/$UBOOT_FILE
elif [ -e "$DEST/$UBOOT_FILE" ]; then
  echo "u-boot file found in destination directory!"
  echo -n "Overwrite the file (y/n)? "
  read SEL

  if [ $SEL == "y" ]; then
    cp $FILE_ORIG $DEST/$UBOOT_FILE
  fi
else
  cp $FILE_ORIG $DEST/$UBOOT_FILE
fi
  
cd tools
export PATH=`pwd`:$PATH

popd
