#!/bin/sh
# File: make-all.sh
# Author: Jared Bold
# Date:   9.7.2014
# Description
#   Makes all portions of the project

OS_DIR="$HOME/Research/os"
SCRIPT_DIR="$OS_DIR/scripts"

UBOOT_SCRIPT="$SCRIPT_DIR/make-u-boot.sh"
KERNEL_SCRIPT="$SCRIPT_DIR/make-kernel.sh"
ROOTFS_SCRIPT="$SCRIPT_DIR/make-rootfs.sh"
RAMDISK_SCRIPT="$SCRIPT_DIR/make-ramdisk.sh"
DTB_SCRIPT="$SCRIPT_DIR/make-dtb.sh"
BOOT_SCRIPT="$SCRIPT_DIR/make-boot.sh"

# Make U-Boot
echo "Making U-Boot"
$UBOOT_SCRIPT

# Make Kernel
echo "Making kernel"
$KERNEL_SCRIPT

# Make Rootfs
echo "Making rootfs"
$ROOTFS_SCRIPT

# Make Ramdisk
echo "Making ramdisk"
$RAMDISK_SCRIPT

# Make dtb
echo "Making dtb"
$DTB_SCRIPT

# Make boot.bin
echo "Making boot.bin"
$BOOT_SCRIPT

# Make complete
echo "Making Complete"
