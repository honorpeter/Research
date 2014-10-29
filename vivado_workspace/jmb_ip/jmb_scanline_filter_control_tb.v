/*
* File:       jmb_scanline_filter_control_tb.v
* Author:     Jared Bold
* Date:       10.5.14
* Description
*   Testbench for jmb_scanline_filter_control
*/

`include "jmb_scanline_filter_control.v"

module jmb_scanline_filter_control_tb();

reg [7:0] data_in;
reg [31:0] width;
reg [31:0] height;
reg enable;
reg clock;
reg reset_n;

wire [7:0] pixel_out;
wire pixel_wr;
wire pixel_filter;
wire valid;

jmb_scanline_filter_control dut(
  data_in,
  width,
  height,
  enable,
  clock,
  reset_n,
  pixel_out,
  pixel_wr,
  pixel_filter,
  valid
);

always 
  #1 clock = ~clock;

initial begin
  //$display ("data_in\twidth\theight\tenable\tpixel_out\tpixel_wr\tpixel_filter\tpixel_valid");
  //$monitor("%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",data_in, width, height, enable, pixel_out, pixel_wr, pixel_filter, pixel_valid);
  $display ("x_in_cnt\ty_in_cnt");
  $monitor("%d\t%d\t", dut.x_in_counter_r, dut.y_in_counter_r);
end

initial begin
  clock = 0;
  data_in = 0;
  width = 0;
  height = 0;
  enable = 0;
  reset_n = 0;
  #1;
  width = 31'd15;
  height = 31'd10;
  #4;
  reset_n = 1'b1;
  enable = 1'b1;
  #100;
  $finish;
end
endmodule
