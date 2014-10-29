/*
* File:     jmb_mad2_tb.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   Test bench for jmb_mad2
*/

`include "jmb_mad2.v"

module jmb_mad2_tb();

reg [7:0] add_1;
reg [7:0] add_2;
reg [7:0] mult;

wire [31:0] out;

reg clock;

jmb_mad2 dut(add_1, add_2, mult, out);

always
  #5 clock = ~clock;

initial begin
  clock = 0;
  add_1 = 0;
  add_2 = 0;
  mult = 0;
  if(out != 32'd0) begin
    $display ("Test 1 Failed!");
    $finish;
  end
  #5 add_1 = 8'h2;
  if(out != 32'd0) begin
    $display ("Test 2 Failed!");
    $finish;
  end
  #10 add_2 = 8'h3;
  if(out != 32'd0) begin
    $display ("Test 3 Failed!");
    $finish;
  end
  #10 mult = 8'h2;
  if(out != 32'd10) begin
    $display ("Test 4 Failed!");
    $finish;
  end
  $display ("Test passed");
  $finish;
end

endmodule
