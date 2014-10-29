/*
* File:     jmb_scanline_filter_tb.v
* Author:   Jared Bold
* Date:     10.4.14
* Description:
*   Testbench for jmb_scanline_filter.
*/
`ifndef _jmb_scanline_filter_tb
`define _jmb_scanline_filter_tb

`include "jmb_scanline_filter.v"
module jmb_scanline_filter_tb();

task validate;
  input reg [31:0] a;
  input reg [31:0] b;
  input reg [31:0] n;
  begin
    if(a != b) begin
      $display ("Test %d Failed! %d != %d", n, a, b);
      $finish;
    end
  end
endtask

reg clock;
reg enable;

reg [7:0] pixel_in;
reg pixel_wr;
reg pixel_filter;
reg [7:0] shift;
reg [7:0] co_A;
reg [7:0] co_B;
reg [7:0] co_C;

wire [7:0] pixel_out;
wire valid;

jmb_scanline_filter dut(
  enable,
  pixel_in,
  pixel_wr,
  pixel_filter,
  shift,
  co_A,
  co_B,
  co_C,
  clock, 
  pixel_out,
  valid
);

// Clock
always 
  #5 clock = ~clock;

// Testing
initial begin
  enable = 0;
  clock = 0;
  pixel_in = 0;
  pixel_wr = 0;
  pixel_filter = 0;
  shift = 0;
  co_A = 0;
  co_B = 0;
  co_C = 0;
  validate(pixel_out, 8'h0, 8'd1);
  validate(valid, 8'h0, 8'd2);
  #5 pixel_in = 8'h1;
  shift = 8'h1;
  co_A = 8'h0;
  co_B = 8'h1;
  co_C = 8'h1;
  $display ("en, in, wr, filter, shift, a, b, c, out, vaild");
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  enable = 1;
  pixel_in = 8'h0;

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h1;

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h2;

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h3;
  pixel_wr = 1'b1;

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h4;
  
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h5;
  pixel_filter = 1'b1;

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h6;

  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h7;
  
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h8;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h9;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'hA;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'hB;
  pixel_filter = 0;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'hC;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'hD;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'hF;
  #10 $display ("%d, %d, %d, %d, %d, %d, %d, %d, %d, %d", enable, pixel_in, pixel_wr, pixel_filter, shift, co_A, co_B, co_C, pixel_out, valid);
  pixel_in = 8'h10;
  $finish;
end

endmodule

`endif
