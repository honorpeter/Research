/*
* File:     jmb_dad3_tb.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   Test bench for jmb_dad3.
*/

`include "jmb_dad2.v"

module jmb_dad3_tb();

reg [15:0] add_1;
reg [15:0] add_2;
reg [15:0] shift;
reg clock;

wire [15:0] out;

jmb_dad2 dut(add_1, add_2, shift, out);

always
  #5 clock = ~clock;

initial begin
  clock = 0;
  add_1 = 0;
  add_2 = 0;
  shift = 0;
  if(out != 16'h0) begin
    $display ("Test 1 Failed. out = %d!", out);
    $finish;
  end
  #5 add_1 = 16'hF;
  if(out != 16'hF) begin
    $display ("Test 2 Failed. out = %d!", out);
    $finish;
  end
  #10 add_2 = 16'h2;
  if(out != 16'h11) begin
    $display ("Test 3 Failed. out = %d!", out);
    $finish;
  end
  #10 shift = 1;
  if(out != 16'h8) begin
    $display ("Test 4 Failed. out = %d!", out);
    $finish;
  end
  #10 add_1 = -16'hF;
  if(out != -16'h6) begin
    $display ("Test 5 Failed. out = %d!", out);
    $finish;
  end

  
  



