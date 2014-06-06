#!/bin/bash
# File:     build_dtb.sh
# Author:   Jared Bold
# Date Created:   6/5/2014
# Date Modified:  6/5/2014
#
# Description:
#   Script to compile the device tree

# For now we are just copying the file to the directory
# this will have to be modified once we actually start
# doing something productive
DEST=/home/jared/Research/Zynq_Kernel/outputs
DTB_FILE="devicetree.dtb"
KERNEL_DIR=/home/jared/Research/Zynq_Kernel/xilinx_linux
DTB_DIR=$KERNEL_DIR/arch/arm/boot/dts
ORIG_FILE=zynq-zc702.dtb
echo "Building Device Tree"
pushd $KERNEL_DIR

make ARCH=arm zynq-zc702.dtb
cd $DTB_DIR

if [ ! -e $DEST ]; then
  echo "Creating destination directory"
  mkdir -p $DEST
  cp $ORIG_FILE $DEST/$DTB_FILE
elif [ -e "$DEST/$DTB_FILE" ]; then
  echo ".dtb file found in destination directory!"
  echo -n "Overwrite the file (y/n)? "
  read SEL

  if [ $SEL == "y" ]; then 
    cp $ORIG_FILE $DEST/$DTB_FILE
  fi
else
  cp $ORIG_FILE $DEST/$DTB_FILE
fi
popd
