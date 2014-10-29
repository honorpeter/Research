#############################################################33j
# File:	axi_3x3_filter.tcl
# Author:	Jared Bold
# Date:		10.8.14
#
#################################################################
####################Project Setup################################
#################################################################
create_project project_1 . -part xc7z020clg484-1
set_property board_part xilinx.com:zc702:part0:1.0 [current_project]
set_property ip_repo_paths  /home/jared/Research/vivado_workspace/ip [current_fileset]
update_ip_catalog

#################################################################
#####################Blocks######################################
#################################################################
# Create block diagram
create_bd_design "design_1"

# Add Zynq
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.4 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0}] [get_bd_cells processing_system7_0]

# Add Axi DMA
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
set_property -dict [list CONFIG.c_m_axi_s2mm_data_width.VALUE_SRC USER] [get_bd_cells axi_dma_0]
set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_length_width {23} CONFIG.c_m_axi_mm2s_data_width {64} CONFIG.c_m_axis_mm2s_tdata_width {64} CONFIG.c_mm2s_burst_size {16} CONFIG.c_m_axi_s2mm_data_width {64}] [get_bd_cells axi_dma_0]
set_property -dict [list CONFIG.c_m_axi_s2mm_data_width.VALUE_SRC PROPAGATED] [get_bd_cells axi_dma_0]
set_property -dict [list CONFIG.c_m_axi_mm2s_data_width {32}] [get_bd_cells axi_dma_0]

# Add Data width Converters
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0
create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_1
set_property -dict [list CONFIG.M_TDATA_NUM_BYTES {1}] [get_bd_cells axis_dwidth_converter_0]
set_property -dict [list CONFIG.M_TDATA_NUM_BYTES {4}] [get_bd_cells axis_dwidth_converter_1]


# Add filter
create_bd_cell -type ip -vlnv RIT:user:jmb_axi_filter_3x3:1.0 jmb_axi_filter_3x3_0

# Add constant for tstrb
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0



#################################################################
######################Nets#######################################
#################################################################
# Connect AXI DMA to Zynq
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_dma_0/M_AXI_S2MM" Clk "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Slave "/processing_system7_0/S_AXI_HP0" Clk "Auto" }  [get_bd_intf_pins axi_dma_0/M_AXI_MM2S]

# Connect streaming path
connect_bd_intf_net [get_bd_intf_pins axis_dwidth_converter_0/S_AXIS] [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S]
connect_bd_intf_net [get_bd_intf_pins axis_dwidth_converter_0/M_AXIS] [get_bd_intf_pins jmb_axi_filter_3x3_0/S00_AXIS]
connect_bd_intf_net [get_bd_intf_pins jmb_axi_filter_3x3_0/M00_AXIS] [get_bd_intf_pins axis_dwidth_converter_1/S_AXIS]
connect_bd_intf_net [get_bd_intf_pins axis_dwidth_converter_1/M_AXIS] [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM]

# Connect Clocks
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins jmb_axi_filter_3x3_0/m00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins jmb_axi_filter_3x3_0/s00_axis_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins axis_dwidth_converter_0/aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net -net [get_bd_nets processing_system7_0_FCLK_CLK0] [get_bd_pins axis_dwidth_converter_1/aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]

# Connect Resets
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins jmb_axi_filter_3x3_0/m00_axis_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins axis_dwidth_converter_0/aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins axis_dwidth_converter_1/aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]

# Connect odds and ends
connect_bd_net -net [get_bd_nets rst_processing_system7_0_50M_peripheral_aresetn] [get_bd_pins jmb_axi_filter_3x3_0/s00_axis_aresetn] [get_bd_pins rst_processing_system7_0_50M/peripheral_aresetn]
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins jmb_axi_filter_3x3_0/s00_axis_tstrb]

#################################################################
###################Validate######################################
#################################################################
validate_bd_design


