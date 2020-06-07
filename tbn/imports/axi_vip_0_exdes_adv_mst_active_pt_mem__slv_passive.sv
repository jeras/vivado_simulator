//-------------------------------------------------------------------------------------------------------------
// Description: 
// This file contains example test which shows how Master VIP generate transaction and how
// Passthrough VIP in run time slave mode(with memory model) responds 
// The example design consists of one AXI VIP in master mode, one AXI VIP in passthrough mode 
// and one AXI VIP in slave mode.
// It includes master agent stimulus, slave memory agent stimulus and generic testbench file. 
// Please refer mst_stimulus.sv for usage of Master VIP generating stimulus
// Please refer passthrough_mem_stimulus.sv for usage of Passthrough VIP in
// run time slave mode(with memory model) responding
// Please refer axisim_generic.sv for simple scoreboarding,how to get monitor 
// transaction from Master VIP monitor and Passthrough VIP monitor 
//-------------------------------------------------------------------------------------------------------------

`timescale 1ns / 1ps

`include "axisim_generic.sv"
`include "mst_stimulus.sv"
`include "passthrough_mem_stimulus.sv"

module _axisim_adv_mst_active_pt_mem__slv_passive(
  );
     
  // Clock signal
  bit                                     clock;
  // Reset signal
  bit                                     reset;
  // event to stop simulation
  event                                   done_event;


  axisim_generic  generic_tb();
  mst_stimulus mst();
  passthrough_mem_stimulus slv();

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

