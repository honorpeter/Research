/*
* File:     jmb_3x3_filter.v
* Author:   Jared Bold
* Date:     10.6.14
* Description
*   3x3 filter implementation
*
*   ---------------------------
*   |valid_in       valid_out |
*   |ready_in       ready_out |
*   |data_in        data_out  |
*   |A                        |
*   |B                        |
*   |C                        |
*   |shift                    |
*   |clock                    |
*   |reset_n                  |
*   ---------------------------
*
*   Filter Kernel:
*   
*   C   B   C
*   B   A   B
*   C   B   C
*/

`ifndef _jmb_3x3_filter_v_
`define _jmb_3x3_filter_v_
`include "jmb_3x3_window.v"
module jmb_3x3_filter #
(
  // Parameters
  parameter integer pixel_width = 8,
  parameter integer image_width = 512,
  parameter integer A = 4;
  parameter integer B = 2;
  parameter integer C = 1;
  parameter integer shift = 3;
)
(
  // IO
  valid_in,
  ready_in,
  clock,
  reset_n,
  data_in,
  valid_out,
  ready_out,
  data_out
);

// Inputs
input wire valid_in;
input wire ready_in;
input wire clock;
input wire reset_n;
input [pixel_width-1:0] data_in;

// Outputs
output wire [pixel_width-1:0] data_out;
output wire valid_out;
output wire ready_out;

// Wires
wire [pixel_width-1:0] w00;
wire [pixel_width-1:0] w01;
wire [pixel_width-1:0] w02;
wire [pixel_width-1:0] w10;
wire [pixel_width-1:0] w11;
wire [pixel_width-1:0] w12;
wire [pixel_width-1:0] w20;
wire [pixel_width-1:0] w21;
wire [pixel_width-1:0] w22;
wire enable;

// Registers
reg [pixel_width-1:0] data_out_r;
reg valid_out_r;
reg ready_out_r;
reg [31:0] sum_1;
reg [31:0] sum_2;
reg [31:0] sum_3;
reg [31:0] sum_4;

// Assigns
assign data_out = data_out_r;
assign valid_out = valid_out_r;
assign ready_out = ready_out_r;
assign enable = ready_in & valid_in;

// internal modules
jmb_3x3_window #(
  pixel_width,
  image_width
) window (
  enable,
  clock,
  reset_n,
  data_in,
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

// valid_out circuit
always @(posedge clock) begin
  if(!reset_n) begin
    valid_out_r <= 0;
  end
  else begin
    valid_out_r <= valid_in;
  end
end

// ready_out circuit
always @(posedge clock) begin
  if(!reset_n) begin
    ready_out_r <= 0;
  end
  else begin
    ready_out_r <= ready_in;
  end
end

// Filter circuit
always @(posedge clock) begin
  if(!reset_n) begin
    data_out_r <= 0;
  end
  else if(valid_in && ready_in) begin
    sum_1 = A * w11;
    sum_2 = B * (w01+w10+w12+w21);  
    sum_3 = C * (w00+w02+w20+w22);
    sum_4 = (sum_1+sum_2+sum_3) >>> shift;
    data_out_r = sum_4[7:0];
  end
  else begin
    data_out_r <= data_out_r;
  end
end
endmodule

`endif
