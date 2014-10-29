#!/bin/sh
# File: clean-kernel.sh
# Author: Jared Bold
# Date:   9.3.2014
# Description
#   Cleans linux kernel for zynq zc702

# Commands
MAKE="make"
CLEAN="clean"

# Directories
CUR_DIR=$PWD
OS_DIR="$HOME/Research/os"
KERNEL_DIR="$OS_DIR/xilinx-linux"
OUTPUT_DIR="$OS_DIR/output"

MKIMAGE=$OUTPUT_DIR/mkimage

# Configure the cross-compile environment
export CROSS_COMPILE="arm-xilinx-linux-gnueabi-"
source /opt/Xilinx/SDK/2014.2/settings64.sh

export PATH=$PATH:$OUTPUT_DIR

cd $KERNEL_DIR

# Configure for zynq device
echo "Cleaning the kernel build"
$MAKE $CLEAN

# Remove uImage file from the output directory
echo "Removing uImage from output director"
rm $OUTPUT_DIR/uImage.bin
rm $OUTPUT_DIR/uImage

# Remove the dtc compiler from the output directory
echo "Removing the device tree compiler from output directory"
rm $OUTPUT_DIR/dtc

cd $CUR_DIR
