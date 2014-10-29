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
RAM_MOUNT="ram_mnt"
RAM_IMAGE="ramdisk.image"
RAM_GZ="ramdisk.image.gz"
URAM_GZ="uramdisk.image.gz"
URAM_IMAGE="uramdisk.image"

ROOTFS="rootfs.tar"

MKIMAGE=$OUTPUT_DIR/mkimage

if [ ! -e $MKIMAGE ]; then
  echo "$MKIMAGE Not found! Run the u-boot script first"
  exit
fi

cd $RAMDISK_DIR

# Make sure that the rootfs is present 
if [ ! -e $ROOTFS ]; then
  echo "$ROOTFS not found. Run make-rootfs.sh to generate a new root file system"
  exit
fi

# Create the ramdisk image if it does not exist, if it does, then we will over write it
if [ ! -e $RAM_GZ ]; then
  echo "$RAM_GZ not found, creating a new ramdisk image"
  sudo dd if=/dev/zero of=$RAM_IMAGE bs=1M count=32
  sudo mke2fs -F $RAM_IMAGE -L "ramdisk" -b 1024 -m 0
  sudo tune2fs $RAM_IMAGE -i 0
  chmod 777 $RAM_IMAGE
else
  echo "$RAM_GZ found, overwriting the root file system"
  gunzip $RAM_GZ
fi

# Mount the image file
if [ ! -e $RAM_MOUNT ]; then
  echo "Creating mount directory"
  mkdir $RAM_MOUNT
fi
sudo mount -o loop $RAM_IMAGE $RAM_MOUNT

# untar the rootfs to the mounted image
echo "Extracting $ROOTFS to the mounted image"
sudo tar -vxf $ROOTFS -C $RAM_MOUNT

# unmount the image
echo "Unmonting $RAM_MOUNT"
sudo umount $RAM_MOUNT

# gzip the image
echo "gzipping the image to $RAM_GZ"
gzip -9 $RAM_IMAGE

# Mk the image
echo "performing the mkimage command on $RAM_GZ"
$MKIMAGE -A arm -T ramdisk -C gzip -d $RAM_GZ $URAM_GZ

# Copy to the output
echo "Copying $URAM_GZ to the output directory"
cp $URAM_GZ $OUTPUT_DIR/$URAM_GZ

cd $CUR_DIR
