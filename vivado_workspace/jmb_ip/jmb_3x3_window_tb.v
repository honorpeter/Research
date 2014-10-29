/*
* File:     jmb_3x3_window_tb.v
* Author:   Jared Bold
* Date:     10.5.14
* Description
*   Testbench for jmb_3x3_window
*/

`include "jmb_3x3_window.v"

module jmb_3x3_window_tb();
parameter pixel_width = 8;
parameter image_width = 10;
reg clock;
reg reset_n;
reg [pixel_width-1:0] data;
wire [pixel_width-1:0] w00;
wire [pixel_width-1:0] w01;
wire [pixel_width-1:0] w02;
wire [pixel_width-1:0] w10;
wire [pixel_width-1:0] w11;
wire [pixel_width-1:0] w12;
wire [pixel_width-1:0] w20;
wire [pixel_width-1:0] w21;
wire [pixel_width-1:0] w22;

jmb_3x3_window # (
  pixel_width, 
  image_width,
  100
) dut (
  clock,
  reset_n,
  data,
  w00,
  w01,
  w02,
  w10,
  w11,
  w12,
  w20,
  w21,
  w22
);

always 
  #5 clock = ~clock;

initial begin
  clock = 0;
  reset_n = 0;
  data = 8'h00;
  #15 reset_n = 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  $finish;
end

endmodule
