#!/bin/bash
# File:     build_root-fs.sh
# Author:   Jared Bold
# Date Created: 6/5/2014
# Date Modified: 6/5/2014
#
# Description:
#   Builes the root file system

DEST=/home/jared/Research/Zynq_Kernel/outputs
DEST_FILE=$DEST/uramdisk.image.gz
ARCH=arm
TYPE=ramdisk
COMP=gzip

# Assum that $1 is the path to the original ramdisk image
if [ -z $1 ]; then
  echo "Please specify a path to the unwrappwed ramdisk image file"
  exit
fi

if [ ! -e $1 ]; then
  echo "Image file not found."
  exit
fi

if [ ! -e $DEST ]; then
  echo "Creating destination directory!"
  mkdir -p $DEST
elif [ -e $DEST_FILE ]; then
  echo "Image file found in destination directory!"
  echo -n "Overwrite the file (y/n)? "
  read SEL

  if [ $SEL != "y" ]; then 
    exit
  fi
fi

echo "Image file already wrapped (y/n)? "
read SEL
if [ $SEL != "y" ]; then
  mkimage -A $ARCH -T $TYPE -C $COMP -d $1 $DEST_FILE
else
  cp $1 $DEST_FILE
fi

