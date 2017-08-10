`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module axi4stream_vip_mst_0 (
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLOCK CLK" *)
  input  logic         aclk,
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RESET RST" *)
  input  logic         aresetn,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *)
  output logic [0 : 0] m_axis_tvalid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *)
  input  logic [0 : 0] m_axis_tready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *)
  output logic [7 : 0] m_axis_tdata
);

axi4stream_vip_v1_0_1_top #(
  .C_AXI4STREAM_SIGNAL_SET         ('H00000003),
  .C_AXI4STREAM_INTERFACE_MODE     (0),
  .C_AXI4STREAM_DATA_WIDTH         (8),
  .C_AXI4STREAM_USER_BITS_PER_BYTE (0),
  .C_AXI4STREAM_ID_WIDTH           (0),
  .C_AXI4STREAM_DEST_WIDTH         (0),
  .C_AXI4STREAM_USER_WIDTH         (0),
  .C_AXI4STREAM_HAS_ARESETN        (1)
) inst (
  // system
  .aclk          (aclk),
  .aresetn       (aresetn),
  .aclken        (1'B1),
  // slave
  .s_axis_tvalid (1'B0),
  .s_axis_tready (),
  .s_axis_tdata  (8'B0),
  .s_axis_tstrb  (1'B0),
  .s_axis_tkeep  (1'B0),
  .s_axis_tlast  (1'B0),
  .s_axis_tid    (1'B0),
  .s_axis_tdest  (1'B0),
  .s_axis_tuser  (1'B0),
  // master
  .m_axis_tvalid (m_axis_tvalid),
  .m_axis_tready (m_axis_tready),
  .m_axis_tdata  (m_axis_tdata),
  .m_axis_tstrb  (),
  .m_axis_tkeep  (),
  .m_axis_tlast  (),
  .m_axis_tid    (),
  .m_axis_tdest  (),
  .m_axis_tuser  ()
);

endmodule: axi4stream_vip_mst_0
