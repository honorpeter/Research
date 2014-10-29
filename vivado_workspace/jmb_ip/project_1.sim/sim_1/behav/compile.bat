@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM;/opt/Xilinx/SDK/2014.2/bin:/opt/Xilinx/Vivado/2014.2/ids_lite/ISE/bin/lin64;/opt/Xilinx/Vivado/2014.2/ids_lite/ISE/lib/lin64;/opt/Xilinx/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=/opt/Xilinx/Vivado/2014.2

xelab -m64 --debug typical --relax --include /home/jared/Research/vivado_workspace/jmb_ip -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot jmb_9x9_filter_tb_behav --prj /home/jared/Research/vivado_workspace/jmb_ip/project_1.sim/sim_1/behav/jmb_9x9_filter_tb.prj   xil_defaultlib.jmb_9x9_filter_tb   xil_defaultlib.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
