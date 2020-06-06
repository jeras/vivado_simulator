//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Fri Jun  5 21:06:17 2020
//Host        : Agrajag running 64-bit Ubuntu 18.04.4 LTS
//Command     : generate_target ex_sim.bd
//Design      : ex_sim
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

import axi_if_pkg::*;

module ex_sim (
  input  logic aclk,
  input  logic aresetn
);

localparam axi_prm_t C_AXI = '{
  PROTOCOL        : 2,
  INTERFACE_MODE  : 1,
  ADDR_WIDTH      : 32,
  WDATA_WIDTH     : 32,
  RDATA_WIDTH     : 32,
  WID_WIDTH       : 0,
  RID_WIDTH       : 0,
  AWUSER_WIDTH    : 0,
  ARUSER_WIDTH    : 0,
  WUSER_WIDTH     : 0,
  RUSER_WIDTH     : 0,
  BUSER_WIDTH     : 0,
  SUPPORTS_NARROW : 0,
  HAS_BURST       : 0,
  HAS_LOCK        : 0,
  HAS_CACHE       : 0,
  HAS_REGION      : 0,
  HAS_PROT        : 1,
  HAS_QOS         : 0,
  HAS_WSTRB       : 1,
  HAS_BRESP       : 1,
  HAS_RRESP       : 1,
  HAS_ARESETN     : 1
};

logic aclken = 1'b1;

axi_if #(
  .C_AXI_PROTOCOL        (C_AXI.PROTOCOL       ),
//.C_AXI_INTERFACE_MODE  (C_AXI.INTERFACE_MODE ),
  .C_AXI_ADDR_WIDTH      (C_AXI.ADDR_WIDTH     ),
  .C_AXI_WDATA_WIDTH     (C_AXI.WDATA_WIDTH    ),
  .C_AXI_RDATA_WIDTH     (C_AXI.RDATA_WIDTH    ),
  .C_AXI_WID_WIDTH       (C_AXI.WID_WIDTH      ),
  .C_AXI_RID_WIDTH       (C_AXI.RID_WIDTH      ),
  .C_AXI_AWUSER_WIDTH    (C_AXI.AWUSER_WIDTH   ),
  .C_AXI_ARUSER_WIDTH    (C_AXI.ARUSER_WIDTH   ),
  .C_AXI_WUSER_WIDTH     (C_AXI.WUSER_WIDTH    ),
  .C_AXI_RUSER_WIDTH     (C_AXI.RUSER_WIDTH    ),
  .C_AXI_BUSER_WIDTH     (C_AXI.BUSER_WIDTH    ),
  .C_AXI_SUPPORTS_NARROW (C_AXI.SUPPORTS_NARROW),
  .C_AXI_HAS_BURST       (C_AXI.HAS_BURST      ),
  .C_AXI_HAS_LOCK        (C_AXI.HAS_LOCK       ),
  .C_AXI_HAS_CACHE       (C_AXI.HAS_CACHE      ),
  .C_AXI_HAS_REGION      (C_AXI.HAS_REGION     ),
  .C_AXI_HAS_PROT        (C_AXI.HAS_PROT       ),
  .C_AXI_HAS_QOS         (C_AXI.HAS_QOS        ),
  .C_AXI_HAS_WSTRB       (C_AXI.HAS_WSTRB      ),
  .C_AXI_HAS_BRESP       (C_AXI.HAS_BRESP      ),
  .C_AXI_HAS_RRESP       (C_AXI.HAS_RRESP      ),
  .C_AXI_HAS_ARESETN     (C_AXI.HAS_ARESETN    )
) axi_mst (
  .ACLK    (aclk),
  .ACLKEN  (aclken),
  .ARESETn (aresetn)
);

