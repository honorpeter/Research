#!/bin/sh
# File: make-clean.sh
# Author: Jared Bold
# Date:   9.7.2014
# Description
#   Cleans up the build processes and outputs

OS_DIR="$HOME/Research/os"
SCRIPT_DIR="$OS_DIR/scripts"

UBOOT_SCRIPT="$SCRIPT_DIR/clean-u-boot.sh"
KERNEL_SCRIPT="$SCRIPT_DIR/clean-kernel.sh"
RAMDISK_SCRIPT="$SCRIPT_DIR/clean-ramdisk.sh"
DTB_SCRIPT="$SCRIPT_DIR/clean-dtb.sh"
BOOT_SCRIPT="$SCRIPT_DIR/clean-boot.sh"

# Clean U-Boot
echo "Cleaning U-Boot"
$UBOOT_SCRIPT

# Clean Kernel
echo "Cleaning kernel"
$KERNEL_SCRIPT

# Clean Ramdisk
echo "Cleaning ramdisk"
$RAMDISK_SCRIPT

# Clean dtb
echo "Cleaning dtb"
$DTB_SCRIPT

# Clean boot
echo "Cleaning boot"
$BOOT_SCRIPT
# Cleaning complete
echo "Cleaning Complete"
