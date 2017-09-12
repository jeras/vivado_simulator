//-----------------------------------------------------------------------------------------------------
// Description: 
// This file contains example test which shows how Master VIP generate transaction and how Slave 
// VIP (with memory model) responds.
// The example design consists of one AXI VIP in master mode, one AXI VIP in passthrough mode 
// and one AXI VIP in slave mode.
// It includes master agent stimulus, slave memory agent stimulus and generic testbench file. 
// Please refer axi_vip_0_mst_stimulus.sv for usage of Master VIP generating stimulus
// Please refer axi_vip_0_mem_stimulus.sv for usage of Slave VIP(with memory model) responding
// Please refer axi_vip_0_exdes_generic.sv for simple scoreboarding,how to get monitor 
// transaction from Master VIP monitor and Slave VIP monitor 
//-----------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps

`include "axi_vip_0_exdes_generic.sv"
`include "axi_vip_0_mst_stimulus.sv"
`include "axi_vip_0_mem_basic_stimulus.sv"

module axi_vip_0_exdes_basic_mst_active__pt_passive__slv_mem(
  );
     
  // Clock signal
  bit                                     clock;
  // Reset signal
  bit                                     reset;

  // event to stop simulation
  event                                   done_event;

  axi_vip_0_exdes_generic  generic_tb();
  axi_vip_0_mst_stimulus mst();
  axi_vip_0_mem_basic_stimulus slv();

  // instantiate bd
  chip DUT(
      .aresetn(reset),
  
    .aclk(clock)
  );

  initial begin
    reset <= 1'b1;
  end
  
  always #10 clock <= ~clock;

endmodule