axi_if #(
  .C_AXI_PROTOCOL        (C_AXI.PROTOCOL       ),
  .C_AXI_INTERFACE_MODE  (C_AXI.INTERFACE_MODE ),
  .C_AXI_ADDR_WIDTH      (C_AXI.ADDR_WIDTH     ),
  .C_AXI_WDATA_WIDTH     (C_AXI.WDATA_WIDTH    ),
  .C_AXI_RDATA_WIDTH     (C_AXI.RDATA_WIDTH    ),
  .C_AXI_WID_WIDTH       (C_AXI.WID_WIDTH      ),
  .C_AXI_RID_WIDTH       (C_AXI.RID_WIDTH      ),
  .C_AXI_AWUSER_WIDTH    (C_AXI.AWUSER_WIDTH   ),
  .C_AXI_ARUSER_WIDTH    (C_AXI.ARUSER_WIDTH   ),
  .C_AXI_WUSER_WIDTH     (C_AXI.WUSER_WIDTH    ),
  .C_AXI_RUSER_WIDTH     (C_AXI.RUSER_WIDTH    ),
  .C_AXI_BUSER_WIDTH     (C_AXI.BUSER_WIDTH    ),
  .C_AXI_SUPPORTS_NARROW (C_AXI.SUPPORTS_NARROW),
  .C_AXI_HAS_BURST       (C_AXI.HAS_BURST      ),
  .C_AXI_HAS_LOCK        (C_AXI.HAS_LOCK       ),
  .C_AXI_HAS_CACHE       (C_AXI.HAS_CACHE      ),
  .C_AXI_HAS_REGION      (C_AXI.HAS_REGION     ),
  .C_AXI_HAS_PROT        (C_AXI.HAS_PROT       ),
  .C_AXI_HAS_QOS         (C_AXI.HAS_QOS        ),
  .C_AXI_HAS_WSTRB       (C_AXI.HAS_WSTRB      ),
  .C_AXI_HAS_BRESP       (C_AXI.HAS_BRESP      ),
  .C_AXI_HAS_RRESP       (C_AXI.HAS_RRESP      ),
  .C_AXI_HAS_ARESETN     (C_AXI.HAS_ARESETN    )
) axi_slv (
  .ACLK    (aclk),
  .ACLKEN  (aclken),
  .ARESETn (aresetn)
);

ex_sim_axi_vip_mst_0 #(
  .PROTOCOL        (C_AXI.PROTOCOL       ),
//.INTERFACE_MODE  (C_AXI.INTERFACE_MODE ),
  .ADDR_WIDTH      (C_AXI.ADDR_WIDTH     ),
  .WDATA_WIDTH     (C_AXI.WDATA_WIDTH    ),
  .RDATA_WIDTH     (C_AXI.RDATA_WIDTH    ),
  .WID_WIDTH       (C_AXI.WID_WIDTH      ),
  .RID_WIDTH       (C_AXI.RID_WIDTH      ),
  .AWUSER_WIDTH    (C_AXI.AWUSER_WIDTH   ),
  .ARUSER_WIDTH    (C_AXI.ARUSER_WIDTH   ),
  .WUSER_WIDTH     (C_AXI.WUSER_WIDTH    ),
  .RUSER_WIDTH     (C_AXI.RUSER_WIDTH    ),
  .BUSER_WIDTH     (C_AXI.BUSER_WIDTH    ),
  .SUPPORTS_NARROW (C_AXI.SUPPORTS_NARROW),
  .HAS_BURST       (C_AXI.HAS_BURST      ),
  .HAS_LOCK        (C_AXI.HAS_LOCK       ),
  .HAS_CACHE       (C_AXI.HAS_CACHE      ),
  .HAS_REGION      (C_AXI.HAS_REGION     ),
  .HAS_PROT        (C_AXI.HAS_PROT       ),
  .HAS_QOS         (C_AXI.HAS_QOS        ),
  .HAS_WSTRB       (C_AXI.HAS_WSTRB      ),
  .HAS_BRESP       (C_AXI.HAS_BRESP      ),
  .HAS_RRESP       (C_AXI.HAS_RRESP      ),
  .HAS_ARESETN     (C_AXI.HAS_ARESETN    )
) axi_vip_mst (
  .m_axi (axi_mst)
);

