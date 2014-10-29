//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.2 (lin64) Build 932637 Wed Jun 11 13:08:52 MDT 2014
//Date        : Wed Sep 10 18:29:11 2014
//Host        : jared-Lenovo running 64-bit Ubuntu 14.04.1 LTS
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0}" *) 
module design_1
   (M00_AXIS_tdata,
    M00_AXIS_tlast,
    M00_AXIS_tready,
    M00_AXIS_tstrb,
    M00_AXIS_tvalid,
    m00_axis_aclk,
    m00_axis_aresetn);
  output [31:0]M00_AXIS_tdata;
  output M00_AXIS_tlast;
  input M00_AXIS_tready;
  output [3:0]M00_AXIS_tstrb;
  output M00_AXIS_tvalid;
  input m00_axis_aclk;
  input m00_axis_aresetn;

  wire [31:0]jmb_axi_counter_0_M00_AXIS_TDATA;
  wire jmb_axi_counter_0_M00_AXIS_TLAST;
  wire jmb_axi_counter_0_M00_AXIS_TREADY;
  wire [3:0]jmb_axi_counter_0_M00_AXIS_TSTRB;
  wire jmb_axi_counter_0_M00_AXIS_TVALID;
  wire m00_axis_aclk_1;
  wire m00_axis_aresetn_1;

  assign M00_AXIS_tdata[31:0] = jmb_axi_counter_0_M00_AXIS_TDATA;
  assign M00_AXIS_tlast = jmb_axi_counter_0_M00_AXIS_TLAST;
  assign M00_AXIS_tstrb[3:0] = jmb_axi_counter_0_M00_AXIS_TSTRB;
  assign M00_AXIS_tvalid = jmb_axi_counter_0_M00_AXIS_TVALID;
  assign jmb_axi_counter_0_M00_AXIS_TREADY = M00_AXIS_tready;
  assign m00_axis_aclk_1 = m00_axis_aclk;
  assign m00_axis_aresetn_1 = m00_axis_aresetn;
design_1_jmb_axi_counter_0_0 jmb_axi_counter_0
       (.m00_axis_aclk(m00_axis_aclk_1),
        .m00_axis_aresetn(m00_axis_aresetn_1),
        .m00_axis_tdata(jmb_axi_counter_0_M00_AXIS_TDATA),
        .m00_axis_tlast(jmb_axi_counter_0_M00_AXIS_TLAST),
        .m00_axis_tready(jmb_axi_counter_0_M00_AXIS_TREADY),
        .m00_axis_tstrb(jmb_axi_counter_0_M00_AXIS_TSTRB),
        .m00_axis_tvalid(jmb_axi_counter_0_M00_AXIS_TVALID));
endmodule
