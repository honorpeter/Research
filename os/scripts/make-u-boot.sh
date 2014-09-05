#!/bin/sh
# File: make-u-boot.sh
# Author: Jared Bold
# Date 9.3.2014
# Description
#   Builds U-Boot for zynq ZC702

# Commands
MAKE="make"
MAKE_OPTS="-j 8"

# Store the current directory so we can return to it
CUR_DIR=$PWD
OS_DIR="$HOME/Research/os"
UBOOT_DIR="$OS_DIR/xilinx-u-boot"
OUTPUT_DIR="$OS_DIR/output"

# The target u-boot build
TARGET="zynq_zc70x_config"

# Configure the cross-compile environment
export CROSS_COMPILE="arm-xilinx-linux-gnueabi-"
source /opt/Xilinx/SDK/2014.2/settings64.sh

cd $UBOOT_DIR

# Configure the build
$MAKE $TARGET

# Build u-boot
$MAKE $MAKE_OPTS

# Move the u-boot to output directory
mkdir -p $OUTPUT_DIR
mv -f u-boot $OUTPUT_DIR/u-boot.elf

# Symbolically link the mkImage to the output directory
cd tools
cp mkimage $OUTPUT_DIR/mkimage


# return to where we started
cd $CUR_DIR
