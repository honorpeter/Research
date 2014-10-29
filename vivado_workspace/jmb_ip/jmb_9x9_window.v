/*
* File:     jmb_9x9_window.v
* Author:   Jared Bold
* Date:     10.5.14
* Description
*   Creates a parameterized 9x9 window based on a streaming pixel input
*/
`ifndef _jmb_9x9_window_
`define _jmb_9x9_window_
`include "jmb_fifo.v"

module jmb_9x9_window #
(
  // Parameters
  parameter integer pixel_width = 8,
  parameter integer image_width = 512
)
(
  // IO
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
// Inputs
input wire enable;
input wire clock;
input wire reset_n;
input wire [pixel_width-1:0] data;

// Outputs
output wire [pixel_width-1:0]  w00,  w01,  w02,  w03,  w04,  w05,  w06,  w07,  w08;
output wire [pixel_width-1:0]  w10,  w11,  w12,  w13,  w14,  w15,  w16,  w17,  w18;
output wire [pixel_width-1:0]  w20,  w21,  w22,  w23,  w24,  w25,  w26,  w27,  w28;
output wire [pixel_width-1:0]  w30,  w31,  w32,  w33,  w34,  w35,  w36,  w37,  w38;
output wire [pixel_width-1:0]  w40,  w41,  w42,  w43,  w44,  w45,  w46,  w47,  w48;
output wire [pixel_width-1:0]  w50,  w51,  w52,  w53,  w54,  w55,  w56,  w57,  w58;
output wire [pixel_width-1:0]  w60,  w61,  w62,  w63,  w64,  w65,  w66,  w67,  w68;
output wire [pixel_width-1:0]  w70,  w71,  w72,  w73,  w74,  w75,  w76,  w77,  w78;
output wire [pixel_width-1:0]  w80,  w81,  w82,  w83,  w84,  w85,  w86,  w87,  w88;

// registers
reg [pixel_width-1:0] sl0[0:8];
reg [pixel_width-1:0] sl1[0:8];
reg [pixel_width-1:0] sl2[0:8];
reg [pixel_width-1:0] sl3[0:8];
reg [pixel_width-1:0] sl4[0:8];
reg [pixel_width-1:0] sl5[0:8];
reg [pixel_width-1:0] sl6[0:8];
reg [pixel_width-1:0] sl7[0:8];
reg [pixel_width-1:0] sl8[0:8];

// wires
wire [pixel_width-1:0] fifo0_out_w;
wire [pixel_width-1:0] fifo1_out_w;
wire [pixel_width-1:0] fifo2_out_w;
wire [pixel_width-1:0] fifo3_out_w;
wire [pixel_width-1:0] fifo4_out_w;
wire [pixel_width-1:0] fifo5_out_w;
wire [pixel_width-1:0] fifo6_out_w;
wire [pixel_width-1:0] fifo7_out_w;

// Integers
integer i;

// Assigns
assign w00 = sl0[0];
assign w01 = sl0[1];
assign w02 = sl0[2];
assign w03 = sl0[3];
assign w04 = sl0[4];
assign w05 = sl0[5];
assign w06 = sl0[6];
assign w07 = sl0[7];
assign w08 = sl0[8];

assign w10 = sl1[0];
assign w11 = sl1[1];
assign w12 = sl1[2];
assign w13 = sl1[3];
assign w14 = sl1[4];
assign w15 = sl1[5];
assign w16 = sl1[6];
assign w17 = sl1[7];
assign w18 = sl1[8];

assign w20 = sl2[0];
assign w21 = sl2[1];
assign w22 = sl2[2];
assign w23 = sl2[3];
assign w24 = sl2[4];
assign w25 = sl2[5];
assign w26 = sl2[6];
assign w27 = sl2[7];
assign w28 = sl2[8];

assign w30 = sl3[0];
assign w31 = sl3[1];
assign w32 = sl3[2];
assign w33 = sl3[3];
assign w34 = sl3[4];
assign w35 = sl3[5];
assign w36 = sl3[6];
assign w37 = sl3[7];
assign w38 = sl3[8];

assign w40 = sl4[0];
assign w41 = sl4[1];
assign w42 = sl4[2];
assign w43 = sl4[3];
assign w44 = sl4[4];
assign w45 = sl4[5];
assign w46 = sl4[6];
assign w47 = sl4[7];
assign w48 = sl4[8];

assign w50 = sl5[0];
assign w51 = sl5[1];
assign w52 = sl5[2];
assign w53 = sl5[3];
assign w54 = sl5[4];
assign w55 = sl5[5];
assign w56 = sl5[6];
assign w57 = sl5[7];
assign w58 = sl5[8];

assign w60 = sl6[0];
assign w61 = sl6[1];
assign w62 = sl6[2];
assign w63 = sl6[3];
assign w64 = sl6[4];
assign w65 = sl6[5];
assign w66 = sl6[6];
assign w67 = sl6[7];
assign w68 = sl6[8];

assign w70 = sl7[0];
assign w71 = sl7[1];
assign w72 = sl7[2];
assign w73 = sl7[3];
assign w74 = sl7[4];
assign w75 = sl7[5];
assign w76 = sl7[6];
assign w77 = sl7[7];
assign w78 = sl7[8];

assign w80 = sl8[0];
assign w81 = sl8[1];
assign w82 = sl8[2];
assign w83 = sl8[3];
assign w84 = sl8[4];
assign w85 = sl8[5];
assign w86 = sl8[6];
assign w87 = sl8[7];
assign w88 = sl8[8];

jmb_fifo # (
  pixel_width,
  image_width-9
)fifo0( 
  enable,
  clock,
  reset_n,
  w10,
  fifo0_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo1( 
  enable,
  clock,
  reset_n,
  w20,
  fifo1_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo2( 
  enable,
  clock,
  reset_n,
  w30,
  fifo2_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo3( 
  enable,
  clock,
  reset_n,
  w40,
  fifo3_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo4( 
  enable,
  clock,
  reset_n,
  w50,
  fifo4_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo5( 
  enable,
  clock,
  reset_n,
  w60,
  fifo5_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo6( 
  enable,
  clock,
  reset_n,
  w70,
  fifo6_out_w
);
jmb_fifo # (
  pixel_width,
  image_width-9
)fifo7( 
  enable,
  clock,
  reset_n,
  w80,
  fifo7_out_w
);

// sl0 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl0[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl0[i] <= sl0[i+1];
    end
    sl0[8] <= fifo0_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl0[i] <= sl0[i];
    end
  end
end

// sl1 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl1[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl1[i] <= sl1[i+1];
    end
    sl1[8] <= fifo1_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl1[i] <= sl1[i];
    end
  end
end
// sl2 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl2[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl2[i] <= sl2[i+1];
    end
    sl2[8] <= fifo2_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl2[i] <= sl2[i];
    end
  end
end
// sl3 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl3[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl3[i] <= sl3[i+1];
    end
    sl3[8] <= fifo3_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl3[i] <= sl3[i];
    end
  end
end
// sl4 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl4[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl4[i] <= sl4[i+1];
    end
    sl4[8] <= fifo4_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl4[i] <= sl4[i];
    end
  end
end
// sl5 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl5[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl5[i] <= sl5[i+1];
    end
    sl5[8] <= fifo5_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl5[i] <= sl5[i];
    end
  end
end
// sl6 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl6[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl6[i] <= sl6[i+1];
    end
    sl6[8] <= fifo6_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl6[i] <= sl6[i];
    end
  end
end
// sl7 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl7[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl7[i] <= sl7[i+1];
    end
    sl7[8] <= fifo7_out_w;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl7[i] <= sl7[i];
    end
  end
end
// sl8 circuit
always @(posedge clock) begin
  if(!reset_n) begin
    for(i = 0; i < 9; i = i+1) begin
      sl8[i] <= 0;
    end
  end
  else if(enable) begin
    for(i = 0; i < 8; i = i+1) begin
      sl8[i] <= sl8[i+1];
    end
    sl8[8] <= data;
  end
  else begin 
    for(i = 0; i < 9; i = i+1) begin
      sl8[i] <= sl8[i];
    end
  end
end
endmodule
`endif
