/*
* File:     jmb_3x3_filter_tb.v
* Author:   Jared Bold
* Date:     10.6.14
* Description
*   jmb_3x3_filter testbench
*/

`include "jmb_3x3_filter.v"

module jmb_3x3_filter_tb();

reg valid_in;
reg ready_in;
reg clock;
reg reset_n;
reg [7:0] data_in;

wire valid_out;
wire ready_out;
wire [7:0] data_out;

jmb_3x3_filter #(
  8,
  10
) dut (
  valid_in,
  ready_in,
  clock,
  reset_n,
  data_in,
  valid_out,
  ready_out,
  data_out
);

always 
  #5 clock = ~clock;

initial begin
  valid_in = 0;
  ready_in = 0;
  clock = 0;
  reset_n = 0;
  data_in = 0;
  #15 reset_n = 1;
  #10 valid_in = 1;
  data_in = 22;
  #10 ready_in = 1;

  #10 data_in = 23;
  #10 data_in = 20;
  #10 data_in = 22;
  #10 data_in = 21;
  #10 data_in = 200;
  #10 data_in = 201;
  #10 data_in = 202;
  #10 data_in = 200;
  #10 data_in = 201;
  
  #10 data_in = 22;
  #10 data_in = 23;
  #10 data_in = 25;
  #10 data_in = 25;
  #10 data_in = 150;
  #10 data_in = 170;
  #10 data_in = 190;
  #10 data_in = 201;
  #10 data_in = 200;
  #10 data_in = 200;
  
#10 data_in = 22;
#10 data_in = 23;
#10 data_in = 20;
#10 data_in = 22;
#10 data_in = 21;
#10 data_in = 200;
#10 data_in = 201;
#10 data_in = 202;
#10 data_in = 200;
#10 data_in = 201;

#10 data_in = 22;
#10 data_in = 23;
#10 data_in = 25;
#10 data_in = 25;
#10 data_in = 150;
#10 data_in = 170;
#10 data_in = 190;
#10 data_in = 201;
#10 data_in = 200;
#10 data_in = 200;

#10 data_in = 22;
  #10 data_in = 23;
  #10 data_in = 20;
  #10 data_in = 22;
  #10 data_in = 21;
  #10 data_in = 200;
  #10 data_in = 201;
  #10 data_in = 202;
  #10 data_in = 200;
  #10 data_in = 201;
  
  
   
  $finish;
end

endmodule
