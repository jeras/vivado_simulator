package axi4stream_vip_slv_0_pkg;

import axi4stream_vip_pkg::*;

parameter axi4stream_vip_slv_0_VIP_INTERFACE_MODE     = 2;
parameter axi4stream_vip_slv_0_VIP_SIGNAL_SET         = 8'B00000011;
parameter axi4stream_vip_slv_0_VIP_DATA_WIDTH         = 8;
parameter axi4stream_vip_slv_0_VIP_ID_WIDTH           = 0;
parameter axi4stream_vip_slv_0_VIP_DEST_WIDTH         = 0;
parameter axi4stream_vip_slv_0_VIP_USER_WIDTH         = 0;
parameter axi4stream_vip_slv_0_VIP_USER_BITS_PER_BYTE = 0;
parameter axi4stream_vip_slv_0_VIP_HAS_TREADY         = 1;
parameter axi4stream_vip_slv_0_VIP_HAS_TSTRB          = 0;
parameter axi4stream_vip_slv_0_VIP_HAS_TKEEP          = 0;
parameter axi4stream_vip_slv_0_VIP_HAS_TLAST          = 0;
parameter axi4stream_vip_slv_0_VIP_HAS_ACLKEN         = 0;
parameter axi4stream_vip_slv_0_VIP_HAS_ARESETN        = 1;

typedef axi4stream_slv_agent #(
  axi4stream_vip_slv_0_VIP_SIGNAL_SET, 
  axi4stream_vip_slv_0_VIP_DEST_WIDTH,
  axi4stream_vip_slv_0_VIP_DATA_WIDTH,
  axi4stream_vip_slv_0_VIP_ID_WIDTH,
  axi4stream_vip_slv_0_VIP_USER_WIDTH, 
  axi4stream_vip_slv_0_VIP_USER_BITS_PER_BYTE,
  axi4stream_vip_slv_0_VIP_HAS_ARESETN
) axi4stream_vip_slv_0_slv_t;
      
endpackage : axi4stream_vip_slv_0_pkg
