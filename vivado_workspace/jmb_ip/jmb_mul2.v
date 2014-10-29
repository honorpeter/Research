/*
* File:       jmb_mul2.v
* Author:     Jared Bold
* Date:       10.4.14
* Description:
*   2 input multiplier
*
*   -------------------
*   | mult_1          |
*   |             prod|
*   | mult_2          |
*   -------------------
*/
`ifndef _jmb_mul2_
`define _jmb_mul2_
module jmb_mul2(
  mult_1,
  mult_2,
  prod
);
// Inputs
input wire [15:0] mult_1;
input wire [15:0] mult_2;

// Outputs
output wire[31:0] prod;

assign prod = mult_1 * mult_2;

endmodule
`endif
