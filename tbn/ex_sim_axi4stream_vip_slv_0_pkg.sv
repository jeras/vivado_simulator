package ex_sim_axi4stream_vip_slv_0_pkg;

import axi4stream_vip_v1_0_1_pkg::*;

///////////////////////////////////////////////////////////////////////////
// These parameters are named after the component for use in your verification 
// environment.
///////////////////////////////////////////////////////////////////////////

parameter ex_sim_axi4stream_vip_slv_0_VIP_INTERFACE_MODE     = 2;
parameter ex_sim_axi4stream_vip_slv_0_VIP_SIGNAL_SET         = 8'b00000011;
parameter ex_sim_axi4stream_vip_slv_0_VIP_DATA_WIDTH         = 8;
parameter ex_sim_axi4stream_vip_slv_0_VIP_ID_WIDTH           = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_DEST_WIDTH         = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_USER_WIDTH         = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_USER_BITS_PER_BYTE = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_HAS_TREADY         = 1;
parameter ex_sim_axi4stream_vip_slv_0_VIP_HAS_TSTRB          = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_HAS_TKEEP          = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_HAS_TLAST          = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_HAS_ACLKEN         = 0;
parameter ex_sim_axi4stream_vip_slv_0_VIP_HAS_ARESETN        = 1;

typedef axi4stream_slv_agent #(
  ex_sim_axi4stream_vip_slv_0_VIP_SIGNAL_SET, 
  ex_sim_axi4stream_vip_slv_0_VIP_DEST_WIDTH,
  ex_sim_axi4stream_vip_slv_0_VIP_DATA_WIDTH,
  ex_sim_axi4stream_vip_slv_0_VIP_ID_WIDTH,
  ex_sim_axi4stream_vip_slv_0_VIP_USER_WIDTH, 
  ex_sim_axi4stream_vip_slv_0_VIP_USER_BITS_PER_BYTE,
  ex_sim_axi4stream_vip_slv_0_VIP_HAS_ARESETN
) ex_sim_axi4stream_vip_slv_0_slv_t;
      
endpackage : ex_sim_axi4stream_vip_slv_0_pkg
