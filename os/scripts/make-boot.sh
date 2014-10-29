#!/bin/sh
# File: make-boot.sh
# Author: Jared Bold
# Date: 9.7.2014
# Description
#   Builds the boot.bin file

CUR_DIR=$PWD

OS_DIR="$HOME/Research/os"
OUTPUT_DIR="$OS_DIR/output"

BOOT_BIF="boot.bif"
DTB="devicetree.dtb"
UIMAGE_BIN="uImage.bin"
UIMAGE="uImage"
URAM_GZ="uramdisk.image.gz"
BOOT_BIN="boot.bin"

MKIMAGE="mkimage"

cd $OUTPUT_DIR

if [ ! -e $MKIMAGE ]; then
  echo "$MKIMAGE not found. Run make-u-boot.sh"
  exit
elif [ ! -e $DTB ]; then
  echo "$DTB not found. Run make-dtb.sh"
  exit
elif [ ! -e $UIMAGE ]; then
  echo "$UIMAGE not found. Run make-kernel.sh"
  exit
elif [ ! -e $URAM_GZ ]; then
  echo "$URAM_GZ not found. Run make-ramdisk.sh"
  exit
elif [ ! -e $UIMAGE_BIN ]; then
  echo "Creating $UIMAGE_BIN from $UIMAGE"
  cp $UIMAGE $UIMAGE_BIN
fi

bootgen -image $BOOT_BIF -o i $BOOT_BIN -w

cd $CUR_DIR
