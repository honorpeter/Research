#!/bin/sh
# File: clean-ramdisk.sh
# Author: Jared Bold
# Date:   9.3.2014
# Description
#   Cleans the ramdisk creation process

# Directories
OS_DIR="$HOME/Research/os"
RAMDISK_DIR="$OS_DIR/xilinx-ramdisk"
OUTPUT_DIR="$OS_DIR/output"
RAM_MOUNT="ram_mnt"
RAM_GZ="ramdisk.image.gz"
URAM_GZ="uramdisk.image.gz"



# remove the uram gz
echo "Removing $OUTPUT_DIR/$URAM_GZ"
rm -f $OUTPUT_DIR/$URAM_GZ

# remove everything in RAMDISK dir except the rootfs.tar
echo "Cleaning $RAMDISK_DIR"
rm -rf $RAMDISK_DIR/$RAM_MOUNT
rm -rf $RAMDISK_DIR/$RAM_GZ
rm -rf $RAMDISK_DIR/$URAM_GZ
