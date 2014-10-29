#!/bin/sh

OS_DIR="$HOME/Research/os"
LINUX_REPO="$OS_DIR/xilinx-linux"
DEVICE_TREE_REPO="$OS_DIR/xilinx-device-tree"
U_BOOT_REPO="$OS_DIR/xilinx-u-boot"

CUR_DIR=$PWD

cd $LINUX_REPO
git pull

cd $DEVICE_TREE_REPO
git pull

cd $U_BOOT_REPO
git pull

cd $CUR_DIR
