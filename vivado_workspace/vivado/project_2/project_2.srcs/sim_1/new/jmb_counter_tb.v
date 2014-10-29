`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2014 12:29:24 PM
// Design Name: 
// Module Name: jmb_counter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module jmb_counter_tb();

  wire [31:0]M00_AXIS_tdata;
  wire M00_AXIS_tlast;
  reg  M00_AXIS_tready;
  wire [3:0]M00_AXIS_tstrb;
  wire M00_AXIS_tvalid;
  reg Clk;
  reg  ResetN;

initial begin
  Clk = 0;
  forever #5 Clk = ~Clk;
end

initial begin
  ResetN = 0;
  #100 ResetN = 1;
end

initial begin
  M00_AXIS_tready = 0;
  #200 M00_AXIS_tready = 1;
  #2000 M00_AXIS_tready = 0;
  #200 M00_AXIS_tready = 1;
end
 

design_1_wrapper dut
       (.M00_AXIS_tdata(M00_AXIS_tdata),
        .M00_AXIS_tlast(M00_AXIS_tlast),
        .M00_AXIS_tready(M00_AXIS_tready),
        .M00_AXIS_tstrb(M00_AXIS_tstrb),
        .M00_AXIS_tvalid(M00_AXIS_tvalid),
        .m00_axis_aclk(Clk),
        .m00_axis_aresetn(ResetN));
endmodule
