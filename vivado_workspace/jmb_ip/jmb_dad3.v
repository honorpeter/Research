/*
* File:     jmb_dad2.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   2 adder, one shift divider. Divider adder.
*   
*   -------------------------
*   |add_1                  |
*   |add_2               out|
*   |shift                  |
*   -------------------------
*/

module jmb_dad3(
  add_1,
  add_2,
  add_3,
  shift,
  out
);

// Inputs
input wire [15:0] add_1;
input wire [15:0] add_2;
input wire [15:0] add_3;
input wire [15:0] shift;

// Output
output wire [15:0] out;

// Internals
wire [15:0] sum;

// Assigns
assign sum = add_1 + add_2 + add_3;
assign out = sum >> shift;

endmodule
