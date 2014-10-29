/*
* File:     jmb_scanline_filter.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   A scanline filter.
*
*   -----------------------------
*   |pixel_in         pixel_out |
*   |pixel_wr         valid     |
*   |pixel_filter               |
*   |shift                      |
*   |coeffs                     |
*   |enable                     |
*   -----------------------------
*/
`ifndef _jmb_scanline_filter_
`define _jmb_scanline_filter_

`include "jmb_mul2.v"
`include "jmb_mad2.v"
`include "jmb_dad3.v"

module jmb_scanline_filter(
  enable,
  pixel_in,
  pixel_wr,
  pixel_filter,
  shift,
  co_A,
  co_B,
  co_C,
  clock,
  pixel_out,
  valid
);

// Inputs
input wire enable;
input wire [7:0] pixel_in;
input wire pixel_wr;
input wire pixel_filter;
input wire [7:0] shift;
input wire [7:0] co_A;
input wire [7:0] co_B;
input wire [7:0] co_C;
input wire clock;

// Outputs
output wire [7:0] pixel_out;
output reg valid;

// Internal Registers
reg [7:0] shift_r[4:0];
reg [31:0] pixel_out_r;
integer i;

// Internal wires
wire [15:0] mul2_1_out_w;
wire [15:0] mad2_1_out_w;
wire [15:0] mad2_2_out_w;
wire [15:0] dad3_1_out_w;

// Assigns
assign pixel_out = pixel_out_r;

// Internal Modules
jmb_mul2 mul2_1(shift_r[2], co_A, mul2_1_out_w);
jmb_mad2 mad2_1(shift_r[1], shift_r[3], co_B, mad2_1_out_w);
jmb_mad2 mad2_2(shift_r[0], shift_r[4], co_C, mad2_2_out_w);
jmb_dad3 dad3_1(mul2_1_out_w, mad2_1_out_w, mad2_2_out_w, shift, dad3_1_out_w);

// Shift register circuit
always @(posedge clock) begin
  if(enable == 1'b1) begin
    for(i = 4; i > 0; i = i-1) begin
      shift_r[i-1] <= shift_r[i];
    end
    shift_r[4] <= pixel_in;
  end
  else begin
    shift_r[4] <= shift_r[4];
  end
end

// Pixel_out circuit
always @(posedge clock) begin
  if(enable && pixel_wr && !pixel_filter) begin
    pixel_out_r <= shift_r[2];
  end
  else if(enable && pixel_wr && pixel_filter) begin
    if(dad3_1_out_w[31] == 1'b1) begin      // if negative number round to 0
      pixel_out_r <= 32'h0;
    end
    else if(dad3_1_out_w > 32'hFF) begin
      pixel_out_r <= 32'hFF;
    end
    else begin
      pixel_out_r <= dad3_1_out_w;
    end
  end
  else begin
    pixel_out_r <= pixel_out_r;
  end
end

// Valid circuit
always @(posedge clock) begin
  if(enable && pixel_wr) begin
    valid <= 1'b1;
  end
  else begin 
    valid <= 1'b0;
  end
end

endmodule
`endif
