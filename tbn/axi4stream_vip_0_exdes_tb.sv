
/***************************************************************************************************
* Description: 
* This testbench contains example test lists for one design which consists of one Master AXI4STREAM
* VIP and one Slave AXI4STREAM VIP.
* In the following scenarios, it demonstrates how Master AXI4STREAM VIP create transactions, 
* and how Slave AXI4STREAM VIP generate ready (when TREADY is on).
* This testbench also has two simple scoreboards to do self-checking: 
* One scoreboard checks master AXI4STREAM VIP against slave AXI4STREAM VIP
****************************************************************************************************
* Description of How Master VIP works:
* This file contains example on how Master VIP create a simple transaction 
* For Master VIP to work correctly, user environment MUST have the lists of item below and 
* follow this order.
*    1. import two packages.
*       import axi4stream_vip_v1_0_1_pkg::* 
*       import axi4stream_vip_mst_0_pkg::*;
*    2. delcare "component_name"_mst_t agent
*    3. new agent (passing instance IF correctly)
*    4. set vif_proxy dummy drive type 
*    5. start_master
*    6. create_transaction
*    7. Fill in transaction( two methods. randomization and API)
*    8. send transaction
* if user wants to create his own ready signal, please refer task user_gen_rready 
****************************************************************************************************
* Description of how Slave VIP works: 
* This file contains example on how Slave VIP genearte ready signal when TREADY is on 
* For Slave VIP to work correctly, user environment MUST have the lists of item below and
* follow this order.
*    1. import two packages.
*       import axi4stream_vip_v1_0_1_pkg::* 
*       import axi4stream_vip_slv_0_pkg::*;
*    2. delcare "component_name"_slv_t agent
*    3. new agent (passing instance IF correctly)
*    4. set vif_proxy dummy drive type 
*    5. start_slave
* As for ready generation, when TREADY is on, if user enviroment doesn't do anything, it will
* randomly generate ready siganl if user wants to create his own ready signal,
* please refer task slv_gen_tready 
***************************************************************************************************/

