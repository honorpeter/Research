//////////////////////////////////////////////////////////////////
// File:    jmb_horz_interp_by_2.v
// Author:  Jared Bold
// Date:    11.2.14
// Description
//  Performs horizontal interpolation on data coming in
//////////////////////////////////////////////////////////////////
`ifndef _JMB_HORZ_INTERP_BY_2_V_
`define _JMB_HORZ_INTERP_BY_2_V_

//////////////////////////////////////////////////////////////////
// Module declaration
//////////////////////////////////////////////////////////////////
module jmb_horz_interp_by_2(
  valid_in,
  ready_in,
  clock,
  reset_n,
  data_in,
  valid_out,
  ready_out,
  data_out
);

//////////////////////////////////////////////////////////////////
// I/O
//////////////////////////////////////////////////////////////////
// Inputs
input wire valid_in;
input wire ready_in;
input wire clock;
input wire reset_n;
input wire [7:0] data_in;

// Outputs
output reg valid_out;
output reg ready_out;
output reg [15:0] data_out;

///////////////////////////////////////////////////////////////////
// Internals
///////////////////////////////////////////////////////////////////
// Registers
integer R [1:0];
integer temp;

///////////////////////////////////////////////////////////////////
// Circuitry
///////////////////////////////////////////////////////////////////
// valid_out circuit
always @(posedge clock) begin
  if(!reset_n) begin
    valid_out <= 1'b0;
  end
  else begin
    valid_out <= valid_in;
  end
end

// read_out circuit
always @(posedge clock) begin
  if(!reset_n) begin
    ready_out <= 1'b0;
  end
  else begin
    ready_out <= ready_in;
  end
end

// buffer circuit
always @(posedge clock) begin
  if(!reset_n) begin
    R[0] <= 0;
    R[1] <= 0;
  end
  else begin
    if(ready_in && valid_in) begin
      R[1] <= R[0];
      R[0] <= data_in;
    end
    else begin
      R[0] <= R[0];
      R[1] <= R[1];
    end
  end
end

// interpolate circuit
always @(posedge clock) begin
  if(!reset_n) begin
    data_out = 0;
  end
  else begin
    if(ready_in && valid_in) begin
      temp = (R[0] + R[1]) >> 1;
      data_out[15:8] = temp[7:0];
      data_out[7:0] = R[1][7:0];
    end
    else begin
      data_out = data_out;
    end
  end
end

endmodule
`endif // !_JMB_HORZ_INTERP_BY_2_V_
