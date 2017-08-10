`timescale 1ns/1ps

module axi4stream_vip_slv_0 (
  axi4_stream_if.d s_axis  // AXI4-Stream drain
);

import axi4stream_vip_slv_0_pkg::*;

axi4stream_vip_v1_0_1_top #(
  .C_AXI4STREAM_SIGNAL_SET         (axi4stream_vip_slv_0_VIP_SIGNAL_SET        ),
  .C_AXI4STREAM_INTERFACE_MODE     (axi4stream_vip_slv_0_VIP_INTERFACE_MODE    ),
  .C_AXI4STREAM_DATA_WIDTH         (axi4stream_vip_slv_0_VIP_DATA_WIDTH        ),
  .C_AXI4STREAM_USER_BITS_PER_BYTE (axi4stream_vip_slv_0_VIP_USER_BITS_PER_BYTE),
  .C_AXI4STREAM_ID_WIDTH           (axi4stream_vip_slv_0_VIP_ID_WIDTH          ),
  .C_AXI4STREAM_DEST_WIDTH         (axi4stream_vip_slv_0_VIP_DEST_WIDTH        ),
  .C_AXI4STREAM_USER_WIDTH         (axi4stream_vip_slv_0_VIP_USER_WIDTH        ),
  .C_AXI4STREAM_HAS_ARESETN        (axi4stream_vip_slv_0_VIP_HAS_ARESETN       )
) inst (
  // system
  .aclk          (s_axis.ACLK),
  .aresetn       (s_axis.ARESETn),
  .aclken        (1'B1),
  // slave
  .s_axis_tvalid (s_axis.TVALID),
  .s_axis_tready (s_axis.TREADY),
  .s_axis_tdata  (s_axis.TDATA),
  .s_axis_tstrb  (1'B0),
  .s_axis_tkeep  (1'B0),
  .s_axis_tlast  (1'B0),
  .s_axis_tid    (1'B0),
  .s_axis_tdest  (1'B0),
  .s_axis_tuser  (1'B0),
  // master
  .m_axis_tvalid (),
  .m_axis_tready (1'B0),
  .m_axis_tdata  (),
  .m_axis_tstrb  (),
  .m_axis_tkeep  (),
  .m_axis_tlast  (),
  .m_axis_tid    (),
  .m_axis_tdest  (),
  .m_axis_tuser  ()
);

endmodule: axi4stream_vip_slv_0
