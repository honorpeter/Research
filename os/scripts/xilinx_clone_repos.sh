#!/bin/sh
# File: xilinx_clone_repos.sh
# Author: Jared Bold
# Date:   9.3.2014
#
# Description:
#   Clones all of the required xilinx git reposititories for linux 
#   development. This will configure in the directory outside of the 
#   scripts directory.
#   
#   Linux Kernel  - github.com/Xilinx/linux-xlnx.git
#   U-Boot        - github.com/Xilinx/u-boot-xlnx.git
#   device tree   - github.com/Xilinx/device-tree.git

# Git commands
GIT="git"
CLONE="clone"

# OS Directory
OS_DIR="$HOME/Research/os"

# Repository information
XILINX_REPO_BASE="git://github.com/Xilinx"

XILINX_LINUX_REPO="linux-xlnx.git"
XILINX_UBOOT_REPO="u-boot-xlnx.git"
XILINX_DEVICE_TREE_REPO="device-tree.git"

# Local directories
XILINX_LINUX_LOCAL="$OS_DIR/xilinx-linux"
XILINX_UBOOT_LOCAL="$OS_DIR/xilinx-u-boot"
XILINX_DEVTREE_LOCAL="$OS_DIR/xilinx-device-tree"

if [ -e $XILINX_LINUX_LOCAL ]; then
  echo "$XILINX_LINUX_LOCAL already exists. Cannot clone to this directory"
  exit
fi

if [ -e $XILINX_UBOOT_LOCAL ]; then
  echo "$XILINX_UBOOT_LOCAL already exists. Cannot clone to this directory"
  exit
fi

if [ -e $XILINX_DEVTREE_LOCAL ]; then
  echo "$XILINX_DEVTREE_LOCAL already exists. Cannot clone to this directory"
  exit
fi
# Clone Xilinx Linux repo
$GIT $CLONE $XILINX_REPO_BASE/$XILINX_LINUX_REPO $XILINX_LINUX_LOCAL

# Clone Xilinx U-Boot repo
$GIT $CLONE $XILINX_REPO_BASE/$XILINX_UBOOT_REPO $XILINX_UBOOT_LOCAL

# Clone the Xilinx Device-Tree repo
$GIT $CLONE $XILINX_REPO_BASE/$XILINX_DEVICE_TREE_REPO $XILINX_DEVTREE_LOCAL

