#!/bin/bash
# File:     build_fsbl.sh
# Author:   Jared Bold
# Date Created:   6/5/2014
# Date Modified:  6/5/2014
#
# Description:
#   Script for building the First Stage Boot Loader for Zynq
DEST=/home/jared/Research/Zynq_Kernel/outputs
FSBL_FILE="fsbl.elf"

echo "The FSBL is created using the SDK."
echo -n "Would you like to launch the SDK now(y/n)? "
read SEL

if [ $SEL == "y" ]; then
  echo "Launching Xilinx SDK"
  echo "When done, script will continue"
  ( xsdk )
fi

echo -n "Path to FSBL.elf: "
read FSBL_PATH

if [ ! -e $FSBL_PATH ]; then
  echo "Invalid path! $FSBL_PATH could not be found"
  exit
fi

if [ ! -e $DEST ]; then 
  echo "Creating destination directory."
  mkdir -p $DEST
  cp $FSBL_PATH $DEST/$FSBL_FILE
elif [ -e "$DEST/$FSBL_FILE" ]; then
  echo "FSBL File found in destination directory!"
  echo -n "Overwrite the file (y/n)? "
  read SEL

  if [ $SEL == "y" ]; then
    cp $FSBL_PATH $DEST/$FSBL_FILE
  fi
else
    cp $FSBL_PATH $DEST/$FSBL_FILE
fi


