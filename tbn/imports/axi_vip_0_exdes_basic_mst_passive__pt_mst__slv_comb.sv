//-------------------------------------------------------------------------------------------------------------
// Description: 
// This file contains example test which shows how Passthrough VIP in run time master mode generate transaction 
// and how Slave VIP (without memory model) responds
// The example design consists of one AXI VIP in master mode, one AXI VIP in passthrough mode 
// and one AXI VIP in slave mode.
// It includes master agent stimulus, slave memory agent stimulus and generic testbench file. 
// Please refer axi_vip_0_passthrough_mst_stimulus.sv for usage of Passthrough VIP in run time master mode
// generating stimulus
// Please refer axi_vip_0_slv_stimulus.sv for usage of Slave VIP agent responding
// Please refer axi_vip_0_exdes_generic.sv for simple scoreboarding,how to get monitor 
// transaction from Passthrough VIP monitor and Slave VIP monitor 
//-------------------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps

`include "axi_vip_0_exdes_generic.sv"
`include "axi_vip_0_passthrough_mst_stimulus.sv"
`include "axi_vip_0_slv_basic_stimulus.sv"

module axi_vip_0_exdes_basic_mst_passive__pt_mst__slv_comb(
  );
     
  // Clock signal
  bit                                     clock;
  // Reset signal
  bit                                     reset;
  // event to stop simulation
  event                                   done_event;


  axi_vip_0_exdes_generic  generic_tb();
  axi_vip_0_passthrough_mst_stimulus mst();
  axi_vip_0_slv_basic_stimulus slv();

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

