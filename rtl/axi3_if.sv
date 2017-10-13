interface axi3_if #(
  int unsigned   AW = 32,    // Address width
  int unsigned AWAW = AW,
  int unsigned ARAW = AW,
  int unsigned   DW = 32,    // Data    width
  int unsigned  WDW = DW,
  int unsigned  RDW = DW,
  int unsigned  WSW = WDW/8, // Select  width
  int unsigned   IW = 1,     // ID      width
  int unsigned   UW = 0,     // user width
  int unsigned AWUW = UW,
  int unsigned  WUW = UW,
  int unsigned  BUW = UW,
  int unsigned ARUW = UW,
  int unsigned  RUW = UW
)(
  // global signals
  input logic ACLK,
  input logic ARESETn
);

// write address channel
logic [AWIW-1:0] AWID    ;
logic [AWAW-1:0] AWADDR  ;
logic    [4-1:0] AWREGION;
logic    [8-1:0] AWLEN   ;
logic    [3-1:0] AWSIZE  ;
logic    [2-1:0] AWBURST ;
logic    [1-1:0] AWLOCK  ;
logic    [4-1:0] AWCACHE ;
logic    [3-1:0] AWPROT  ;
logic    [4-1:0] AWQOS   ;
logic [AWUW-1:0] AWUSER  ;
logic            AWVALID ;
logic            AWREADY ;
// write dta channel
logic  [WIW-1:0]  WID    ;
logic  [WDW-1:0]  WDATA  ;
logic  [WSW-1:0]  WSTRB  ;
logic             WLAST  ;
logic  [WUW-1:0]  WUSER  ;
logic             WVALID ;
logic             WREADY ;
// write response channel
logic  [BIW-1:0]  BID    ;
logic    [2-1:0]  BRESP  ;
logic  [BUW-1:0]  BUSER  ;
logic             BVALID ;
logic             BREADY ;
// read address channel
logic [ARIW-1:0] ARID    ;
logic [ARAW-1:0] ARADDR  ;
logic    [4-1:0] ARREGION;
logic    [8-1:0] ARLEN   ;
logic    [3-1:0] ARSIZE  ;
logic    [2-1:0] ARBURST ;
logic    [1-1:0] ARLOCK  ;
logic    [4-1:0] ARCACHE ;
logic    [3-1:0] ARPROT  ;
logic    [4-1:0] ARQOS   ;
logic [ARUW-1:0] ARUSER  ;
logic            ARVALID ;
logic            ARREADY ;
// read data channel
logic  [RIW-1:0]  RID    ;
logic  [RDW-1:0]  RDATA  ;
logic    [2-1:0]  RRESP  ;
logic             RLAST  ;
logic  [RUW-1:0]  RUSER  ;
logic             RVALID ;
logic             RREADY ;

modport m (
  input   ACLK   ,
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

modport s (
  input   ACLK   ,
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

endinterface: axi3_if
