# File: axi_counter_ps_pl.tcl
# Author: Jared Bold
# Date:   9.10.2014
# Description:
#   TCL script for creating axi counter integrated with Zynq PS
#

################################################################
#####################Commands###################################
################################################################

# Create the project for Zynq ZC702
create_project project_1 . -part xc7z020clg484-1
set_property board_part xilinx.com:zc702:part0:1.0 [current_project]

# Add the ip repository to the project
set_property ip_repo_paths  /home/jared/Research/vivado_workspace/ip [current_fileset]
update_ip_catalog

# Create a new block diagram
create_bd_design "design_1"

# Add jmb_axi_counter
startgroup
create_bd_cell -type ip -vlnv RIT:user:jmb_axi_counter:1.0 jmb_axi_counter_0
endgroup

# AXI DMA
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
endgroup

# Configure AXI DMA for write only and NOT SG
startgroup
set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_include_mm2s {0}] [get_bd_cells axi_dma_0]
endgroup

# Add Zynq PS
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.4 processing_system7_0
endgroup

# Apply block automation to Zynq PS
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

# Enable HP0 and disable Timer0 for Zynq PS
startgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0}] [get_bd_cells processing_system7_0]
endgroup

# Enable interrupts on Zynq PS
startgroup
set_property -dict [list CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1}] [get_bd_cells processing_system7_0]
endgroup

# Add Contant 1 block and configure it to be 4 wide
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
endgroup
set_property -dict [list CONFIG.CONST_WIDTH {4}] [get_bd_cells xlconstant_0]


################################################################
######################Connections###############################
################################################################

# Interupt axi_counter -> Zynq PS
connect_bd_net [get_bd_pins axi_dma_0/s2mm_introut] [get_bd_pins processing_system7_0/IRQ_F2P]

# AXIS Master from axi_counter to axi_dma S2MM
connect_bd_intf_net [get_bd_intf_pins jmb_axi_counter_0/M00_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]

# Connect the Constant 1 block to TKEEP on AXI_DMA
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins axi_dma_0/s_axis_s2mm_tkeep]

# Run connection automation for the AXI_DMA slave light port
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]

# Run connection automation for the AXI_DMA master to the Zynq PS HP0
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_dma_0/M_AXI_S2MM" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]

# Connect the counter clock and reset to PS Reset connections
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins jmb_axi_counter_0/m00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins jmb_axi_counter_0/m00_axis_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]

