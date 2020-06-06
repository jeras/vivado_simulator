import axi_if_pkg::*;

interface axi_if #(
  int unsigned C_AXI_PROTOCOL        = 0,
  int unsigned C_AXI_INTERFACE_MODE  = 1,
  int unsigned C_AXI_ADDR_WIDTH      = 32,
  int unsigned C_AXI_WDATA_WIDTH     = 32,
  int unsigned C_AXI_RDATA_WIDTH     = 32,
  int unsigned C_AXI_WID_WIDTH       = 0,
  int unsigned C_AXI_RID_WIDTH       = 0,
  int unsigned C_AXI_AWUSER_WIDTH    = 0,
  int unsigned C_AXI_ARUSER_WIDTH    = 0,
  int unsigned C_AXI_WUSER_WIDTH     = 0,
  int unsigned C_AXI_RUSER_WIDTH     = 0,
  int unsigned C_AXI_BUSER_WIDTH     = 0,
  int unsigned C_AXI_SUPPORTS_NARROW = 0,
  int unsigned C_AXI_HAS_BURST       = 0,
  int unsigned C_AXI_HAS_LOCK        = 0,
  int unsigned C_AXI_HAS_CACHE       = 0,
  int unsigned C_AXI_HAS_REGION      = 0,
  int unsigned C_AXI_HAS_PROT        = 1,
  int unsigned C_AXI_HAS_QOS         = 0,
  int unsigned C_AXI_HAS_WSTRB       = 1,
  int unsigned C_AXI_HAS_BRESP       = 1,
  int unsigned C_AXI_HAS_RRESP       = 1,
  int unsigned C_AXI_HAS_ARESETN     = 1
)(
  input logic ACLK,
  input logic ACLKEN,
  input logic ARESETn
);

// write address channel
logic [(                            C_AXI_ADDR_WIDTH    )-1:0] AWADDR;
logic [(!C_AXI_WID_WIDTH      ? 1 : C_AXI_WID_WIDTH     )-1:0] AWID;
logic [(C_AXI_PROTOCOL==1     ? 4 : 8                   )-1:0] AWLEN;
logic                                                  [3-1:0] AWSIZE;
logic                                                  [2-1:0] AWBURST;
logic [(C_AXI_PROTOCOL==1     ? 2 : 1                   )-1:0] AWLOCK;
logic                                                  [4-1:0] AWCACHE;
logic                                                  [3-1:0] AWPROT;
logic                                                          AWVALID;
logic                                                          AWREADY;
logic                                                  [4-1:0] AWREGION;
logic                                                  [4-1:0] AWQOS;
logic [(!C_AXI_AWUSER_WIDTH  ? 1 : C_AXI_AWUSER_WIDTH   )-1:0] AWUSER;

// write data channel
logic [(!C_AXI_WID_WIDTH     ? 1 : C_AXI_WID_WIDTH      )-1:0] WID;
logic                                                          WLAST;
logic [(                           C_AXI_WDATA_WIDTH    )-1:0] WDATA;
logic [(!C_AXI_WDATA_WIDTH   ? 1 : C_AXI_WDATA_WIDTH/8  )-1:0] WSTRB;
logic                                                          WVALID;
logic                                                          WREADY;
logic [(!C_AXI_WUSER_WIDTH   ? 1 : C_AXI_WUSER_WIDTH    )-1:0] WUSER;

// write response channel
logic                                                  [2-1:0] BRESP;
logic [(!C_AXI_WID_WIDTH     ? 1 : C_AXI_WID_WIDTH      )-1:0] BID;
logic                                                          BVALID;
logic                                                          BREADY;
logic [(!C_AXI_BUSER_WIDTH   ? 1 : C_AXI_BUSER_WIDTH    )-1:0] BUSER;

