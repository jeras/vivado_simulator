// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:ip:axi_vip:1.0
// IP Revision: 2

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module ex_sim_axi_vip_mst_0 (
  axi4_if.m m_axi
);

axi_vip_v1_0_2_top #(
  .C_AXI_PROTOCOL        (0),
  .C_AXI_INTERFACE_MODE  (0),
  .C_AXI_ADDR_WIDTH      (32),
  .C_AXI_WDATA_WIDTH     (32),
  .C_AXI_RDATA_WIDTH     (32),
  .C_AXI_WID_WIDTH       (0),
  .C_AXI_RID_WIDTH       (0),
  .C_AXI_AWUSER_WIDTH    (0),
  .C_AXI_ARUSER_WIDTH    (0),
  .C_AXI_WUSER_WIDTH     (0),
  .C_AXI_RUSER_WIDTH     (0),
  .C_AXI_BUSER_WIDTH     (0),
  .C_AXI_SUPPORTS_NARROW (1),
  .C_AXI_HAS_BURST       (1),
  .C_AXI_HAS_LOCK        (1),
  .C_AXI_HAS_CACHE       (1),
  .C_AXI_HAS_REGION      (1),
  .C_AXI_HAS_PROT        (1),
  .C_AXI_HAS_QOS         (1),
  .C_AXI_HAS_WSTRB       (1),
  .C_AXI_HAS_BRESP       (1),
  .C_AXI_HAS_RRESP       (1),
  .C_AXI_HAS_ARESETN     (1)
) inst (
  .aclk           (m_axi.ACLK),
  .aclken         (1'B1),
  .aresetn        (m_axi.ARESETn),

  .s_axi_awid     (1'B0),
  .s_axi_awaddr   (32'B0),
  .s_axi_awlen    (8'B0),
  .s_axi_awsize   (3'D2),
  .s_axi_awburst  (2'B1),
  .s_axi_awlock   (1'B0),
  .s_axi_awcache  (4'B0),
  .s_axi_awprot   (3'B0),
  .s_axi_awregion (4'B0),
  .s_axi_awqos    (4'B0),
  .s_axi_awuser   (1'B0),
  .s_axi_awvalid  (1'B0),
  .s_axi_awready  (),
  .s_axi_wid      (1'B0),
  .s_axi_wdata    (32'B0),
  .s_axi_wstrb    (4'HF),
  .s_axi_wlast    (1'B0),
  .s_axi_wuser    (1'B0),
  .s_axi_wvalid   (1'B0),
  .s_axi_wready   (),
  .s_axi_bid      (),
  .s_axi_bresp    (),
  .s_axi_buser    (),
  .s_axi_bvalid   (),
  .s_axi_bready   (1'B0),
  .s_axi_arid     (1'B0),
  .s_axi_araddr   (32'B0),
  .s_axi_arlen    (8'B0),
  .s_axi_arsize   (3'D2),
  .s_axi_arburst  (2'B1),
  .s_axi_arlock   (1'B0),
  .s_axi_arcache  (4'B0),
  .s_axi_arprot   (3'B0),
  .s_axi_arregion (4'B0),
  .s_axi_arqos    (4'B0),
  .s_axi_aruser   (1'B0),
  .s_axi_arvalid  (1'B0),
  .s_axi_arready  (),
  .s_axi_rid      (),
  .s_axi_rdata    (),
  .s_axi_rresp    (),
  .s_axi_rlast    (),
  .s_axi_ruser    (),
  .s_axi_rvalid   (),
  .s_axi_rready   (1'B0),

  .m_axi_awid     (),
  .m_axi_awaddr   (m_axi.AWADDR),
  .m_axi_awlen    (m_axi.AWLEN),
  .m_axi_awsize   (m_axi.AWSIZE),
  .m_axi_awburst  (m_axi.AWBURST),
  .m_axi_awlock   (m_axi.AWLOCK),
  .m_axi_awcache  (m_axi.AWCACHE),
  .m_axi_awprot   (m_axi.AWPROT),
  .m_axi_awregion (m_axi.AWREGION),
  .m_axi_awqos    (m_axi.AWQOS),
  .m_axi_awuser   (),
  .m_axi_awvalid  (m_axi.AWVALID),
  .m_axi_awready  (m_axi.AWREADY),
  .m_axi_wid      (),
  .m_axi_wdata    (m_axi.WDATA),
  .m_axi_wstrb    (m_axi.WSTRB),
  .m_axi_wlast    (m_axi.WLAST),
  .m_axi_wuser    (),
  .m_axi_wvalid   (m_axi.WVALID),
  .m_axi_wready   (m_axi.WREADY),
  .m_axi_bid      (1'B0),
  .m_axi_bresp    (m_axi.BRESP),
  .m_axi_buser    (1'B0),
  .m_axi_bvalid   (m_axi.BVALID),
  .m_axi_bready   (m_axi.BREADY),
  .m_axi_arid     (),
  .m_axi_araddr   (m_axi.ARADDR),
  .m_axi_arlen    (m_axi.ARLEN),
  .m_axi_arsize   (m_axi.ARSIZE),
  .m_axi_arburst  (m_axi.ARBURST),
  .m_axi_arlock   (m_axi.ARLOCK),
  .m_axi_arcache  (m_axi.ARCACHE),
  .m_axi_arprot   (m_axi.ARPROT),
  .m_axi_arregion (m_axi.ARREGION),
  .m_axi_arqos    (m_axi.ARQOS),
  .m_axi_aruser   (),
  .m_axi_arvalid  (m_axi.ARVALID),
  .m_axi_arready  (m_axi.ARREADY),
  .m_axi_rid      (1'B0),
  .m_axi_rdata    (m_axi.RDATA),
  .m_axi_rresp    (m_axi.RRESP),
  .m_axi_rlast    (m_axi.RLAST),
  .m_axi_ruser    (1'B0),
  .m_axi_rvalid   (m_axi.RVALID),
  .m_axi_rready   (m_axi.RREADY)
);

endmodule: ex_sim_axi_vip_mst_0