`timescale 1ns / 1ps

/***************************************************************************************************
* As described above, this design has all three VIPs. so it includes all three packages plus 
* axi4stream_vip_v1_0_1_pkg
***************************************************************************************************/
import axi4stream_vip_v1_0_1_pkg::*;
import axi4stream_vip_mst_0_pkg::*;
import axi4stream_vip_slv_0_pkg::*;

module axi4stream_vip_0_exdes_tb();

  // Error count to check how many comparison failed
  xil_axi4stream_uint                            error_cnt = 0; 
  // Comparison count to check how many comparsion happened
  xil_axi4stream_uint                            comparison_cnt = 0;

  /***************************************************************************************************
  * The following monitor transactions are for simple scoreboards doing self-checking
  ***************************************************************************************************/

  // Monitor transaction from master VIP
  axi4stream_monitor_transaction                 mst_monitor_transaction;
  // Monitor transaction queue for master VIP 
  axi4stream_monitor_transaction                 master_monitor_transaction_queue[$];
  // Scoreboard transaction from master monitor transaction queue
  axi4stream_monitor_transaction                 mst_scb_transaction;
  // Monitor transaction for slave VIP
  axi4stream_monitor_transaction                 slv_monitor_transaction;
  // Monitor transaction queue for slave VIP
  axi4stream_monitor_transaction                 slave_monitor_transaction_queue[$];
  // Scoreboard transaction from slave monitor transaction queue
  axi4stream_monitor_transaction                 slv_scb_transaction;
  /***************************************************************************************************
  * Verbosity level which specifies how much debug information to be printed out
  * 0         - No information will be printed out
  * 400       - All information will be printed out
  ***************************************************************************************************/
  // Master VIP agent verbosity level
  xil_axi4stream_uint                           mst_agent_verbosity = 0;
  // Slave VIP agent verbosity level
  xil_axi4stream_uint                           slv_agent_verbosity = 0;
  /***************************************************************************************************
  * Parameterized agents which customer needs to declare according to AXI4STREAM VIP configuration
  * If AXI4STREAM VIP is being configured in master mode, "component_name"_mst_t has to be declared 
  * If AXI4STREAM VIP is being configured in slave mode, "component_name"_slv_t has to be declared 
  * "component_name can be easily found in vivado bd design: click on the instance, 
  * then click CONFIG under Properties window and Component_Name will be shown
  * More details please refer PG277 for more details
  ***************************************************************************************************/
  axi4stream_vip_mst_0_mst_t                              mst_agent;
  axi4stream_vip_slv_0_slv_t                              slv_agent;
  
     
  // clock/reset signal
  bit aclk;
  bit aresetn;

  logic [7:0] axi4stream_vip_M_AXIS_TDATA;
  logic [0:0] axi4stream_vip_M_AXIS_TREADY;
  logic [0:0] axi4stream_vip_M_AXIS_TVALID;

  axi4stream_vip_mst_0 axi4stream_vip_mst (
    .aclk          (aclk),
    .aresetn       (aresetn),
    .m_axis_tdata  (axi4stream_vip_M_AXIS_TDATA),
    .m_axis_tready (axi4stream_vip_M_AXIS_TREADY),
    .m_axis_tvalid (axi4stream_vip_M_AXIS_TVALID)
  );

  axi4stream_vip_slv_0 axi4stream_vip_slv (
    .aclk          (aclk),
    .aresetn       (aresetn),
    .s_axis_tdata  (axi4stream_vip_M_AXIS_TDATA),
    .s_axis_tready (axi4stream_vip_M_AXIS_TREADY),
    .s_axis_tvalid (axi4stream_vip_M_AXIS_TVALID)
  );

  initial begin
    aresetn <= 1'b1;
  end
  
  always #10 aclk <= ~aclk;

  //Main process
  initial begin
    /***************************************************************************************************
    * The hierarchy path of the AXI4STREAM VIP's interface is passed to the agent when it is newed. 
    * Method to find the hierarchy path of AXI4STREAM VIP is to run simulation without agents being newed,
    * message like "Xilinx AXI4STREAM VIP Found at Path: 
    * my_ip_exdes_tb.axi4stream_vip_mst.inst" will be printed out.
    ***************************************************************************************************/

    mst_agent = new("master vip agent", axi4stream_vip_mst.inst.IF);
    slv_agent = new("slave vip agent" , axi4stream_vip_slv.inst.IF);
    $timeformat (-12, 1, " ps", 1);

    /***************************************************************************************************
    * When bus is in idle, it must drive everything to 0, otherwise it will 
    * trigger false assertion failure from axi_protocol_chekcer
    ***************************************************************************************************/
    
    mst_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);
    slv_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);

    /***************************************************************************************************
    * Set tag for agents for easy debug,if not set here, it will be hard to tell which driver is filing 
    * if multiple agents are called in one testbench
    ***************************************************************************************************/
    
    mst_agent.set_agent_tag("Master VIP");
    slv_agent.set_agent_tag("Slave VIP");
    // set print out verbosity level.
    mst_agent.set_verbosity(mst_agent_verbosity);
    slv_agent.set_verbosity(slv_agent_verbosity);

    /***************************************************************************************************
    * Master,slave agents start to run 
    ***************************************************************************************************/
    
    mst_agent.start_master();
    slv_agent.start_slave();

    /***************************************************************************************************
    * Fork off the process
    * Master VIP create transaction
    * Slave VIP create TREADY if it is on
    ***************************************************************************************************/

    fork
      begin
        mst_gen_transaction();
        $display("Simple master to slave transfer example with randomization completes");
        for(int i = 0; i < 4;i++) begin
          mst_gen_transaction();
        end  
        $display("Looped master to slave transfers example with randomization completes");
      end
      begin
        slv_gen_tready();
      end
    join_any
  
    #1ns;
    $display("EXAMPLE TEST");
    begin
      for(int i = 0; i < 2;i++) begin
        mst_gen_transaction();
      end
    end
    
    #1ns;
    if(error_cnt ==0) begin
      $display("EXAMPLE TEST DONE : Test Completed Successfully");
    end else begin  
      $display("EXAMPLE TEST DONE ",$sformatf("Test Failed: %d Comparison Failed", error_cnt));
    end 
    $finish;
  end

  /*****************************************************************************************************************
  * Task slv_gen_tready shows how slave VIP agent generates one customerized tready signal. 
  * Declare axi4stream_ready_gen  ready_gen
  * Call create_ready from agent's driver to create a new class of axi4stream_ready_gen 
  * Set the poicy of ready generation in this example, it select XIL_AXI4STREAM_READY_GEN_OSC 
  * Set low time 
  * Set high time
  * Agent's driver send_tready out
  * Ready generation policy are listed below:
  *   XIL_AXI4STREAM_READY_GEN_SINGLE             - Ready stays low for low_time,goes high and stay high till one 
  *                                         ready/valid handshake occurs, it then goes to low repeats this pattern. 
  *   XIL_AXI4STREAM_READY_GEN_EVENTS             - Ready stays low for low_time,goes high and stay high till 
  *                                          a certain amount of ready/valid handshake occurs, it then goes to 
  *                                          low and repeats this pattern.  
  *   XIL_AXI4STREAM_READY_GEN_OSC                - Ready stays low for low_time and then goes to high and stays 
  *                                          high for high_time, it then goes to low and repeat the same pattern
  *   XIL_AXI4STREAM_READY_GEN_RANDOM             - Ready generates randomly 
  *   XIL_AXI4STREAM_READY_GEN_AFTER_VALID_SINGLE - Ready stays low, once valid goes high, ready stays low for
  *                                          low_time, then it goes high and stay high till one ready/valid handshake 
  *                                          occurs. it then goes low and repeate the same pattern.
  *   XIL_AXI4STREAM_READY_GEN_AFTER_VALID_EVENTS - Ready stays low, once valid goes high, ready stays low for low_time,
  *                                          then it goes high and stay high till some amount of ready/valid handshake
  *                                          event occurs. it then goes low and repeate the same pattern.
  *   XIL_AXI4STREAM_READY_GEN_AFTER_VALID_OSC    - Ready stays low, once valid goes high, ready stays low for low_time, 
  *                                          then it goes high and stay high for high_time. it then goes low 
  *                                          and repeate the same pattern.
  *****************************************************************************************************************/
  task slv_gen_tready();
    axi4stream_ready_gen                           ready_gen;
    ready_gen = slv_agent.driver.create_ready("ready_gen");
    ready_gen.set_ready_policy(XIL_AXI4STREAM_READY_GEN_OSC);
    ready_gen.set_low_time(2);
    ready_gen.set_high_time(6);
    slv_agent.driver.send_tready(ready_gen);
  endtask :slv_gen_tready


  /*************************************************************************************************************
  * Master VIP generates transaction:
  * Driver in master agent creates transaction
  * Randomized the transaction
  * Driver in master agent sends the transaction
  *************************************************************************************************************/
  task mst_gen_transaction();
    axi4stream_transaction                         wr_transaction; 
    wr_transaction = mst_agent.driver.create_transaction("Master VIP write transaction");
    WR_TRANSACTION_FAIL: assert(wr_transaction.randomize());
    mst_agent.driver.send(wr_transaction);
  endtask

  /***************************************************************************************************
  * Get monitor transaction from master VIP monitor analysis port
  * Put the transactin into master monitor transaction queue 
  ***************************************************************************************************/
  initial begin
    forever begin
      mst_agent.monitor.item_collected_port.get(mst_monitor_transaction);
      master_monitor_transaction_queue.push_back(mst_monitor_transaction);
    end  
  end 

  /***************************************************************************************************
  * Get monitor transaction from slave VIP monitor analysis port
  * Put the transactin into slave monitor transaction queue 
  ***************************************************************************************************/
  initial begin
    forever begin
      slv_agent.monitor.item_collected_port.get(slv_monitor_transaction);
      slave_monitor_transaction_queue.push_back(slv_monitor_transaction);
    end
  end

  /***************************************************************************************************
  * Simple scoreboard doing self checking 
  * Comparing transaction from master VIP monitor with transaction from slave VIP monitor
  * if they are match, SUCCESS. else, ERROR
  ***************************************************************************************************/
  initial begin
   forever begin
      wait (master_monitor_transaction_queue.size() > 0) begin
        mst_scb_transaction = master_monitor_transaction_queue.pop_front;
        wait (slave_monitor_transaction_queue.size() > 0) begin
          slv_scb_transaction = slave_monitor_transaction_queue.pop_front;
          if (slv_scb_transaction.do_compare(mst_scb_transaction) == 0) begin
            $display("ERROR:  Master VIP against slave VIP scoreboard Compare failed");
            error_cnt++;
          end else begin
            $display("SUCCESS: Master VIP against slave VIP scoreboard Compare passed");
          end
          comparison_cnt++;
        end  
      end 
    end
  end
 
endmodule
