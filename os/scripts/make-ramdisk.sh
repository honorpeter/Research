#!/bin/sh
# File: make-ramdisk.sh
# Author: Jared Bold
# Date:   9.3.2014
# Description
#   Wraps the ramdisk image in u-boot header

# Directories
CUR_DIR=$PWD
OS_DIR="$HOME/Research/os"
RAMDISK_DIR="$OS_DIR/xilinx-ramdisk"
OUTPUT_DIR="$OS_DIR/output"
RAM_IMAGE="arm_ramdisk.image.gz"
URAM_IMAGE="uramdisk.image.gz"

MKIMAGE=$OUTPUT_DIR/mkimage

if [ ! -e $MKIMAGE ]; then
  echo "$MKIMAGE Not found! Run the u-boot script first"
  exit
fi

$MKIMAGE -A arm -T ramdisk -C gzip -d $RAMDISK_DIR/$RAM_IMAGE $OUTPUT_DIR/$URAM_IMAGE
