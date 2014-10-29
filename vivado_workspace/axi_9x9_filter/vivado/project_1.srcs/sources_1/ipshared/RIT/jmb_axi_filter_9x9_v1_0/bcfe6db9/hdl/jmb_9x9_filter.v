/*
* File:     jmb_9x9_filter.v
* Author:   Jared Bold
* Date:     10.6.14
* Description
*   9x9 filter implementation
*
*   ---------------------------
*   |valid_in       valid_out |
*   |ready_in       ready_out |
*   |data_in        data_out  |
*   |A                        |
*   |B                        |
*   |C                        |
*   |shift                    |
*   |clock                    |
*   |reset_n                  |
*   ---------------------------
*
*   Filter Kernel:
*   
*   C   B   C
*   B   A   B
*   C   B   C
*/

`ifndef _jmb_9x9_filter_v_
`define _jmb_9x9_filter_v_
`include "jmb_9x9_window.v"
module jmb_9x9_filter #
(
  // Parameters
  parameter integer pixel_width = 8,
  parameter integer image_width = 512,
  parameter integer signed A = -40,
  parameter integer signed B = -24,
  parameter integer signed C = -12,
  parameter integer signed D = 0,
  parameter integer signed E = 3,
  parameter integer signed F = 5,
  parameter integer signed G = 5,
  parameter integer signed H = 5,
  parameter integer signed I = 4,
  parameter integer signed J = 2,
  parameter integer signed K = 2,
  parameter integer signed L = 2,
  parameter integer signed M = 1,
  parameter integer signed N = 1,
  parameter integer signed O = 0,
  parameter integer shift = 0,
  parameter integer offset = 128
)
(
  // IO
  valid_in,
  ready_in,
  clock,
  reset_n,
  data_in,
  valid_out,
  ready_out,
  data_out
);

// Inputs
input wire valid_in;
input wire ready_in;
input wire clock;
input wire reset_n;
input [pixel_width-1:0] data_in;

// Outputs
output wire [pixel_width-1:0] data_out;
output wire valid_out;
output wire ready_out;

// Wires
wire signed [pixel_width:0]  w00,  w01,  w02,  w03,  w04,  w05,  w06,  w07,  w08;
wire signed [pixel_width:0]  w10,  w11,  w12,  w13,  w14,  w15,  w16,  w17,  w18;
wire signed [pixel_width:0]  w20,  w21,  w22,  w23,  w24,  w25,  w26,  w27,  w28;
wire signed [pixel_width:0]  w30,  w31,  w32,  w33,  w34,  w35,  w36,  w37,  w38;
wire signed [pixel_width:0]  w40,  w41,  w42,  w43,  w44,  w45,  w46,  w47,  w48;
wire signed [pixel_width:0]  w50,  w51,  w52,  w53,  w54,  w55,  w56,  w57,  w58;
wire signed [pixel_width:0]  w60,  w61,  w62,  w63,  w64,  w65,  w66,  w67,  w68;
wire signed [pixel_width:0]  w70,  w71,  w72,  w73,  w74,  w75,  w76,  w77,  w78;
wire signed [pixel_width:0]  w80,  w81,  w82,  w83,  w84,  w85,  w86,  w87,  w88;
wire enable;

// Registers
reg [pixel_width-1:0] data_out_r;
reg valid_out_r;
reg ready_out_r;
integer signed sum_a;
integer signed sum_b;
integer signed sum_c;
integer signed sum_d;
integer signed sum_e;
integer signed sum_f;
integer signed sum_g;
integer signed sum_h;
integer signed sum_i;
integer signed sum_j;
integer signed sum_k;
integer signed sum_l;
integer signed sum_m;
integer signed sum_n;
integer signed sum_o;
reg signed [63:0] sum_total_1;
reg signed [63:0] sum_total_2;
reg signed [63:0] sum_total_3;
reg signed [63:0] sum_total_4;
reg signed [63:0] sum_total_5;
reg signed [63:0] sum_total_6;

// Assigns
assign data_out = data_out_r;
assign valid_out = valid_out_r;
assign ready_out = ready_out_r;
assign enable = ready_in & valid_in;
assign w00[8] = 1'b0;
assign w01[8] = 1'b0;
assign w02[8] = 1'b0;
assign w03[8] = 1'b0;
assign w04[8] = 1'b0;
assign w05[8] = 1'b0;
assign w06[8] = 1'b0;
assign w07[8] = 1'b0;
assign w08[8] = 1'b0;
assign w10[8] = 1'b0;
assign w11[8] = 1'b0;
assign w12[8] = 1'b0;
assign w13[8] = 1'b0;
assign w14[8] = 1'b0;
assign w15[8] = 1'b0;
assign w16[8] = 1'b0;
assign w17[8] = 1'b0;
assign w18[8] = 1'b0;
assign w20[8] = 1'b0;
assign w21[8] = 1'b0;
assign w22[8] = 1'b0;
assign w23[8] = 1'b0;
assign w24[8] = 1'b0;
assign w25[8] = 1'b0;
assign w26[8] = 1'b0;
assign w27[8] = 1'b0;
assign w28[8] = 1'b0;
assign w30[8] = 1'b0;
assign w31[8] = 1'b0;
assign w32[8] = 1'b0;
assign w33[8] = 1'b0;
assign w34[8] = 1'b0;
assign w35[8] = 1'b0;
assign w36[8] = 1'b0;
assign w37[8] = 1'b0;
assign w38[8] = 1'b0;
assign w40[8] = 1'b0;
assign w41[8] = 1'b0;
assign w42[8] = 1'b0;
assign w43[8] = 1'b0;
assign w44[8] = 1'b0;
assign w45[8] = 1'b0;
assign w46[8] = 1'b0;
assign w47[8] = 1'b0;
assign w48[8] = 1'b0;
assign w50[8] = 1'b0;
assign w51[8] = 1'b0;
assign w52[8] = 1'b0;
assign w53[8] = 1'b0;
assign w54[8] = 1'b0;
assign w55[8] = 1'b0;
assign w56[8] = 1'b0;
assign w57[8] = 1'b0;
assign w58[8] = 1'b0;
assign w60[8] = 1'b0;
assign w61[8] = 1'b0;
assign w62[8] = 1'b0;
assign w63[8] = 1'b0;
assign w64[8] = 1'b0;
assign w65[8] = 1'b0;
assign w66[8] = 1'b0;
assign w67[8] = 1'b0;
assign w68[8] = 1'b0;
assign w70[8] = 1'b0;
assign w71[8] = 1'b0;
assign w72[8] = 1'b0;
assign w73[8] = 1'b0;
assign w74[8] = 1'b0;
assign w75[8] = 1'b0;
assign w76[8] = 1'b0;
assign w77[8] = 1'b0;
assign w78[8] = 1'b0;
assign w80[8] = 1'b0;
assign w81[8] = 1'b0;
assign w82[8] = 1'b0;
assign w83[8] = 1'b0;
assign w84[8] = 1'b0;
assign w85[8] = 1'b0;
assign w86[8] = 1'b0;
assign w87[8] = 1'b0;
assign w88[8] = 1'b0;

// internal modules
jmb_9x9_window #(
  pixel_width,
  image_width
) window (
  enable,
  clock,
  reset_n,
  data_in,
  w00[7:0], w01[7:0], w02[7:0], w03[7:0], w04[7:0], w05[7:0], w06[7:0], w07[7:0], w08[7:0],
  w10[7:0], w11[7:0], w12[7:0], w13[7:0], w14[7:0], w15[7:0], w16[7:0], w17[7:0], w18[7:0],
  w20[7:0], w21[7:0], w22[7:0], w23[7:0], w24[7:0], w25[7:0], w26[7:0], w27[7:0], w28[7:0],
  w30[7:0], w31[7:0], w32[7:0], w33[7:0], w34[7:0], w35[7:0], w36[7:0], w37[7:0], w38[7:0],
  w40[7:0], w41[7:0], w42[7:0], w43[7:0], w44[7:0], w45[7:0], w46[7:0], w47[7:0], w48[7:0],
  w50[7:0], w51[7:0], w52[7:0], w53[7:0], w54[7:0], w55[7:0], w56[7:0], w57[7:0], w58[7:0],
  w60[7:0], w61[7:0], w62[7:0], w63[7:0], w64[7:0], w65[7:0], w66[7:0], w67[7:0], w68[7:0],
  w70[7:0], w71[7:0], w72[7:0], w73[7:0], w74[7:0], w75[7:0], w76[7:0], w77[7:0], w78[7:0],
  w80[7:0], w81[7:0], w82[7:0], w83[7:0], w84[7:0], w85[7:0], w86[7:0], w87[7:0], w88[7:0]
);

// valid_out circuit
always @(posedge clock) begin
  if(!reset_n) begin
    valid_out_r <= 0;
  end
  else begin
    valid_out_r <= valid_in;
  end
end

// ready_out circuit
always @(posedge clock) begin
  if(!reset_n) begin
    ready_out_r <= 0;
  end
  else begin
    ready_out_r <= ready_in;
  end
end

// Filter circuit
always @(posedge clock) begin
  if(!reset_n) begin
    data_out_r = 0;
    sum_a = 0;
    sum_b = 0;
    sum_c = 0;
    sum_d = 0;
    sum_e = 0;
    sum_f = 0;
    sum_g = 0;
    sum_h = 0;
    sum_i = 0;
    sum_j = 0;
    sum_k = 0;
    sum_l = 0;
    sum_m = 0;
    sum_n = 0;
    sum_o = 0;
    sum_total_1 = 0;
    sum_total_2 = 0;
    sum_total_3 = 0;
    sum_total_4 = 0;
    sum_total_5 = 0;
    sum_total_6 = 0;
  end
  else if(valid_in && ready_in) begin
    sum_a = A*(w44);
    sum_b = B*(w34+w43+w45+w54);
    sum_c = C*(w33+w35+w53+w55);
    sum_d = D*(w24+w42+w46+w64);
    sum_e = E*(w23+w25+w32+w36+w52+w56+w63+w65);
    sum_f = F*(w22+w26+w62+w66);
    sum_g = G*(w14+w41+w47+w74);
    sum_h = H*(w13+w15+w31+w37+w51+w57+w73+w75);
    sum_i = I*(w12+w16+w21+w27+w61+w67+w72+w76);
    sum_j = J*(w11+w17+w71+w77);
    sum_k = K*(w04+w40+w48+w84);
    sum_l = L*(w03+w05+w30+w38+w50+w58+w83+w85);
    sum_m = M*(w02+w06+w20+w28+w60+w68+w82+w86);
    sum_n = N*(w01+w07+w10+w18+w70+w78+w81+w87);
    sum_o = O*(w00+w08+w80+w88);
    sum_total_1 = sum_a+sum_b+sum_c+sum_d;
    sum_total_2 = sum_e+sum_f+sum_g+sum_h;
    sum_total_3 = sum_i+sum_j+sum_k+sum_l;
    sum_total_4 = sum_m+sum_n+sum_o;
    sum_total_5 = sum_total_1+sum_total_2+sum_total_3+sum_total_4;
    sum_total_6 = (sum_total_5 >>> shift) + offset;
    if(sum_total_6[63] == 1'b1) begin
      data_out_r = 8'h0;
    end 
    else if(sum_total_6[62:8] && 1) begin
      data_out_r = 8'hFF;
    end
    else begin
      data_out_r = sum_total_6[7:0];
    end
  end
  else begin
    data_out_r = data_out_r;
  end
end
endmodule

`endif
