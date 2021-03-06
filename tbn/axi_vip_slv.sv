// (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
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


// IP VLNV: xilinx.com:ip:axi_vip:1.1
// IP Revision: 6

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module axi_vip_slv #(
  int unsigned PROTOCOL        = 0,
  int unsigned INTERFACE_MODE  = 2,
  int unsigned ADDR_WIDTH      = 32,
  int unsigned WDATA_WIDTH     = 32,
  int unsigned RDATA_WIDTH     = 32,
  int unsigned WID_WIDTH       = 0,
  int unsigned RID_WIDTH       = 0,
  int unsigned AWUSER_WIDTH    = 0,
  int unsigned ARUSER_WIDTH    = 0,
  int unsigned WUSER_WIDTH     = 0,
  int unsigned RUSER_WIDTH     = 0,
  int unsigned BUSER_WIDTH     = 0,
  int unsigned SUPPORTS_NARROW = 0,
  int unsigned HAS_BURST       = 0,
  int unsigned HAS_LOCK        = 0,
  int unsigned HAS_CACHE       = 0,
  int unsigned HAS_REGION      = 0,
  int unsigned HAS_PROT        = 1,
  int unsigned HAS_QOS         = 0,
  int unsigned HAS_WSTRB       = 1,
  int unsigned HAS_BRESP       = 1,
  int unsigned HAS_RRESP       = 1,
  int unsigned HAS_ARESETN     = 1
)(
  axi_if.s s_axi
);

