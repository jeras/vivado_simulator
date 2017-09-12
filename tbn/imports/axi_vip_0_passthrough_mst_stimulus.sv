

/**************************************************************************************************** Description:
* Considering different user cases, Passthrough VIP can be switched into either run time master
* mode or run time slave mode. When it is in run time slave mode, depends on situations, user may
* want to build their own memory model or using existing memory model. Passthrough VIP has two
* agents: passthrough_agent and passthrough_mem_agent to suit user needs.Passthrough_agent doesn't
* have memory model and user can build their own memory model and fill in write transaction and/or
* read transaction responses in their own way.Passthrough_mem_agent has memory model which user can
* use it directly.
* This file contains example on how Passthrough VIP in run time master mode  create a simple write
* and/or read transaction 
* For Passthrough VIP to work correctly, user environment MUST have the lists of item below and
* follow this order.
*    1. import two packages.(this information also shows at the xgui of the VIP)
*         import axi_vip_v1_0_2_pkg::* 
*         import "component_name"_pkg::*;
*    2. delcare "component_name"_passthrough_t agent
*    3. new agent (passing instance IF correctly)
*    4. switch passthrough VIP into run time master mode
*    5. start_master
*    6. create_transaction
*    7. Fill in transaction( two methods. randomization and API)
*    8. send transaction
* As for ready generation, if user enviroment doesn't do anything, it will randomly generate ready
* siganl, if user wants to create his own ready signal, please refer task user_gen_rready 
***************************************************************************************************/
import axi_vip_v1_0_2_pkg::*;
import ex_sim_axi_vip_passthrough_0_pkg::*;


