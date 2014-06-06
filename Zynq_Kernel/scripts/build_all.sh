#!/bin/bash

./build_fsbl.sh
./build_u-boot.sh
./build_root-fs.sh /home/jared/Research/Zynq_SD_Images/2013.4/uramdisk.image.gz
./build_dtb.sh /home/jared/Research/Zynq_SD_Images/2013.4/zc70x/zc702/devicetree.dtb
./build_linux-kernel.sh
./build_boot-image.sh
