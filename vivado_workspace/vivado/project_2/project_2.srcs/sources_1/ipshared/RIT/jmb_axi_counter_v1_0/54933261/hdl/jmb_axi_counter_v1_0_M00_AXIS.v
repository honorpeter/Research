
`timescale 1 ns / 1 ps

module jmb_axi_counter_v1_0_M00_AXIS #
(
  // Users to add parameters here

  // User parameters ends
  // Do not modify the parameters beyond this line

  // Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
  parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
  // Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
  parameter integer C_M_START_COUNT	= 32
)
(
  // Users to add ports here

  // User ports ends
  // Do not modify the ports beyond this line

  // Global ports
  input wire  M_AXIS_ACLK,
  // 
  input wire  M_AXIS_ARESETN,
  // Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
  output wire  M_AXIS_TVALID,
  // TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
  output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
  // TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
  output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
  // TLAST indicates the boundary of a packet.
  output wire  M_AXIS_TLAST,
  // TREADY indicates that the slave can accept a transfer in the current cycle.
  input wire  M_AXIS_TREADY
);

  localparam frame_size = 16;
  // counter
  reg [C_M_AXIS_TDATA_WIDTH-1:0] counterR;
  assign M_AXIS_TDATA = counterR;             // Output the counter register on TDATA
  assign M_AXIS_TSTRB = {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};

  // counterR circuit
  always @(posedge M_AXIS_ACLK) begin         // Always on the positive clock edge
    if(!M_AXIS_ARESETN) begin                 // If reset is drawn low (ACTIVE LOW RESET)
      counterR <= 0;
    end
    else begin
      if(M_AXIS_TVALID && M_AXIS_TREADY) 
        counterR <= counterR + 1;
      else
        counterR <= counterR;
    end
  end

  // circuit to count number of clock cycles after reset
  reg counterEnR;
  reg [7:0] afterResetCycleCounterR;

  always @(posedge M_AXIS_ACLK) begin       // Always on the positive clock edge
    if(!M_AXIS_ARESETN) begin               // If reset is draw low (ACTIVE LOW RESET)
      counterEnR <= 0;                      // reset the counter enable
      afterResetCycleCounterR <= 0;         // reset the reset cycle counter
    end
    else begin
      afterResetCycleCounterR <= afterResetCycleCounterR + 1;   // Increment the after reset cycle counter
      if(afterResetCycleCounterR == C_M_START_COUNT) begin
        counterEnR <= 1;
      end
      else begin
        counterEnR <= counterEnR;
      end
    end
  end

  // TVALID Circuit
  reg tValidR;
  assign M_AXIS_TVALID = tValidR;   // output tValidR on M_AXIS_TVALID

  always @(posedge M_AXIS_ACLK) begin
    if(!M_AXIS_ARESETN) begin
      tValidR <= 0;
    end
    else begin
      if(counterEnR) begin
        tValidR <= 1;
      end 
      else begin
        tValidR <= 0;
      end
    end
  end

  // TLAST Circuit
  reg [7:0] packetCounterR;

  always @(posedge M_AXIS_ACLK) begin
    if(!M_AXIS_ARESETN) begin
      packetCounterR <= 8'hff;
    end
    else begin
      if(M_AXIS_TVALID && M_AXIS_TREADY) begin
        if(packetCounterR == (frame_size-1)) begin
          packetCounterR <= 8'hff;
        end
        else begin
          packetCounterR <= packetCounterR + 1;
        end
      end
    end
  end
      
  assign M_AXIS_TLAST = (packetCounterR == (frame_size-2))? 1 : 0;
endmodule
