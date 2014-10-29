`timescale 1 ns / 1 ps
module scanline_buffer_tb();
  reg [7:0] data_in;
  reg valid;
  reg reset;
  reg clock;
  reg enable;
  reg [31:0] length;

  wire [7:0] data_out;
  wire full;
  wire valid_out;

  scanline_buffer_v1_0 dut(data_in, valid, reset, clock, enable, length, data_out, full, valid_out);

  initial begin
    valid = 0;
    reset = 0;
    clock = 0;
    enable = 0;
    data_in = 0;

    #20 reset = 1'b1;
    length = 32'd10;

    #20 enable = 1'b1;
    #20 valid = 1'b1;
    #10  data_in = data_in + 1; // 1
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  data_in = data_in + 1;
    #10  valid = 1'b0;
  end

  // clock
  always 
    #5 clock = !clock;

endmodule
