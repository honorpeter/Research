
`timescale 1 ns / 1 ps

module jmb_unpacker_v1_0_S00_AXIS #
(
  // Users to add parameters here

  // User parameters ends
  // Do not modify the parameters beyond this line

  // AXI4Stream sink: Data Width
  parameter integer C_S_AXIS_TDATA_WIDTH	= 32
)
(
  // Users to add ports here
  output wire [7:0] pixel_out,
  output wire [31:0] width,
  output wire [31:0] height,
  output wire valid,

  // User ports ends
  // Do not modify the ports beyond this line

  // AXI4Stream sink: Clock
  input wire  S_AXIS_ACLK,
  // AXI4Stream sink: Reset
  input wire  S_AXIS_ARESETN,
  // Ready to accept data in
  output wire  S_AXIS_TREADY,
  // Data in
  input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
  // Byte qualifier
  input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
  // Indicates boundary of last packet
  input wire  S_AXIS_TLAST,
  // Data is in valid
  input wire  S_AXIS_TVALID
);

// internal register
reg [31:0] counterR;
reg [31:0] widthR;
reg [31:0] height;
reg [31:0] dataR;
reg [7:0] pixelR[3:0];
reg treadyR;

// Assigns
assign S_AXIS_TREADY = treadyR;

// tready circuit 
always @(posedge S_AXIS_ACLK) begin
  if(!S_AXIS_ARESETN) begin
    treadyR <= 0;
  end
  else begin
    treadyR <= 1;
  end
end

// counterR circuit
always @(posedge S_AXIS_ACLK) begin
  if(!S_AXIS_ARESETN) begin
    counterR <= 0;
  end
  else begin
    if(S_AXIS_TVALID && S_AXIS_TREADY) begin
      counterR <= counterR + 1'b1;
    end
  end
end

// width circuit
always @(posedge S_AXIS_ACLK) begin
  if(!S_AXIS_ARESETN) begin
    widthR <= 0;
  end
  else begin
    if((counterR == 0) && (S_AXIS_TVALID && S_AXIS_TREADY)) begin
      widthR <= S_AXIS_TDATA;
    end
    else begin
      widthR <= widthR;
    end
  end
end

// height circuit
always @(posedge S_AXIS_ACLK) begin
  if(!S_AXIS_ARESETN) begin
    heightR <= 0;
  end
  else begin
    if((counterR == 1) && (S_AXIS_TVALID && S_AXIS_TREADY)) begin
      heightR <= S_AXIS_TDATA;
    end
    else begin
      heightR <= heightR;
    end
  end
end

// data circuit
always @(posedge S_AXIS_ACLK) begin
  if(!S_AXIS_ARESETN) begin
    pixelR[3] <= 0;
    pixelR[2] <= 0;
    pixelR[1] <= 0;
    pixelR[0] <= 0;
  end
  else begin
    if((counterR > 1) && (S_AXIS_TVALID && S_AXIS_TREADY)) begin
      pixelR[3] <= S_AXIS_TDATA[31:24];
      pixelR[2] <= S_AXIS_TDATA[23:16];
      pixelR[1] <= S_AXIS_TDATA[15:8];
      pixelR[0] <= S_AXIS_TDATA[7:0];
      treadyR <= 0;
    end
  end
end

// pixel circuit
always @(posedge clock2) begin
   switch 




endmodule
