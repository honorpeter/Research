#!/bin/sh
# File: clean-dtb.sh
# Author: Jared Bold
# Date: 9.3.2014
# Description
#   Cleans the dtb from the dts in output

# Directories
CUR_DIR=$PWD
OS_DIR="$HOME/Research/os"
OUTPUT_DIR="$OS_DIR/output"
DTS=$OUTPUT_DIR/devicetree.dts
DTC=$OUTPUT_DIR/dtc
DTB=$OUTPUT_DIR/devicetree.dtb

if [ ! -e $DTB ]; then
  echo "$DTB Not found! Cleaning already complete"
  exit
fi

# Delete the dtb file
echo "Removing $DTB"
rm $DTB
