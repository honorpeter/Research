/*
* File:     jmb_9x9_window_tb.v
* Author:   Jared Bold
* Date:     10.5.14
* Description
*   Testbench for jmb_9x9_window
*/

`include "jmb_9x9_window.v"

module jmb_9x9_window_tb();
parameter pixel_width = 8;
parameter image_width = 10;
reg clock;
reg reset_n;
reg enable;
reg [pixel_width-1:0] data;

wire [pixel_width-1:0]  w00,  w01,  w02,  w03,  w04,  w05,  w06,  w07,  w08;
wire [pixel_width-1:0]  w10,  w11,  w12,  w13,  w14,  w15,  w16,  w17,  w18;
wire [pixel_width-1:0]  w20,  w21,  w22,  w23,  w24,  w25,  w26,  w27,  w28;
wire [pixel_width-1:0]  w30,  w31,  w32,  w33,  w34,  w35,  w36,  w37,  w38;
wire [pixel_width-1:0]  w40,  w41,  w42,  w43,  w44,  w45,  w46,  w47,  w48;
wire [pixel_width-1:0]  w50,  w51,  w52,  w53,  w54,  w55,  w56,  w57,  w58;
wire [pixel_width-1:0]  w60,  w61,  w62,  w63,  w64,  w65,  w66,  w67,  w68;
wire [pixel_width-1:0]  w70,  w71,  w72,  w73,  w74,  w75,  w76,  w77,  w78;
wire [pixel_width-1:0]  w80,  w81,  w82,  w83,  w84,  w85,  w86,  w87,  w88;

jmb_3x3_window # (
  pixel_width, 
  image_width
) dut (
  enable,
  clock,
  reset_n,
  data,
  w00,  w01,  w02,  w03,  w04,  w05,  w06,  w07,  w08,
  w10,  w11,  w12,  w13,  w14,  w15,  w16,  w17,  w18,
  w20,  w21,  w22,  w23,  w24,  w25,  w26,  w27,  w28,
  w30,  w31,  w32,  w33,  w34,  w35,  w36,  w37,  w38,
  w40,  w41,  w42,  w43,  w44,  w45,  w46,  w47,  w48,
  w50,  w51,  w52,  w53,  w54,  w55,  w56,  w57,  w58,
  w60,  w61,  w62,  w63,  w64,  w65,  w66,  w67,  w68,
  w70,  w71,  w72,  w73,  w74,  w75,  w76,  w77,  w78,
  w80,  w81,  w82,  w83,  w84,  w85,  w86,  w87,  w88
);

always 
  #5 clock = ~clock;

initial begin
  clock = 0;
  reset_n = 0;
  data = 8'h00;
  enable = 1; 
  #15 reset_n = 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  #10 data = data + 1;
  $finish;
end

endmodule
