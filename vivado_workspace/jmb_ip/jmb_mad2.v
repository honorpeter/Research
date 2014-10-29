/*
* File:     jmb_mad2.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   2 adder, 1 multiply multiplier adder unit
*
*  --------------------
*  |add_1             |
*  |add_2         out |
*  |mult              |
*  --------------------
*/

`include "jmb_mul2.v"

module jmb_mad2(
  add_1,
  add_2,
  mult,
  out
);

// Inputs
input wire [15:0] add_1;
input wire [15:0] add_2;
input wire [15:0] mult;

// Output
output wire [31:0] out;

// Internal Wires
wire [15:0] sum;

// Assigns
assign sum = add_1 + add_2;

// Modules
jmb_mul2 u1(sum, mult, out);

endmodule
