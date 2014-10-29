/*
* File:     jmb_fifo.v
* Author:   Jared Bold
* Date:     10.5.14
* Description
*   Fifo implementation
*/

`ifndef _jmb_fifo_v_
`define _jmb_fifo_v_

module jmb_fifo # (
  // Parameters
  parameter pixel_width = 8,
  parameter sl_width = 512
)
(
  // I/O
  enable,
  clock,
  reset_n,
  in,
  out
);

// Inputs
input wire [pixel_width-1:0] in;
input wire clock;
input wire reset_n;

// Outputs
output wire [pixel_width-1:0] out;

// Integers
integer i;

// Registers
reg [pixel_width-1:0] R[sl_width-1:0];

// Assigns
assign out = R[0];

// shift operation
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < sl_width; i = i+1) begin
      R[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < sl_width-1; i = i+1) begin
      R[i] <= R[i+1];
    end
    R[sl_width-1] <= in;
  end
  else begin
    for(i = 0; i < sl_width; i = i+1) begin
      R[i] <= R[i];
    end
  end
end
endmodule

`endif
