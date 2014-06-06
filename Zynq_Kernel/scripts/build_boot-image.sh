#!/bin/bash
# File:     build_boot-image.sh
# Author:   Jared Bold
# Date Created:   6/5/2014
# Date Modified:  6/5/2014
#
# Description:
#   Builds the boot.bin file
DEST=/home/jared/Research/Zynq_Kernel/outputs
BIF_FILE=boot.bif
BIN_FILE=boot.bin
OUTPUT_DIR=image

FSBL=fsbl.elf
UBOOT=u-boot.elf
DTB=devicetree.dtb
RAMDISK=uramdisk.image.gz
UIMAGE_BIN=uImage.bin

pushd $DEST
echo "Generating .bif file."
echo " image : {
[bootloader]$FSBL
$UBOOT
[load=0x2a00000]$DTB
[load=0x2000000]$RAMDISK
[load=0x3000000]$UIMAGE_BIN
} " > $BIF_FILE

echo "Generating boot.bin"
bootgen -image $BIF_FILE -o i $BIN_FILE

OUTPUT_DIR=${OUTPUT_DIR}_`date +"%d.%m.%y_%H%M%S"`
mkdir $OUTPUT_DIR

echo "Moving files to $OUTPUT_DIR"
mv $FSBL $OUTPUT_DIR
mv $UBOOT $OUTPUT_DIR
mv $DTB $OUTPUT_DIR
mv $RAMDISK $OUTPUT_DIR
mv $UIMAGE_BIN $OUTPUT_DIR
mv $UIMAGE_BIN $OUTPUT_DIR/uImage
mv $BIN_FILE $OUTPUT_DIR
mv $BIF_FILE $OUTPUT_DIR

popd
