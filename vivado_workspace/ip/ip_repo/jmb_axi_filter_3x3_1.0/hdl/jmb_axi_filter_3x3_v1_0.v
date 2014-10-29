
`timescale 1 ns / 1 ps

	module jmb_axi_filter_3x3_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= 8,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 8,
		parameter integer C_M00_AXIS_START_COUNT	= 32,
		parameter integer C_IMAGE_WIDTH = 512,
		
		// Parameters for filter
		parameter integer A = 1,
		parameter integer B = 0,
		parameter integer C = 0,
		parameter integer SHIFT = 0
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
	);
	// Add user logic here
        jmb_3x3_filter #(
            .image_width(C_IMAGE_WIDTH),
            .A(A),
            .B(B),
            .C(C),
            .shift(SHIFT)
        ) filter
        (
          .valid_in(s00_axis_tvalid),
          .ready_in(m00_axis_tready),
          .clock(s00_axis_aclk),
          .reset_n(s00_axis_aresetn),
          .data_in(s00_axis_tdata),
          .valid_out(m00_axis_tvalid),
          .ready_out(s00_axis_tready),
          .data_out(m00_axis_tdata)
        );

	// User logic ends

	endmodule
