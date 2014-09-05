#!/bin/sh
# File: make-kernel.sh
# Author: Jared Bold
# Date:   9.3.2014
# Description
#   Builds linux kernel for zynq zc702

# Commands
MAKE="make"
MAKE_OPTS="-j 8"
ARCH="arm"
CONFIG="xilinx_zynq_defconfig"
MENUCONFIG="menuconfig"


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

if [ ! -e $MKIMAGE ]; then
  echo "$MKIMAGE Not found! Run the u-boot script first"
  exit
fi

cd $KERNEL_DIR

# Configure for zynq device
$MAKE ARCH=$ARCH $CONFIG

# Configure using the menuconfig
$MAKE ARCH=$ARCH $MENUCONFIG

# Produce the kernel image
$MAKE $MAKE_OPTS ARCH=$ARCH UIMAGE_LOADADDR=0x8000 uImage

# Copy uImage file to the output directory
cp $KERNEL_DIR/arch/arm/boot/uImage $OUTPUT_DIR/uImage.bin
cp $KERNEL_DIR/arch/arm/boot/uImage $OUTPUT_DIR/uImage

# Copy the dtc compiler to the output directory
cp $KERNEL_DIR/scripts/dtc/dtc $OUTPUT_DIR/dtc

cd $CUR_DIR
