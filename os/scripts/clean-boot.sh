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
rm $BOOT_BIN
cd $CUR_DIR