// read address channel
logic [(                           C_AXI_ADDR_WIDTH     )-1:0] ARADDR;
logic [(!C_AXI_RID_WIDTH     ? 1 : C_AXI_RID_WIDTH      )-1:0] ARID;
logic [(C_AXI_PROTOCOL==1     ? 4 : 8                   )-1:0] ARLEN;
logic                                                  [3-1:0] ARSIZE;
logic                                                  [2-1:0] ARBURST;
logic [(C_AXI_PROTOCOL==1     ? 2 : 1                   )-1:0] ARLOCK;
logic                                                  [4-1:0] ARCACHE;
logic                                                  [3-1:0] ARPROT;
logic                                                          ARVALID;
logic                                                          ARREADY;
logic                                                  [4-1:0] ARREGION;
logic                                                  [4-1:0] ARQOS;
logic [(!C_AXI_ARUSER_WIDTH  ? 1 : C_AXI_ARUSER_WIDTH   )-1:0] ARUSER;

// read data  channel
logic [(!C_AXI_RID_WIDTH     ? 1 : C_AXI_RID_WIDTH      )-1:0] RID;
logic                                                          RLAST;
logic [(                           C_AXI_RDATA_WIDTH    )-1:0] RDATA;
logic                                                  [2-1:0] RRESP;
logic                                                          RVALID;
logic                                                          RREADY;
logic [(!C_AXI_RUSER_WIDTH   ? 1 : C_AXI_RUSER_WIDTH    )-1:0] RUSER;

// master port
modport m (
  input   ACLK   ,
  input   ACLKEN ,
  input   ARESETn,
  output AWID    ,
  output AWADDR  ,
  output AWREGION,
  output AWLEN   ,
  output AWSIZE  ,
  output AWBURST ,
  output AWLOCK  ,
  output AWCACHE ,
  output AWPROT  ,
  output AWQOS   ,
  output AWUSER  ,
  output AWVALID ,
  input  AWREADY ,
  output  WID    ,
  output  WDATA  ,
  output  WSTRB  ,
  output  WLAST  ,
  output  WUSER  ,
  output  WVALID ,
  input   WREADY ,
  input   BID    ,
  input   BRESP  ,
  input   BUSER  ,
  input   BVALID ,
  output  BREADY ,
  output ARID    ,
  output ARADDR  ,
  output ARREGION,
  output ARLEN   ,
  output ARSIZE  ,
  output ARBURST ,
  output ARLOCK  ,
  output ARCACHE ,
  output ARPROT  ,
  output ARQOS   ,
  output ARUSER  ,
  output ARVALID ,
  input  ARREADY ,
  input   RID    ,
  input   RDATA  ,
  input   RRESP  ,
  input   RLAST  ,
  input   RUSER  ,
  input   RVALID ,
  output  RREADY
);

// slave port
modport s (
  input   ACLK   ,
  input   ACLKEN ,
  input   ARESETn,
  input  AWID    ,
  input  AWADDR  ,
  input  AWREGION,
  input  AWLEN   ,
  input  AWSIZE  ,
  input  AWBURST ,
  input  AWLOCK  ,
  input  AWCACHE ,
  input  AWPROT  ,
  input  AWQOS   ,
  input  AWUSER  ,
  input  AWVALID ,
  output AWREADY ,
  input   WID    ,
  input   WDATA  ,
  input   WSTRB  ,
  input   WLAST  ,
  input   WUSER  ,
  input   WVALID ,
  output  WREADY ,
  output  BID    ,
  output  BRESP  ,
  output  BUSER  ,
  output  BVALID ,
  input   BREADY ,
  input  ARID    ,
  input  ARADDR  ,
  input  ARREGION,
  input  ARLEN   ,
  input  ARSIZE  ,
  input  ARBURST ,
  input  ARLOCK  ,
  input  ARCACHE ,
  input  ARPROT  ,
  input  ARQOS   ,
  input  ARUSER  ,
  input  ARVALID ,
  output ARREADY ,
  output  RID    ,
  output  RDATA  ,
  output  RRESP  ,
  output  RLAST  ,
  output  RUSER  ,
  output  RVALID ,
  input   RREADY
);


endinterface: axi_if
