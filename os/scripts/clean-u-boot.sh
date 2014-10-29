#!/bin/sh
# File: make-u-boot.sh
# Author: Jared Bold
# Date 9.3.2014
# Description
#   Builds U-Boot for zynq ZC702

# Commands
MAKE="make"
CLEAN="clean"

# Store the current directory so we can return to it
CUR_DIR=$PWD
OS_DIR="$HOME/Research/os"
UBOOT_DIR="$OS_DIR/xilinx-u-boot"
OUTPUT_DIR="$OS_DIR/output"

cd $UBOOT_DIR

# Clean the build
echo "Cleaning u-boot"
$MAKE $CLEAN

# reMove the u-boot to output directory
echo "Remvoving u-boot.elf from output directory"
rm -f $OUTPUT_DIR/u-boot.elf

# Remove the mkImage to the output directory
echo "Removing mkimage from the output directory"
rm -f $OUTPUT_DIR/mkimage

# return to where we started
cd $CUR_DIR
