/*
* File:     jmb_scanline_filter_control.v
* Author:   Jared Bold
* Date:     10.5.14
* Description:
*   Scanline filter control unit
*
*   ---------------------------------
*   |data_in          pixel_out     |
*   |width            pixel_wr      |
*   |height           pixel_filter  |
*   |clock                          |
*   |enable           valid         |
*   ---------------------------------
*/

`ifndef _jmb_scanline_filter_control_
`define _jmb_scanline_filter_control_

module jmb_scanline_filter_control(
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

// Inputs
input wire [7:0] data_in;
input wire [31:0] width;
input wire [31:0] height;
input wire enable;
input wire clock;
input wire reset_n;

// Outputs
output wire [7:0] pixel_out;
output wire pixel_wr;
output wire pixel_filter;
output wire valid;

// Internal registers
reg [7:0] data_in_r;
reg [31:0] width_r;
reg [31:0] height_r;
reg [7:0] pixel_out_r;
reg pixel_wr_r;
reg pixel_filter_r;
reg valid_r;
reg [31:0] x_in_counter_r;
reg [31:0] y_in_counter_r;
reg [31:0] x_out_counter_r;
reg [31:0] y_out_counter_r;
reg [2:0] x_in_state;
reg [2:0] y_in_state;

// Internal wires

// Assigns
assign pixel_out = pixel_out_r;
assign pixel_wr = pixel_wr_r;
assign pixel_filter = pixel_filter_r;
assign valid = valid_r;

// States
localparam x_idle = 3'b000, x_new = 3'b001;
localparam y_idle = 3'b000, y_new = 3'b001;

// width register circuit
always @(posedge clock) begin
  width_r <= width;
end

// height register circuit
always @(posedge clock) begin
  height_r <= height;
end

// X input counter
always @(posedge clock) begin
  if(reset_n == 1'b0) begin
    x_in_counter_r <= 0;
    x_in_state <= x_idle;
  end
  else if(enable == 1'b1) begin
    if(x_in_counter_r == (width_r-2)) begin
      x_in_state <= x_new;
      x_in_counter_r <= x_in_counter_r + 1'b1;
    end
    else if(x_in_counter_r == (width_r-1)) begin
      x_in_counter_r <= 0;
      x_in_state <= x_idle;
    end
    else begin
      x_in_counter_r <= x_in_counter_r + 1'b1;
      x_in_state <= x_idle;
    end
  end
  else begin
    x_in_counter_r <= x_in_counter_r;
  end
end

// Y input counter
always @(posedge clock) begin
  if(reset_n == 1'b0) begin
    y_in_counter_r <= 0;
    y_in_state <= y_idle;
  end
  else if(enable == 1'b1) begin
    if((x_in_state == x_new) && (y_in_counter_r == (height_r-1))) begin 
      y_in_counter_r <= 0;
    end
    else if(x_in_state == x_new) begin
      y_in_counter_r <= y_in_counter_r + 1'b1;
    end
  end
  else begin
    y_in_counter_r <= y_in_counter_r;
  end
end
// x output counter
always @(posedge clock) begin
  if(reset_n == 1'b0) begin
    x_out_counter
endmodule


`endif
