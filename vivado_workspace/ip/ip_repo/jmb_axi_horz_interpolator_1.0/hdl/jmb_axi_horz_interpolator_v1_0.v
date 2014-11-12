
`timescale 1 ns / 1 ps

	module jmb_axi_horz_interpolator_v1_0 #
	(
		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= 8,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 16,
		parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [7 : 0] s00_axis_tdata,
		input wire [(8/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [15 : 0] m00_axis_tdata,
		output wire [(16/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
	);
	// Add user logic here
        jmb_horz_interp_by_2(
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
