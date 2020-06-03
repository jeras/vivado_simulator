/***************************************************************************************************
* Description:
* Considering different user cases, Slave VIP has two agents: slv_agent and slv_mem_agent.
* slv_agent doesn't have memory model and user can build their own memory model and fill in write
* transaction and/or read transaction responses in their own way.slv_mem_agent has memory model
* which user can use it directly.
* This file contains example on how Slave VIP with memory model responds and memory model usage of
* backdoor access(read/write)
* For Slave VIP with memory model to work correctly,the following four things must be done
*    1. import two packages.(this information also shows at the xgui of the VIP)
*         import axi_vip_v1_0_2_pkg::* 
*         import "component_name"_pkg::*;
*    2. delcare "component_name"_slv_mem_t agent
*    3. new agent (passing instance IF correctly)
*    4. start_slave
* As for ready generation, if user enviroment doesn't do anything, it will randomly generate ready
* siganl,if user wants to create his own ready signal, please refer task user_gen_wready 
***************************************************************************************************/


import axi_vip_pkg::*;
import ex_sim_axi_vip_slv_0_pkg::*;

module axi_vip_0_mem_stimulus(
  );
 
 /*************************************************************************************************
  * Declare "component_name"_slv_mem_t for slave mem agent
  * "component_name" can be easily found in vivado bd design: click on the instance, 
  * then click CONFIG under Properties window and Component_Name will be shown
  * more details please refer PG267 for more details
  *************************************************************************************************/
  ex_sim_axi_vip_slv_0_slv_mem_t                          agent;

  initial begin
  /************************************************************************************************
    * Before agent is newed, user has to run simulation with an empty testbench to find the 
    * hierarchy path of the AXI VIP's instance.Message like
    * "Xilinx AXI VIP Found at Path: my_ip_exdes_tb.DUT.axi_vip_mst.inst" will be printed 
    * out. Pass this path to the new function. 
  ***********************************************************************************************/
    agent = new("slave vip mem agent",DUT.axi_vip_slv.inst.IF);
  
    /***********************************************************************************************
    * set tag for agents for easy debug,if not set here, it will be hard to tell which driver is filing 
    * if multiple agents are called in one testbench
    ***********************************************************************************************/
    agent.set_agent_tag("My Slave VIP");

    /***********************************************************************************************
    * set verbosity of agent - default is no print out 
    * verbosity level which specifies how much debug information to produce
    *    0       - No information will be printed out.
    *   400      - All information will be printed out
    ***********************************************************************************************/
    agent.set_verbosity(0);  
    agent.start_slave();    // agent starts to run
    backdoor_mem_write();   // Call task to do back door memory write  
    backdoor_mem_read();   // Call task to do back door memory read
    user_gen_wready();     // call task to generate wready 
  end

  /*************************************************************************************************
  * Task user_gen_wready shows how slave VIP agent generates one customerized wready signal. 
  * declare axi_ready_gen  wready_gen
  * call create_ready from agent's write driver to create a new class of axi_ready_gen 
  * set the poicy of ready generation in this example, it select XIL_AXI_READY_GEN_OSC 
  * set low time 
  * set high time
  * agent's write driver send_wready out
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
  task user_gen_wready();
    axi_ready_gen                           wready_gen;
    wready_gen = agent.wr_driver.create_ready("wready");
    wready_gen.set_ready_policy(XIL_AXI_READY_GEN_OSC);
    wready_gen.set_low_time(1);
    wready_gen.set_high_time(2);
    agent.wr_driver.send_wready(wready_gen);
  endtask

   
  /*************************************************************************************************
  * Task backdoor_mem_write shows how user can do backdoor write to memory model
  * Declare default fill in value  mem_fill_payload according to DATA WIDTH
  * Declare backdoor memory write address
  * Declare backdoor memory write payload according to DATA WIDTH
  * Declare backdoor memory write strobe
  * Delcare Address offset
  * Set default memory fill policy to be fixed
  * Randmoize memory fill value 
  * Set default memory value 
  * Randomize memory write address
  * Randomize memory write payload
  * Randomize memory write strobe
  * Calculate address offset
  * Make lower bytes strobe are off when address is not aligned address
  * Write data to memory model  
  *************************************************************************************************/

  task backdoor_mem_write();
    bit[32-1:0]              mem_fill_payload;
    bit[32-1:0]             mem_wr_addr;
    bit[32-1:0]              write_data;
    bit[(32/8)-1:0]          write_strb;
    xil_axi_ulong                           addr_offset;

    agent.mem_model.set_memory_fill_policy(XIL_AXI_MEMORY_FILL_FIXED);
    MEM_FILL_PAYLOAD_FAIL: assert(std::randomize(mem_fill_payload));
    agent.mem_model.set_default_memory_value(mem_fill_payload);
    WRITE_ADDR_FAIL: assert(std::randomize(mem_wr_addr));
    WRITE_DATA_FAIL: assert(std::randomize(write_data)); 
    WRITE_STRB_FAIL: assert(std::randomize(write_strb));
    addr_offset = mem_wr_addr & ((1 << ($clog2(32/8)))-1);
    write_strb = (write_strb <<addr_offset);
    agent.mem_model.backdoor_memory_write(mem_wr_addr, write_data, write_strb);
  endtask

  /*************************************************************************************************
  * Task backdoor_mem_read shows how user can do backdoor read data from memory model
  * Declare backdoor memory read address
  * Declare backdoor memory read data according to DATA WIDTH
  * Randomize memory read address
  * Read data from memory model 
  *************************************************************************************************/
  task backdoor_mem_read();
    bit[32-1:0]             mem_rd_addr;
    bit[32-1:0]              read_data;
    READ_ADDR_FAIL: assert(std::randomize(mem_rd_addr));
    read_data= agent.mem_model.backdoor_memory_read(mem_rd_addr);
  endtask
endmodule
