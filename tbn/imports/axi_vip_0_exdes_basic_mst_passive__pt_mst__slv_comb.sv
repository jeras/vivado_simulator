//-------------------------------------------------------------------------------------------------------------
// Description: 
// This file contains example test which shows how Passthrough VIP in run time master mode generate transaction 
// and how Slave VIP (without memory model) responds
// The example design consists of one AXI VIP in master mode, one AXI VIP in passthrough mode 
// and one AXI VIP in slave mode.
// It includes master agent stimulus, slave memory agent stimulus and generic testbench file. 
// Please refer passthrough_mst_stimulus.sv for usage of Passthrough VIP in run time master mode
// generating stimulus
// Please refer slv_stimulus.sv for usage of Slave VIP agent responding
// Please refer axisim_generic.sv for simple scoreboarding,how to get monitor 
// transaction from Passthrough VIP monitor and Slave VIP monitor 
//-------------------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps

`include "axisim_generic.sv"
`include "passthrough_mst_stimulus.sv"
`include "slv_basic_stimulus.sv"

module axisim_basic_mst_passive__pt_mst__slv_comb(
  );
     
  // Clock signal
  bit                                     clock;
  // Reset signal
  bit                                     reset;
  // event to stop simulation
  event                                   done_event;


  axisim_generic  generic_tb();
  passthrough_mst_stimulus mst();
  slv_basic_stimulus slv();

  // instantiate bd
  axi_sim DUT(
      .aresetn(reset),
  
    .aclk(clock)
  );

  initial begin
    reset <= 1'b1;
  end
  
  always #10 clock <= ~clock;

endmodule

