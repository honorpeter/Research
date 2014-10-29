/*
* File:     jmb_3x3_window.v
* Author:   Jared Bold
* Date:     10.5.14
* Description
*   Creates a parameterized 5x5 window based on a streaming pixel input
*/
`ifndef _jmb_3x3_window_
`define _jmb_3x3_window_
`include "jmb_fifo.v"

module jmb_3x3_window #
(
  // Parameters
  parameter integer pixel_width = 8,
  parameter integer image_width = 512
)
(
  // IO
  enable,
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
// Inputs
input wire enable;
input wire clock;
input wire reset_n;
input wire [pixel_width-1:0] data;

// Outputs
output wire [pixel_width-1:0] w00;
output wire [pixel_width-1:0] w01;
output wire [pixel_width-1:0] w02;
output wire [pixel_width-1:0] w10;
output wire [pixel_width-1:0] w11;
output wire [pixel_width-1:0] w12;
output wire [pixel_width-1:0] w20;
output wire [pixel_width-1:0] w21;
output wire [pixel_width-1:0] w22;

// registers
reg [pixel_width-1:0] sl0[0:2];
reg [pixel_width-1:0] sl1[0:2];
reg [pixel_width-1:0] sl2[0:2];

// wires
wire [pixel_width-1:0] fifo0_out_w;
wire [pixel_width-1:0] fifo1_out_w;

// Integers
integer i;

// Assigns
assign w00 = sl0[0];
assign w01 = sl0[1];
assign w02 = sl0[2];
assign w10 = sl1[0];
assign w11 = sl1[1];
assign w12 = sl1[2];
assign w20 = sl2[0];
assign w21 = sl2[1];
assign w22 = sl2[2];

jmb_fifo # (
  pixel_width,
  image_width-3
)fifo0( 
  enable,
  clock,
  reset_n,
  w10,
  fifo0_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-3
)fifo1( 
  enable,
  clock,
  reset_n,
  w20,
  fifo1_out_w
);


// sl0 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 3; i = i+1) begin
      sl0[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 2; i = i+1) begin
      sl0[i] <= sl0[i+1];
    end
    sl0[2] <= fifo0_out_w;
  end
  else begin 
    for(i = 0; i < 3; i = i+1) begin
      sl0[i] <= sl0[i];
    end
  end
end

// sl1 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 3; i = i+1) begin
      sl1[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 2; i = i+1) begin
      sl1[i] <= sl1[i+1];
    end
    sl1[2] <= fifo1_out_w;
  end
  else begin
    for(i = 0; i < 3; i = i+1) begin
      sl1[i] <= sl1[i];
    end
  end
end

// sl2 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 3; i = i+1) begin
      sl2[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 2; i = i+1) begin
      sl2[i] <= sl2[i+1];
    end
    sl2[2] <= data;
  end
  else begin
    for(i = 0; i < 3; i = i+1) begin
      sl2[i] <= sl2[i];
    end
  end
end
endmodule
`endif
