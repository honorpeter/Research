/*
* File: scanline_buffer_v1_0.v
* Author: Jared Bold
* Date:   9.20.2014
* Description:
*   Verilog file to describe a scanline buffer
*/

`timescale 1 ns / 1 ps

module scanline_buffer_v1_0 #
  (
    // Parameters
    parameter integer BUFFER_LENGTH = 512,
    parameter integer REGISTER_WIDTH = 8
  )
  (
    // ports
    // INPUTS
    input wire [REGISTER_WIDTH-1:0] data_in,
    input wire valid,
    input wire reset,
    input wire clock,
    input wire enable,
    input wire [31:0] length,

    // OUTPUTS
    output wire [REGISTER_WIDTH-1:0] data_out,
    output wire full,
    output wire valid_out
  );
  // Integers
  integer i;

  // Input Registers
  reg [REGISTER_WIDTH-1:0] R [BUFFER_LENGTH-1:0];
  
  // Output Registers
  reg full_R;
  reg valid_R;

  assign full = full_R;
  assign valid_out = valid_R;
  assign data_out = R[0];

  // Counter to keep track of how full the buffer is
  reg [31:0] counter_current_fill;

  // buffer shifting
  always @(posedge clock) begin
    if(!reset) begin
      for(i = 0; i < BUFFER_LENGTH; i=i+1) begin
        R[i] <= 0;
      end // for
    end

    else if(valid && enable) begin
      for(i = 0; i < BUFFER_LENGTH-1; i=i+1) begin
        R[i] <= R[i+1];
      end // for
      R[length] <= data_in;
    end // if(valid && enable)

    else if(enable) begin
      for(i = 0; i < BUFFER_LENGTH-1; i=i+1) begin
        R[i] <= R[i+1];
      end // for
    end // if(enable)

    else begin
      for(i = 0; i < BUFFER_LENGTH-1; i=i+1) begin
        R[i] <= R[i];
      end // for
    end // else
  end // always

  // counter
  always @(posedge clock) begin
    if(!reset) begin
      counter_current_fill <= 0;
    end // !reset

    else if(valid && enable && (counter_current_fill < length)) begin
      counter_current_fill <= counter_current_fill + 1'b1;
    end // valid && enable && counter

    else if(counter_current_fill == 0) begin
      counter_current_fill <= counter_current_fill;
    end // counter == 0

    else if(enable && valid) begin
      counter_current_fill <= counter_current_fill;
    end // enable && valid

    else if(enable) begin
      counter_current_fill <= counter_current_fill - 1'b1;
    end // enable

    else begin
      counter_current_fill <= counter_current_fill;
    end // else

  end // always

  // full indicator
  always @(posedge clock) begin
    if(!reset) begin
      full_R <= 0;
    end // !reset
    else if(valid && enable && (counter_current_fill >= length - 1)) begin
      full_R <= 1'b1;
    end // counter == length - 1
    else begin 
      full_R <= 1'b0;
    end // else
  end // always
  
  // valid output circuit
  always @(posedge clock) begin 
    if(!reset) begin
      valid_R <= 0;
    end // !reset
    else if(counter_current_fill == 0) begin
      valid_R <= 0;
    end // counter == 0
    else if(counter_current_fill == length - 1) begin
      valid_R <= 1'b1;
    end // counter == length - 1
    else begin
      valid_R <= valid_R;
    end // else
  end // always

endmodule

