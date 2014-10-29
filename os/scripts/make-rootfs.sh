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
BUILDROOT_DIR="$OS_DIR/buildroot"
ROOTFS="$BUILDROOT_DIR/output/images/rootfs.tar"

MAKE="make"
MENUCONFIG="menuconfig"

cd $BUILDROOT_DIR

$MAKE clean

$MAKE $MENUCONFIG

$MAKE

cp $ROOTFS $RAMDISK_DIR/

cd $CUR_DIR