axi_vip_v1_1_7_top #(
  .C_AXI_PROTOCOL        (PROTOCOL       ),
  .C_AXI_INTERFACE_MODE  (2),
  .C_AXI_ADDR_WIDTH      (ADDR_WIDTH     ),
  .C_AXI_WDATA_WIDTH     (WDATA_WIDTH    ),
  .C_AXI_RDATA_WIDTH     (RDATA_WIDTH    ),
  .C_AXI_WID_WIDTH       (WID_WIDTH      ),
  .C_AXI_RID_WIDTH       (RID_WIDTH      ),
  .C_AXI_AWUSER_WIDTH    (AWUSER_WIDTH   ),
  .C_AXI_ARUSER_WIDTH    (ARUSER_WIDTH   ),
  .C_AXI_WUSER_WIDTH     (WUSER_WIDTH    ),
  .C_AXI_RUSER_WIDTH     (RUSER_WIDTH    ),
  .C_AXI_BUSER_WIDTH     (BUSER_WIDTH    ),
  .C_AXI_SUPPORTS_NARROW (SUPPORTS_NARROW),
  .C_AXI_HAS_BURST       (HAS_BURST      ),
  .C_AXI_HAS_LOCK        (HAS_LOCK       ),
  .C_AXI_HAS_CACHE       (HAS_CACHE      ),
  .C_AXI_HAS_REGION      (HAS_REGION     ),
  .C_AXI_HAS_PROT        (HAS_PROT       ),
  .C_AXI_HAS_QOS         (HAS_QOS        ),
  .C_AXI_HAS_WSTRB       (HAS_WSTRB      ),
  .C_AXI_HAS_BRESP       (HAS_BRESP      ),
  .C_AXI_HAS_RRESP       (HAS_RRESP      ),
  .C_AXI_HAS_ARESETN     (HAS_ARESETN    )
) inst (
  .aclk           (s_axi.ACLK),
  .aclken         (s_axi.ACLKEN),
  .aresetn        (s_axi.ARESETn),

  .s_axi_awid     (s_axi.AWID    ),
  .s_axi_awaddr   (s_axi.AWADDR  ),
  .s_axi_awlen    (s_axi.AWLEN   ),
  .s_axi_awsize   (s_axi.AWSIZE  ),
  .s_axi_awburst  (s_axi.AWBURST ),
  .s_axi_awlock   (s_axi.AWLOCK  ),
  .s_axi_awcache  (s_axi.AWCACHE ),
  .s_axi_awprot   (s_axi.AWPROT  ),
  .s_axi_awregion (s_axi.AWREGION),
  .s_axi_awqos    (s_axi.AWQOS   ),
  .s_axi_awuser   (s_axi.AWUSER  ),
  .s_axi_awvalid  (s_axi.AWVALID ),
  .s_axi_awready  (s_axi.AWREADY ),
  .s_axi_wid      (s_axi.WID     ),
  .s_axi_wdata    (s_axi.WDATA   ),
  .s_axi_wstrb    (s_axi.WSTRB   ),
  .s_axi_wlast    (s_axi.WLAST   ),
  .s_axi_wuser    (s_axi.WUSER   ),
  .s_axi_wvalid   (s_axi.WVALID  ),
  .s_axi_wready   (s_axi.WREADY  ),
  .s_axi_bid      (s_axi.BID     ),
  .s_axi_bresp    (s_axi.BRESP   ),
  .s_axi_buser    (s_axi.BUSER   ),
  .s_axi_bvalid   (s_axi.BVALID  ),
  .s_axi_bready   (s_axi.BREADY  ),
  .s_axi_arid     (s_axi.ARID    ),
  .s_axi_araddr   (s_axi.ARADDR  ),
  .s_axi_arlen    (s_axi.ARLEN   ),
  .s_axi_arsize   (s_axi.ARSIZE  ),
  .s_axi_arburst  (s_axi.ARBURST ),
  .s_axi_arlock   (s_axi.ARLOCK  ),
  .s_axi_arcache  (s_axi.ARCACHE ),
  .s_axi_arprot   (s_axi.ARPROT  ),
  .s_axi_arregion (s_axi.ARREGION),
  .s_axi_arqos    (s_axi.ARQOS   ),
  .s_axi_aruser   (s_axi.ARUSER  ),
  .s_axi_arvalid  (s_axi.ARVALID ),
  .s_axi_arready  (s_axi.ARREADY ),
  .s_axi_rid      (s_axi.RID     ),
  .s_axi_rdata    (s_axi.RDATA   ),
  .s_axi_rresp    (s_axi.RRESP   ),
  .s_axi_rlast    (s_axi.RLAST   ),
  .s_axi_ruser    (s_axi.RUSER   ),
  .s_axi_rvalid   (s_axi.RVALID  ),
  .s_axi_rready   (s_axi.RREADY  ),

  .m_axi_awid     (),
  .m_axi_awaddr   (),
  .m_axi_awlen    (),
  .m_axi_awsize   (),
  .m_axi_awburst  (),
  .m_axi_awlock   (),
  .m_axi_awcache  (),
  .m_axi_awprot   (),
  .m_axi_awregion (),
  .m_axi_awqos    (),
  .m_axi_awuser   (),
  .m_axi_awvalid  (),
  .m_axi_awready  (1'B0),
  .m_axi_wid      (),
  .m_axi_wdata    (),
  .m_axi_wstrb    (),
  .m_axi_wlast    (),
  .m_axi_wuser    (),
  .m_axi_wvalid   (),
  .m_axi_wready   (1'B0),
  .m_axi_bid      (1'B0),
  .m_axi_bresp    (2'B0),
  .m_axi_buser    (1'B0),
  .m_axi_bvalid   (1'B0),
  .m_axi_bready   (),
  .m_axi_arid     (),
  .m_axi_araddr   (),
  .m_axi_arlen    (),
  .m_axi_arsize   (),
  .m_axi_arburst  (),
  .m_axi_arlock   (),
  .m_axi_arcache  (),
  .m_axi_arprot   (),
  .m_axi_arregion (),
  .m_axi_arqos    (),
  .m_axi_aruser   (),
  .m_axi_arvalid  (),
  .m_axi_arready  (1'B0),
  .m_axi_rid      (1'B0),
  .m_axi_rdata    (32'B0),
  .m_axi_rresp    (2'B0),
  .m_axi_rlast    (1'B0),
  .m_axi_ruser    (1'B0),
  .m_axi_rvalid   (1'B0),
  .m_axi_rready   ()
);

endmodule: axi_vip_slv
