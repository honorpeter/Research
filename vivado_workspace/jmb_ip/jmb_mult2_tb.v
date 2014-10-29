/*
* File:     jmb_mul2_tb.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   Test bench for two input multiplier
*/
`include "../jmb_mul2.v"

module jmb_mul2_tb();

reg [7:0] mult_1;
reg [7:0] mult_2;

wire [15:0] prod;
reg clock;

jmb_mul2 u1(mult_1, mult_2, prod);

always
  #5 clock = ~clock;


initial begin
  $display ("Beginning simulation");
  clock = 0;
  mult_1 = 0;
  mult_2 = 0;
  if(prod != 15'h0) begin
    $display ("Multiplier failed");
  end
  #5
  mult_1 = 8'h2;
  if(prod != 16'h0) begin
    $display ("Multiplier failed");
  end
  #10
  mult_2 = 8'h3;
  if(prod != 16'h6) begin
    $display ("Multiplier failed");
  end
  #10
  mult_1 = 8'hF;
  mult_2 = 8'h4;
  if(prod != 16'd60) begin
    $display ("Multipier failed");
  end
  $finish;
end
endmodule

  

