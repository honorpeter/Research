#!/bin/sh
# File: make-dtb.sh
# Author: Jared Bold
# Date: 9.3.2014
# Description
#   Compiles the dtb from the dts in output

# Directories
CUR_DIR=$PWD
OS_DIR="$HOME/Research/os"
OUTPUT_DIR="$OS_DIR/output"
DTS=$OUTPUT_DIR/device_tree.dts
DTC=$OUTPUT_DIR/dtc
DTB=$OUTPUT_DIR/devicetree.dtb

if [ ! -e $DTC ]; then
  echo "$DTC Not found! Did you make the kernel yet?"
  exit
fi

$DTC -I dts -O dtb -o $DTB $DTS
