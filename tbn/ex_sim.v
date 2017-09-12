//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (lin64) Build 1909853 Thu Jun 15 18:39:10 MDT 2017
//Date        : Tue Sep 12 15:42:46 2017
//Host        : agrajag running 64-bit Ubuntu 16.04.2 LTS
//Command     : generate_target ex_sim.bd
//Design      : ex_sim
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ex_sim,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ex_sim,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "ex_sim.hwdef" *) 
module ex_sim
   (aclk,
    aresetn);
  input aclk;
  input aresetn;

  wire aclk_1;
  wire aresetn_1;
  wire [31:0]axi_vip_mst_M_AXI_ARADDR;
  wire [1:0]axi_vip_mst_M_AXI_ARBURST;
  wire [3:0]axi_vip_mst_M_AXI_ARCACHE;
  wire [7:0]axi_vip_mst_M_AXI_ARLEN;
  wire [0:0]axi_vip_mst_M_AXI_ARLOCK;
  wire [2:0]axi_vip_mst_M_AXI_ARPROT;
  wire [3:0]axi_vip_mst_M_AXI_ARQOS;
  wire axi_vip_mst_M_AXI_ARREADY;
  wire [3:0]axi_vip_mst_M_AXI_ARREGION;
  wire [2:0]axi_vip_mst_M_AXI_ARSIZE;
  wire axi_vip_mst_M_AXI_ARVALID;
  wire [31:0]axi_vip_mst_M_AXI_AWADDR;
  wire [1:0]axi_vip_mst_M_AXI_AWBURST;
  wire [3:0]axi_vip_mst_M_AXI_AWCACHE;
  wire [7:0]axi_vip_mst_M_AXI_AWLEN;
  wire [0:0]axi_vip_mst_M_AXI_AWLOCK;
  wire [2:0]axi_vip_mst_M_AXI_AWPROT;
  wire [3:0]axi_vip_mst_M_AXI_AWQOS;
  wire axi_vip_mst_M_AXI_AWREADY;
  wire [3:0]axi_vip_mst_M_AXI_AWREGION;
  wire [2:0]axi_vip_mst_M_AXI_AWSIZE;
  wire axi_vip_mst_M_AXI_AWVALID;
  wire axi_vip_mst_M_AXI_BREADY;
  wire [1:0]axi_vip_mst_M_AXI_BRESP;
  wire axi_vip_mst_M_AXI_BVALID;
  wire [31:0]axi_vip_mst_M_AXI_RDATA;
  wire axi_vip_mst_M_AXI_RLAST;
  wire axi_vip_mst_M_AXI_RREADY;
  wire [1:0]axi_vip_mst_M_AXI_RRESP;
  wire axi_vip_mst_M_AXI_RVALID;
  wire [31:0]axi_vip_mst_M_AXI_WDATA;
  wire axi_vip_mst_M_AXI_WLAST;
  wire axi_vip_mst_M_AXI_WREADY;
  wire [3:0]axi_vip_mst_M_AXI_WSTRB;
  wire axi_vip_mst_M_AXI_WVALID;
  wire [31:0]axi_vip_passthrough_M_AXI_ARADDR;
  wire [1:0]axi_vip_passthrough_M_AXI_ARBURST;
  wire [3:0]axi_vip_passthrough_M_AXI_ARCACHE;
  wire [7:0]axi_vip_passthrough_M_AXI_ARLEN;
  wire [0:0]axi_vip_passthrough_M_AXI_ARLOCK;
  wire [2:0]axi_vip_passthrough_M_AXI_ARPROT;
  wire [3:0]axi_vip_passthrough_M_AXI_ARQOS;
  wire axi_vip_passthrough_M_AXI_ARREADY;
  wire [3:0]axi_vip_passthrough_M_AXI_ARREGION;
  wire [2:0]axi_vip_passthrough_M_AXI_ARSIZE;
  wire axi_vip_passthrough_M_AXI_ARVALID;
  wire [31:0]axi_vip_passthrough_M_AXI_AWADDR;
  wire [1:0]axi_vip_passthrough_M_AXI_AWBURST;
  wire [3:0]axi_vip_passthrough_M_AXI_AWCACHE;
  wire [7:0]axi_vip_passthrough_M_AXI_AWLEN;
  wire [0:0]axi_vip_passthrough_M_AXI_AWLOCK;
  wire [2:0]axi_vip_passthrough_M_AXI_AWPROT;
  wire [3:0]axi_vip_passthrough_M_AXI_AWQOS;
  wire axi_vip_passthrough_M_AXI_AWREADY;
  wire [3:0]axi_vip_passthrough_M_AXI_AWREGION;
  wire [2:0]axi_vip_passthrough_M_AXI_AWSIZE;
  wire axi_vip_passthrough_M_AXI_AWVALID;
  wire axi_vip_passthrough_M_AXI_BREADY;
  wire [1:0]axi_vip_passthrough_M_AXI_BRESP;
  wire axi_vip_passthrough_M_AXI_BVALID;
  wire [31:0]axi_vip_passthrough_M_AXI_RDATA;
  wire axi_vip_passthrough_M_AXI_RLAST;
  wire axi_vip_passthrough_M_AXI_RREADY;
  wire [1:0]axi_vip_passthrough_M_AXI_RRESP;
  wire axi_vip_passthrough_M_AXI_RVALID;
  wire [31:0]axi_vip_passthrough_M_AXI_WDATA;
  wire axi_vip_passthrough_M_AXI_WLAST;
  wire axi_vip_passthrough_M_AXI_WREADY;
  wire [3:0]axi_vip_passthrough_M_AXI_WSTRB;
  wire axi_vip_passthrough_M_AXI_WVALID;

  assign aclk_1 = aclk;
  assign aresetn_1 = aresetn;
  ex_sim_axi_vip_mst_0 axi_vip_mst
       (.aclk(aclk_1),
        .aresetn(aresetn_1),
        .m_axi_araddr(axi_vip_mst_M_AXI_ARADDR),
        .m_axi_arburst(axi_vip_mst_M_AXI_ARBURST),
        .m_axi_arcache(axi_vip_mst_M_AXI_ARCACHE),
        .m_axi_arlen(axi_vip_mst_M_AXI_ARLEN),
        .m_axi_arlock(axi_vip_mst_M_AXI_ARLOCK),
        .m_axi_arprot(axi_vip_mst_M_AXI_ARPROT),
        .m_axi_arqos(axi_vip_mst_M_AXI_ARQOS),
        .m_axi_arready(axi_vip_mst_M_AXI_ARREADY),
        .m_axi_arregion(axi_vip_mst_M_AXI_ARREGION),
        .m_axi_arsize(axi_vip_mst_M_AXI_ARSIZE),
        .m_axi_arvalid(axi_vip_mst_M_AXI_ARVALID),
        .m_axi_awaddr(axi_vip_mst_M_AXI_AWADDR),
        .m_axi_awburst(axi_vip_mst_M_AXI_AWBURST),
        .m_axi_awcache(axi_vip_mst_M_AXI_AWCACHE),
        .m_axi_awlen(axi_vip_mst_M_AXI_AWLEN),
        .m_axi_awlock(axi_vip_mst_M_AXI_AWLOCK),
        .m_axi_awprot(axi_vip_mst_M_AXI_AWPROT),
        .m_axi_awqos(axi_vip_mst_M_AXI_AWQOS),
        .m_axi_awready(axi_vip_mst_M_AXI_AWREADY),
        .m_axi_awregion(axi_vip_mst_M_AXI_AWREGION),
        .m_axi_awsize(axi_vip_mst_M_AXI_AWSIZE),
        .m_axi_awvalid(axi_vip_mst_M_AXI_AWVALID),
        .m_axi_bready(axi_vip_mst_M_AXI_BREADY),
        .m_axi_bresp(axi_vip_mst_M_AXI_BRESP),
        .m_axi_bvalid(axi_vip_mst_M_AXI_BVALID),
        .m_axi_rdata(axi_vip_mst_M_AXI_RDATA),
        .m_axi_rlast(axi_vip_mst_M_AXI_RLAST),
        .m_axi_rready(axi_vip_mst_M_AXI_RREADY),
        .m_axi_rresp(axi_vip_mst_M_AXI_RRESP),
        .m_axi_rvalid(axi_vip_mst_M_AXI_RVALID),
        .m_axi_wdata(axi_vip_mst_M_AXI_WDATA),
        .m_axi_wlast(axi_vip_mst_M_AXI_WLAST),
        .m_axi_wready(axi_vip_mst_M_AXI_WREADY),
        .m_axi_wstrb(axi_vip_mst_M_AXI_WSTRB),
        .m_axi_wvalid(axi_vip_mst_M_AXI_WVALID));
  ex_sim_axi_vip_passthrough_0 axi_vip_passthrough
       (.aclk(aclk_1),
        .aresetn(aresetn_1),
        .m_axi_araddr(axi_vip_passthrough_M_AXI_ARADDR),
        .m_axi_arburst(axi_vip_passthrough_M_AXI_ARBURST),
        .m_axi_arcache(axi_vip_passthrough_M_AXI_ARCACHE),
        .m_axi_arlen(axi_vip_passthrough_M_AXI_ARLEN),
        .m_axi_arlock(axi_vip_passthrough_M_AXI_ARLOCK),
        .m_axi_arprot(axi_vip_passthrough_M_AXI_ARPROT),
        .m_axi_arqos(axi_vip_passthrough_M_AXI_ARQOS),
        .m_axi_arready(axi_vip_passthrough_M_AXI_ARREADY),
        .m_axi_arregion(axi_vip_passthrough_M_AXI_ARREGION),
        .m_axi_arsize(axi_vip_passthrough_M_AXI_ARSIZE),
        .m_axi_arvalid(axi_vip_passthrough_M_AXI_ARVALID),
        .m_axi_awaddr(axi_vip_passthrough_M_AXI_AWADDR),
        .m_axi_awburst(axi_vip_passthrough_M_AXI_AWBURST),
        .m_axi_awcache(axi_vip_passthrough_M_AXI_AWCACHE),
        .m_axi_awlen(axi_vip_passthrough_M_AXI_AWLEN),
        .m_axi_awlock(axi_vip_passthrough_M_AXI_AWLOCK),
        .m_axi_awprot(axi_vip_passthrough_M_AXI_AWPROT),
        .m_axi_awqos(axi_vip_passthrough_M_AXI_AWQOS),
        .m_axi_awready(axi_vip_passthrough_M_AXI_AWREADY),
        .m_axi_awregion(axi_vip_passthrough_M_AXI_AWREGION),
        .m_axi_awsize(axi_vip_passthrough_M_AXI_AWSIZE),
        .m_axi_awvalid(axi_vip_passthrough_M_AXI_AWVALID),
        .m_axi_bready(axi_vip_passthrough_M_AXI_BREADY),
        .m_axi_bresp(axi_vip_passthrough_M_AXI_BRESP),
        .m_axi_bvalid(axi_vip_passthrough_M_AXI_BVALID),
        .m_axi_rdata(axi_vip_passthrough_M_AXI_RDATA),
        .m_axi_rlast(axi_vip_passthrough_M_AXI_RLAST),
        .m_axi_rready(axi_vip_passthrough_M_AXI_RREADY),
        .m_axi_rresp(axi_vip_passthrough_M_AXI_RRESP),
        .m_axi_rvalid(axi_vip_passthrough_M_AXI_RVALID),
        .m_axi_wdata(axi_vip_passthrough_M_AXI_WDATA),
        .m_axi_wlast(axi_vip_passthrough_M_AXI_WLAST),
        .m_axi_wready(axi_vip_passthrough_M_AXI_WREADY),
        .m_axi_wstrb(axi_vip_passthrough_M_AXI_WSTRB),
        .m_axi_wvalid(axi_vip_passthrough_M_AXI_WVALID),
        .s_axi_araddr(axi_vip_mst_M_AXI_ARADDR),
        .s_axi_arburst(axi_vip_mst_M_AXI_ARBURST),
        .s_axi_arcache(axi_vip_mst_M_AXI_ARCACHE),
        .s_axi_arlen(axi_vip_mst_M_AXI_ARLEN),
        .s_axi_arlock(axi_vip_mst_M_AXI_ARLOCK),
        .s_axi_arprot(axi_vip_mst_M_AXI_ARPROT),
        .s_axi_arqos(axi_vip_mst_M_AXI_ARQOS),
        .s_axi_arready(axi_vip_mst_M_AXI_ARREADY),
        .s_axi_arregion(axi_vip_mst_M_AXI_ARREGION),
        .s_axi_arsize(axi_vip_mst_M_AXI_ARSIZE),
        .s_axi_arvalid(axi_vip_mst_M_AXI_ARVALID),
        .s_axi_awaddr(axi_vip_mst_M_AXI_AWADDR),
        .s_axi_awburst(axi_vip_mst_M_AXI_AWBURST),
        .s_axi_awcache(axi_vip_mst_M_AXI_AWCACHE),
        .s_axi_awlen(axi_vip_mst_M_AXI_AWLEN),
        .s_axi_awlock(axi_vip_mst_M_AXI_AWLOCK),
        .s_axi_awprot(axi_vip_mst_M_AXI_AWPROT),
        .s_axi_awqos(axi_vip_mst_M_AXI_AWQOS),
        .s_axi_awready(axi_vip_mst_M_AXI_AWREADY),
        .s_axi_awregion(axi_vip_mst_M_AXI_AWREGION),
        .s_axi_awsize(axi_vip_mst_M_AXI_AWSIZE),
        .s_axi_awvalid(axi_vip_mst_M_AXI_AWVALID),
        .s_axi_bready(axi_vip_mst_M_AXI_BREADY),
        .s_axi_bresp(axi_vip_mst_M_AXI_BRESP),
        .s_axi_bvalid(axi_vip_mst_M_AXI_BVALID),
        .s_axi_rdata(axi_vip_mst_M_AXI_RDATA),
        .s_axi_rlast(axi_vip_mst_M_AXI_RLAST),
        .s_axi_rready(axi_vip_mst_M_AXI_RREADY),
        .s_axi_rresp(axi_vip_mst_M_AXI_RRESP),
        .s_axi_rvalid(axi_vip_mst_M_AXI_RVALID),
        .s_axi_wdata(axi_vip_mst_M_AXI_WDATA),
        .s_axi_wlast(axi_vip_mst_M_AXI_WLAST),
        .s_axi_wready(axi_vip_mst_M_AXI_WREADY),
        .s_axi_wstrb(axi_vip_mst_M_AXI_WSTRB),
        .s_axi_wvalid(axi_vip_mst_M_AXI_WVALID));
  ex_sim_axi_vip_slv_0 axi_vip_slv
       (.aclk(aclk_1),
        .aresetn(aresetn_1),
        .s_axi_araddr(axi_vip_passthrough_M_AXI_ARADDR),
        .s_axi_arburst(axi_vip_passthrough_M_AXI_ARBURST),
        .s_axi_arcache(axi_vip_passthrough_M_AXI_ARCACHE),
        .s_axi_arlen(axi_vip_passthrough_M_AXI_ARLEN),
        .s_axi_arlock(axi_vip_passthrough_M_AXI_ARLOCK),
        .s_axi_arprot(axi_vip_passthrough_M_AXI_ARPROT),
        .s_axi_arqos(axi_vip_passthrough_M_AXI_ARQOS),
        .s_axi_arready(axi_vip_passthrough_M_AXI_ARREADY),
        .s_axi_arregion(axi_vip_passthrough_M_AXI_ARREGION),
        .s_axi_arsize(axi_vip_passthrough_M_AXI_ARSIZE),
        .s_axi_arvalid(axi_vip_passthrough_M_AXI_ARVALID),
        .s_axi_awaddr(axi_vip_passthrough_M_AXI_AWADDR),
        .s_axi_awburst(axi_vip_passthrough_M_AXI_AWBURST),
        .s_axi_awcache(axi_vip_passthrough_M_AXI_AWCACHE),
        .s_axi_awlen(axi_vip_passthrough_M_AXI_AWLEN),
        .s_axi_awlock(axi_vip_passthrough_M_AXI_AWLOCK),
        .s_axi_awprot(axi_vip_passthrough_M_AXI_AWPROT),
        .s_axi_awqos(axi_vip_passthrough_M_AXI_AWQOS),
        .s_axi_awready(axi_vip_passthrough_M_AXI_AWREADY),
        .s_axi_awregion(axi_vip_passthrough_M_AXI_AWREGION),
        .s_axi_awsize(axi_vip_passthrough_M_AXI_AWSIZE),
        .s_axi_awvalid(axi_vip_passthrough_M_AXI_AWVALID),
        .s_axi_bready(axi_vip_passthrough_M_AXI_BREADY),
        .s_axi_bresp(axi_vip_passthrough_M_AXI_BRESP),
        .s_axi_bvalid(axi_vip_passthrough_M_AXI_BVALID),
        .s_axi_rdata(axi_vip_passthrough_M_AXI_RDATA),
        .s_axi_rlast(axi_vip_passthrough_M_AXI_RLAST),
        .s_axi_rready(axi_vip_passthrough_M_AXI_RREADY),
        .s_axi_rresp(axi_vip_passthrough_M_AXI_RRESP),
        .s_axi_rvalid(axi_vip_passthrough_M_AXI_RVALID),
        .s_axi_wdata(axi_vip_passthrough_M_AXI_WDATA),
        .s_axi_wlast(axi_vip_passthrough_M_AXI_WLAST),
        .s_axi_wready(axi_vip_passthrough_M_AXI_WREADY),
        .s_axi_wstrb(axi_vip_passthrough_M_AXI_WSTRB),
        .s_axi_wvalid(axi_vip_passthrough_M_AXI_WVALID));
endmodule