ex_sim_axi_vip_passthrough_0 #(
  .PROTOCOL        (C_AXI.PROTOCOL       ),
//.INTERFACE_MODE  (C_AXI.INTERFACE_MODE ),
  .ADDR_WIDTH      (C_AXI.ADDR_WIDTH     ),
  .WDATA_WIDTH     (C_AXI.WDATA_WIDTH    ),
  .RDATA_WIDTH     (C_AXI.RDATA_WIDTH    ),
  .WID_WIDTH       (C_AXI.WID_WIDTH      ),
  .RID_WIDTH       (C_AXI.RID_WIDTH      ),
  .AWUSER_WIDTH    (C_AXI.AWUSER_WIDTH   ),
  .ARUSER_WIDTH    (C_AXI.ARUSER_WIDTH   ),
  .WUSER_WIDTH     (C_AXI.WUSER_WIDTH    ),
  .RUSER_WIDTH     (C_AXI.RUSER_WIDTH    ),
  .BUSER_WIDTH     (C_AXI.BUSER_WIDTH    ),
  .SUPPORTS_NARROW (C_AXI.SUPPORTS_NARROW),
  .HAS_BURST       (C_AXI.HAS_BURST      ),
  .HAS_LOCK        (C_AXI.HAS_LOCK       ),
  .HAS_CACHE       (C_AXI.HAS_CACHE      ),
  .HAS_REGION      (C_AXI.HAS_REGION     ),
  .HAS_PROT        (C_AXI.HAS_PROT       ),
  .HAS_QOS         (C_AXI.HAS_QOS        ),
  .HAS_WSTRB       (C_AXI.HAS_WSTRB      ),
  .HAS_BRESP       (C_AXI.HAS_BRESP      ),
  .HAS_RRESP       (C_AXI.HAS_RRESP      ),
  .HAS_ARESETN     (C_AXI.HAS_ARESETN    )
) axi_vip_passthrough (
  .s_axi (axi_mst),
  .m_axi (axi_slv)
);

ex_sim_axi_vip_slv_0 #(
  .PROTOCOL        (C_AXI.PROTOCOL       ),
//.INTERFACE_MODE  (C_AXI.INTERFACE_MODE ),
  .ADDR_WIDTH      (C_AXI.ADDR_WIDTH     ),
  .WDATA_WIDTH     (C_AXI.WDATA_WIDTH    ),
  .RDATA_WIDTH     (C_AXI.RDATA_WIDTH    ),
  .WID_WIDTH       (C_AXI.WID_WIDTH      ),
  .RID_WIDTH       (C_AXI.RID_WIDTH      ),
  .AWUSER_WIDTH    (C_AXI.AWUSER_WIDTH   ),
  .ARUSER_WIDTH    (C_AXI.ARUSER_WIDTH   ),
  .WUSER_WIDTH     (C_AXI.WUSER_WIDTH    ),
  .RUSER_WIDTH     (C_AXI.RUSER_WIDTH    ),
  .BUSER_WIDTH     (C_AXI.BUSER_WIDTH    ),
  .SUPPORTS_NARROW (C_AXI.SUPPORTS_NARROW),
  .HAS_BURST       (C_AXI.HAS_BURST      ),
  .HAS_LOCK        (C_AXI.HAS_LOCK       ),
  .HAS_CACHE       (C_AXI.HAS_CACHE      ),
  .HAS_REGION      (C_AXI.HAS_REGION     ),
  .HAS_PROT        (C_AXI.HAS_PROT       ),
  .HAS_QOS         (C_AXI.HAS_QOS        ),
  .HAS_WSTRB       (C_AXI.HAS_WSTRB      ),
  .HAS_BRESP       (C_AXI.HAS_BRESP      ),
  .HAS_RRESP       (C_AXI.HAS_RRESP      ),
  .HAS_ARESETN     (C_AXI.HAS_ARESETN    )
) axi_vip_slv (
  .s_axi (axi_slv)
);

endmodule: ex_sim
