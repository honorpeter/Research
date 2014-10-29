/*
* File:   filter_sym_5x5.v
* Author: Jared Bold
* Date:   9.20.2014
* Description:
*   Filter hardware
*/

module filter_sym_5x5(
    input wire clock,
    input wire enable,
    input wire resetn,

    input wire [7:0] pixel_in,
    input wire [31:0] width,
    input wire [31:0] height,
    input wire valid,
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [31:0] c,
    input wire [31:0] d,
    input wire [31:0] e,
    input wire [31:0] f,
    input wire [31:0] shift,

    output wire [7:0] pixel_out
  );

  wire [7:0] sl5_output;
  wire [7:0] sl4_output;
  wire [7:0] sl3_output;
  wire [7:0] sl2_output;
  wire [7:0] sl1_output;

  wire sl5_full;
  wire sl4_full;
  wire sl3_full;
  wire sl2_full;
  wire sl1_full;

  wire sl5_valid_out;
  wire sl4_valid_out;
  wire sl3_valid_out;
  wire sl2_valid_out;
  wire sl1_valid_out;
  
  scanline_buffer sl5(
    .data_in(pixel_in),
    .valid(valid),
    .reset(resetn),
    .enable(enable),
    .length(width),
    .data_out(sl5_output),
    .full(sl5_full),
    .valid_out(sl5_valid_out)
  );

  scanline_buffer sl4(
    .data_in(sl5_output),
    .valid(sl5_valid_out),
    .reset(resetn),
    .enable(enable),
    .length(width),
    .data_out(sl4_output),
    .full(sl4_full),
    .valid_out(sl4_valid_out)
  );
endmodule