module axi_vip_0_passthrough_mst_stimulus();

  // ID value for WRITE/READ_BURST transaction
  xil_axi_uint                            mtestID;
  // ADDR value for WRITE/READ_BURST transaction
  xil_axi_ulong                           mtestADDR;
  // Burst Length value for WRITE/READ_BURST transaction
  xil_axi_len_t                           mtestBurstLength;
  // SIZE value for WRITE/READ_BURST transaction
  xil_axi_size_t                          mtestDataSize; 
  // Burst Type value for WRITE/READ_BURST transaction
  xil_axi_burst_t                         mtestBurstType; 
  // LOCK value for WRITE/READ_BURST transaction
  xil_axi_lock_t                          mtestLOCK;
  // Cache Type value for WRITE/READ_BURST transaction
  xil_axi_cache_t                         mtestCacheType = 0;
  // Protection Type value for WRITE/READ_BURST transaction
  xil_axi_prot_t                          mtestProtectionType = 3'b000;
  // Region value for WRITE/READ_BURST transaction
  xil_axi_region_t                        mtestRegion = 4'b000;
  // QOS value for WRITE/READ_BURST transaction
  xil_axi_qos_t                           mtestQOS = 4'b000;
  // Data beat value for WRITE/READ_BURST transaction
  xil_axi_data_beat                       dbeat;
  // Wuser value for WRITE/READ_BURST transaction
  xil_axi_data_beat [255:0]               mtestWUSER; 
  // Awuser value for WRITE/READ_BURST transaction
  xil_axi_data_beat                       mtestAWUSER = 'h0;
  // Aruser value for WRITE/READ_BURST transaction
  xil_axi_data_beat                       mtestARUSER = 0;
  // Ruser value for WRITE/READ_BURST transaction
  xil_axi_data_beat [255:0]               mtestRUSER;    
  // Buser value for WRITE/READ_BURST transaction
  xil_axi_uint                            mtestBUSER = 0;
  // Bresp value for WRITE/READ_BURST transaction
  xil_axi_resp_t                          mtestBresp;
  // Rresp value for WRITE/READ_BURST transaction
  xil_axi_resp_t[255:0]                   mtestRresp;
  /*************************************************************************************************
  * A burst can not cross 4KB address boundry for AXI4
  * Maximum data bits = 4*1024*8 =32768
  * Write Data Value for WRITE_BURST transaction
  * Read Data Value for READ_BURST transaction
  *************************************************************************************************/
  bit [32767:0]                           mtestWData;
  bit [32767:0]                           mtestRData;

  /*************************************************************************************************
  * Declare "component_name"_passthrough_t for passthrough agent
  * "Component_name can be easily found in vivado bd design: click on the instance, 
  * Then click CONFIG under Properties window and Component_Name will be shown
  * More details please refer PG267 for more details
  *************************************************************************************************/
  ex_sim_axi_vip_passthrough_0_passthrough_t              agent;

   initial begin
    /***********************************************************************************************
    * Before agent is newed, user has to run simulation with an empty testbench to find the
    * hierarchy path of the AXI VIP's instance.Message like
    * "Xilinx AXI VIP Found at Path: my_ip_exdes_tb.DUT.ex_design.axi_vip_mst.inst" will be printed 
    * out. Pass this path to the new function. 
    ***********************************************************************************************/
    agent = new("passthrough vip agent",DUT.ex_design.axi_vip_passthrough.inst.IF);
   
    /***********************************************************************************************    * Set tag for agents for easy debug especially multiple agents are called in one testbench
    ***********************************************************************************************/
    agent.set_agent_tag("My Passthrough VIP");

    /***********************************************************************************************    * Set verbosity of agent - default is no print out 
    * Verbosity level which specifies how much debug information to produce
    *    0       - No information will be printed out.
    *   400      - All information will be printed out
    ***********************************************************************************************/
    agent.set_verbosity(0);

    DUT.ex_design.axi_vip_passthrough.inst.set_master_mode();  //  Switch passthrough agent 
                                                               //into run time master mode
    agent.start_master();                                     //agent starts to run

    // Fork process of write/read and rready generation
    fork
  
      begin
        for(int i =0; i<2; i++) begin
          wr_tran_method_one();
        end
        wr_tran_method_two();   
      end
 
      begin
        for(int i =0; i<2; i++) begin
          rd_tran_method_one();
        end  
        rd_tran_method_two(); 
      end  
      user_gen_rready();
    join

    // Wait driver idle and then stop simulation
    agent.wait_mst_drivers_idle();
    if(generic_tb.error_cnt ==0) begin
      $display("EXAMPLE TEST DONE : Test Completed Successfully");
    end else begin  
      $display("EXAMPLE TEST DONE ",$sformatf("Test Failed: %d Comparison Failed", generic_tb.error_cnt));
    end 
    $finish;
  end

  /*************************************************************************************************  * Write transaction method 1: randomization
  * Passthrough agent master write driver creates write transaction
  * Randomized the transaction
  * Passthrough agent master write driver sends the transaction
  *************************************************************************************************/
  task wr_tran_method_one();
    axi_transaction                         wr_transaction; 
    wr_transaction = agent.mst_wr_driver.create_transaction( "write transaction with randomization");
    WR_TRANSACTION_FAIL: assert(wr_transaction.randomize());
    agent.mst_wr_driver.send(wr_transaction);
  endtask :wr_tran_method_one

  /*************************************************************************************************  * Write transaction method 2: fill in transaciton with API
  * Passthrough agent master write driver creates write transaction 
  * Fill in the transaction with API
  * When fill in set_write_cmd(addr, burst,ID,length,size), different protocol has minimum arguments
  *  x here means user can use default value 
  * AXI4-Lite, set_write_cmd(addr,x,x,x,x),
  * AXI3, set_write_cmd(addr,x,x,length,size)
  * AXI4, set_write_cmd(addr,x,x,length, size)
  * Passthrough agent master write driver sends the transaction 
  *************************************************************************************************/
  task wr_tran_method_two();
    axi_transaction                         wr_transaction; 
    mtestID = 0;
    mtestADDR = 0;
    mtestBurstLength = 0;
    mtestDataSize = xil_axi_size_t'(xil_clog2(32/8));
    mtestBurstType = XIL_AXI_BURST_TYPE_INCR; 
    mtestLOCK = XIL_AXI_ALOCK_NOLOCK; 
    mtestCacheType = 0; 
    mtestProtectionType = 0; 
    mtestRegion = 0;
    mtestQOS = 0;
    for(int i = 0; i < 256;i++) begin
      mtestWUSER[i] = 'h0;
    end
    wr_transaction = agent.mst_wr_driver.create_transaction("write transaction in API");
    wr_transaction.set_write_cmd(mtestADDR,mtestBurstType,mtestID,mtestBurstLength,mtestDataSize);
    wr_transaction.set_data_block(mtestWData);
    wr_transaction.set_awuser(mtestAWUSER);
    for (xil_axi_uint beat = 0; beat < wr_transaction.get_len()+1;beat++) begin
      wr_transaction.set_wuser(beat, mtestWUSER[beat]);
    end  
    agent.mst_wr_driver.send(wr_transaction);
  endtask :wr_tran_method_two

  /*************************************************************************************************  * Read transaction method 1: randomization
  * Passthrough agent master read driver creates read transaction
  * Randomized the transaction
  * Passthrough agent master read driver sends the transaction
  *************************************************************************************************/
  task rd_tran_method_one();  
    axi_transaction                         rd_transaction;
    rd_transaction = agent.mst_rd_driver.create_transaction("read transaction with randomization");
    RD_TRANSACTION_FAIL_1a:assert(rd_transaction.randomize());
    agent.mst_rd_driver.send(rd_transaction);
  endtask 

  /***********************************************************************************************    * Read transaction method 2: fill in transaciton with API
  * Passthrough agent master read driver creates read transaction
  * fill in the transaction
  * When fill in set_read_cmd(addr, burst,ID,length,size), different protocol has mimum arguments
  * x here means user can use default value 
  * AXI4-Lite, set_read_cmd(addr,x,x,x,x),
  * AXI3, set_read_cmd(addr,x,x,length,size)
  * AXI4, set_read_cmd(addr,x,x,length, size)
  * Passthrough agent master read driver sends the transaction out
  *************************************************************************************************/
  task rd_tran_method_two();
    axi_transaction                         rd_transaction;
    mtestID = 0;
    mtestADDR = 0;
    mtestBurstLength = 0;
    mtestDataSize = xil_axi_size_t'(xil_clog2(32/8));
    mtestBurstType = XIL_AXI_BURST_TYPE_INCR; 
    mtestLOCK = XIL_AXI_ALOCK_NOLOCK; 
    mtestCacheType = 0; 
    mtestProtectionType = 0; 
    mtestRegion = 0;
    mtestQOS = 0;
    for(int i = 0; i < 256;i++) begin
      mtestRUSER = 'h0;
    end  
    rd_transaction = agent.mst_rd_driver.create_transaction("read transaction");
    rd_transaction.set_read_cmd(mtestADDR,mtestBurstType,mtestID,mtestBurstLength,mtestDataSize);
    agent.mst_rd_driver.send(rd_transaction);
  endtask

  /*************************************************************************************************
  * Task user_gen_wready shows how passthrough VIP agent generates one customerized rready signal. 
  * declare axi_ready_gen  rready_gen
  * call create_ready from agent's master read driver to create a new class of axi_ready_gen 
  * set the poicy of ready generation in this example, it select XIL_AXI_READY_GEN_AFTER_VALID_OSC 
  * set low time 
  * set high time
  * agent's master read driver send_rready out
  * ready generation policy are listed below:
  *   XIL_AXI_READY_GEN_SINGLE             - Ready stays 0 for low_time clock cycles and then
                                             dirves 1 until one ready/valid handshake occurs,
                                             the policy repeats until the channel is given
                                             different policy.
  *   XIL_AXI_READY_GEN_EVENTS             - Ready stays 0 for low_time clock cycles and then
                                             dirves 1 until event_count ready/valid handshakes
                                             occur,the policy repeats until the channel is given
                                             different policy.
  *   XIL_AXI_READY_GEN_OSC                - Ready stays 0 for low_time and then goes to 1 and      
                                             stays 1 for high_time,the policy repeats until the
                                             channel is given different policy.
  *   XIL_AXI_READY_GEN_RANDOM             - This policy generate random ready policy and uses
                                             min/max pair of low_time, high_time and event_count to
                                             generate low_time, high_time and event_count.
  *   XIL_AXI_READY_GEN_AFTER_VALID_SINGLE - This policy is active when VALID is detected to be
                                             asserted, Ready stays 0 for low_time clock cycles and
                                             then dirves 1 until one ready/valid handshake occurs,
                                             the policy repeats until the channel is given
                                             different policy.
  *   XIL_AXI_READY_GEN_AFTER_VALID_EVENTS - This policy is active when VALID is detected to be
                                             asserted, Ready stays 0 for low_time clock cycles and
                                             then dirves 1 until event_count ready/valid handshake
                                             occurs,the policy repeats until the channel is given
                                             different policy.
  *   XIL_AXI_READY_GEN_AFTER_VALID_OSC    - This policy is active when VALID is detected to be
                                             asserted, Ready stays 0 for low_time and then goes to
                                             1 and  stays 1 for high_time,the policy repeats until
                                             the channel is given different policy.
  *************************************************************************************************/
  task user_gen_rready();  
    axi_ready_gen                           rready_gen;
    rready_gen = agent.mst_rd_driver.create_ready("rready");
    rready_gen.set_ready_policy(XIL_AXI_READY_GEN_AFTER_VALID_OSC);
    rready_gen.set_low_time(2);
    rready_gen.set_high_time(1);
    agent.mst_rd_driver.send_rready(rready_gen);
  endtask

endmodule 
