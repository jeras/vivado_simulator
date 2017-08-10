
/***************************************************************************************************
* Description: 
* This testbench contains example test lists for one design which consists of one Master AXI4STREAM
* VIP, one Slave AXI4STREAM VIP and one Passthrough AXI4STREAM VIP.
* In the following scenarios,it demonstrates how Master AXI4STREAM VIP create transactions, 
* Slave AXI4STREAM VIP generate ready(when TREADY is on) and how Passthrough AXI4STREAM VIP
* switch into run time master/slave mode.
* This testbench also has two simple scoreboards to do self-checking: 
* One scoreboard checks master AXI4STREAM VIP against passthrough AXI4STREAM VIP
* One scoreboard checks slave AXI4STREAM VIP  against passthrough AXI4STREAM VIP
****************************************************************************************************
* Description of How Master VIP works:
* This file contains example on how Master VIP create a simple transaction 
* For Master VIP to work correctly, user environment MUST have the lists of item below and 
* follow this order.
*    1. import two packages.
*       import axi4stream_vip_v1_0_1_pkg::* 
*       import ex_sim_axi4stream_vip_mst_0_pkg::*;
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
*       import ex_sim_axi4stream_vip_slv_0_pkg::*;
*    2. delcare "component_name"_slv_t agent
*    3. new agent (passing instance IF correctly)
*    4. set vif_proxy dummy drive type 
*    5. start_slave
* As for ready generation, when TREADY is on, if user enviroment doesn't do anything, it will
* randomly generate ready siganl if user wants to create his own ready signal,
* please refer task slv_gen_tready 
****************************************************************************************************
* Description of how Passthrough VIP works:
* This file contains example on how Passthrough VIP switch into run time master/slave mode  
* For Passthrough VIP in run time slave mode to work correctly, user environment MUST have the
* lists of item below and follow this order.
*    1. import two packages.
*       import axi4stream_vip_v1_0_1_pkg::* 
*       import ex_sim_axi4stream_vip_passthrough_0_pkg::*;
*    2. delcare "component_name"_passthrough_t agent
*    3. new agent (passing instance IF correctly)
*    4. set vif_proxy dummy drive type 
*    5. switch passthrough mode into run time master/slave mode
*    6. start_master/slave
* Once Passthrough VIP switch to run time master mode, it behaves as Master VIP
* Once Passthrough VIP switch to run time slave mode, it behaves as Slave VIP
***************************************************************************************************/

`timescale 1ns / 1ps

/***************************************************************************************************
* As described above, this design has all three VIPs. so it includes all three packages plus 
* axi4stream_vip_v1_0_1_pkg
***************************************************************************************************/
import axi4stream_vip_v1_0_1_pkg::*;
import ex_sim_axi4stream_vip_mst_0_pkg::*;
import ex_sim_axi4stream_vip_slv_0_pkg::*;
import ex_sim_axi4stream_vip_passthrough_0_pkg::*;

module axi4stream_vip_0_exdes_tb(
  );

  typedef enum {
    EXDES_PASSTHROUGH,
    EXDES_PASSTHROUGH_MASTER,
    EXDES_PASSTHROUGH_SLAVE
  } exdes_passthrough_t;

  exdes_passthrough_t                     exdes_state = EXDES_PASSTHROUGH;

  // Error count to check how many comparison failed
  xil_axi4stream_uint                            error_cnt = 0; 
  // Comparison count to check how many comparsion happened
  xil_axi4stream_uint                            comparison_cnt = 0;
  // Counts of passthrough VIP switch to runtime master or slave mode 
  xil_axi4stream_uint                            passthrough_cmd_switch_cnt = 0;
  // Event when passthrough VIP in runtime Master mode start
  event                                          passthrough_mastermode_start_event;
  // Event when passthrough VIP in runtime master mode finish
  event                                          passthrough_mastermode_end_event;
  // Event when passthrough VIP in runtime slave mode finish
  event                                          passthrough_slavemode_end_event;

  /***************************************************************************************************
  * The following monitor transactions are for simple scoreboards doing self-checking
  * Two Scoreboards are built here
  * One scoreboard checks master vip against passthrough VIP (scoreboard 1)
  * The other one checks passthrough VIP against slave VIP (scoreboard 2)
  ***************************************************************************************************/

  // Monitor transaction from master VIP
  axi4stream_monitor_transaction                 mst_monitor_transaction;
  // Monitor transaction queue for master VIP 
  axi4stream_monitor_transaction                 master_moniter_transaction_queue[$];
  // Size of master_moniter_transaction_queue
  xil_axi4stream_uint                           master_moniter_transaction_queue_size =0;
  // Scoreboard transaction from master monitor transaction queue
  axi4stream_monitor_transaction                 mst_scb_transaction;
  // Monitor transaction from passthrough VIP
  axi4stream_monitor_transaction                 passthrough_monitor_transaction;
  // Monitor transaction queue for passthrough VIP for scoreboard 1
  axi4stream_monitor_transaction                 passthrough_master_moniter_transaction_queue[$];
  // Size of passthrough_master_moniter_transaction_queue;
  xil_axi4stream_uint                            passthrough_master_moniter_transaction_queue_size =0;
  // Scoreboard transaction from passthrough VIP monitor transaction queue 
  axi4stream_monitor_transaction                 passthrough_mst_scb_transaction;
  // Monitor transaction queue for passthrough VIP for scoreboard 2 
  axi4stream_monitor_transaction                 passthrough_slave_moniter_transaction_queue[$];
  // Size of passthrough_slave_moniter_transaction_queue;
  xil_axi4stream_uint                            passthrough_slave_moniter_transaction_queue_size =0;
  // Scoreboard transaction from Passthrough VIP monitor transaction queue
  axi4stream_monitor_transaction                 passthrough_slv_scb_transaction;
  // Monitor transaction for slave VIP
  axi4stream_monitor_transaction                 slv_monitor_transaction;
  // Monitor transaction queue for slave VIP
  axi4stream_monitor_transaction                 slave_moniter_transaction_queue[$];
  // Size of slave_moniter_transaction_queue
  xil_axi4stream_uint                            slave_moniter_transaction_queue_size =0;
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
  // Passthrough VIP agent verbosity level
  xil_axi4stream_uint                           passthrough_agent_verbosity = 0;
  /***************************************************************************************************
  * Parameterized agents which customer needs to declare according to AXI4STREAM VIP configuration
  * If AXI4STREAM VIP is being configured in master mode, "component_name"_mst_t has to declared 
  * If AXI4STREAM VIP is being configured in slave mode, "component_name"_slv_t has to be declared 
  * If AXI4STREAM VIP is being configured in pass-through mode,"component_name"_passthrough_t has to be declared
  * "component_name can be easily found in vivado bd design: click on the instance, 
  * then click CONFIG under Properties window and Component_Name will be shown
  * More details please refer PG277 for more details
  ***************************************************************************************************/
  ex_sim_axi4stream_vip_mst_0_mst_t                              mst_agent;
  ex_sim_axi4stream_vip_slv_0_slv_t                              slv_agent;
  ex_sim_axi4stream_vip_passthrough_0_passthrough_t              passthrough_agent;

  
     
  // Clock signal
  bit                                     clock;
  // Reset signal
  bit                                     reset;

  // instantiate bd
  ex_sim DUT(
    .aresetn(reset),
    .aclk(clock)
  );

  initial begin
    reset <= 1'b1;
  end
  
  always #10 clock <= ~clock;

  //Main process
  initial begin
    /*mst_monitor_transaction = new("master monitor transaction");
    slv_monitor_transaction = new("slave monitor transaction");*/

    /***************************************************************************************************
    * The hierarchy path of the AXI4STREAM VIP's interface is passed to the agent when it is newed. 
    * Method to find the hierarchy path of AXI4STREAM VIP is to run simulation without agents being newed,
    * message like "Xilinx AXI4STREAM VIP Found at Path: 
    * my_ip_exdes_tb.DUT.axi4stream_vip_mst.inst" will be printed out.
    ***************************************************************************************************/

    mst_agent = new("master vip agent",DUT.axi4stream_vip_mst.inst.IF);
    slv_agent = new("slave vip agent",DUT.axi4stream_vip_slv.inst.IF);
    passthrough_agent = new("passthrough vip agent",DUT.axi4stream_vip_passthrough.inst.IF);
    $timeformat (-12, 1, " ps", 1);

    /***************************************************************************************************
    * When bus is in idle, it must drive everything to 0.otherwise it will 
    * trigger false assertion failure from axi_protocol_chekcer
    ***************************************************************************************************/
    
    mst_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);
    slv_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);
    passthrough_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);

    /***************************************************************************************************
    * Set tag for agents for easy debug,if not set here, it will be hard to tell which driver is filing 
    * if multiple agents are called in one testbench
    ***************************************************************************************************/
    
    mst_agent.set_agent_tag("Master VIP");
    slv_agent.set_agent_tag("Slave VIP");
    passthrough_agent.set_agent_tag("Passthrough VIP");
    // set print out verbosity level.
    mst_agent.set_verbosity(mst_agent_verbosity);
    slv_agent.set_verbosity(slv_agent_verbosity);
    passthrough_agent.set_verbosity(passthrough_agent_verbosity);

    /***************************************************************************************************
    * Master,slave agents start to run 
    * Turn on passthrough agent monitor 
    ***************************************************************************************************/
    
    mst_agent.start_master();
    slv_agent.start_slave();
    exdes_state = EXDES_PASSTHROUGH;
    passthrough_agent.start_monitor();

    /***************************************************************************************************
    * Fork off the process
    * Master VIP create transaction
    * Slave VIP create TREADY if it is on
    * Passthrough VIP starts to monitor 
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
  
    while(passthrough_cmd_switch_cnt ==0) begin
      @(passthrough_mastermode_start_event);
      passthrough_cmd_switch_cnt++;
    end
    #1ns;
 
    /***************************************************************************************************
    * DESCRIPTION:
    * Passthrough VIP switch to run time master mode
    * Passthrough VIP behaves as master VIP
    * Create transcation and send out transaction
    ***************************************************************************************************/
    axi4stream_vip_0_exdes_tb.DUT.axi4stream_vip_passthrough.inst.set_master_mode();
    exdes_state = EXDES_PASSTHROUGH_MASTER;
    passthrough_agent.set_agent_tag("Passthrough VIP in Master mode");
    passthrough_agent.start_master();
    $display("Change Passthrough IP into runtime master mode and generate transfers with Randomization");
    for(int i = 0; i < 2;i++) begin
       passthrough_gen_transaction();
    end  
    $display("Passthrough IP change into runtime master transfers example with randomization completes");
    
    /***************************************************************************************************
    * DESCRIPTION:
    * Passthrough VIP switch to run time slave mode
    * Passthrough VIP behaves as slave VIP
    * Generate ready signal when TREADY is on
    ***************************************************************************************************/
    while(passthrough_cmd_switch_cnt ==1) begin
      @(passthrough_mastermode_end_event);
      passthrough_cmd_switch_cnt++;
    end
    #1ns;
    axi4stream_vip_0_exdes_tb.DUT.axi4stream_vip_passthrough.inst.set_slave_mode();
    exdes_state = EXDES_PASSTHROUGH_SLAVE;
    passthrough_agent.set_agent_tag("Passthrough VIP in Slave mode");
    passthrough_agent.stop_master();
    passthrough_agent.start_slave();
    $display("EXAMPLE TEST  : Change Passthrough IP into runtime slave mode");
    fork
      begin
        for(int i = 0; i < 2;i++) begin
          mst_gen_transaction();
        end
      end
      passthrough_gen_tready();
  
    join_any
    
    while(passthrough_cmd_switch_cnt ==2) begin
      @(passthrough_slavemode_end_event);
      passthrough_cmd_switch_cnt++;
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

  /*************************************************************************************************************
  * Passthrough VIP generates transaction:
  * Master driver in passthrough agent creates transaction
  * Randomized the transaction
  * Master driver in passthrough agent sends the transaction
  *************************************************************************************************************/
  task passthrough_gen_transaction();
    axi4stream_transaction                        pss_transaction;
    pss_transaction = passthrough_agent.mst_driver.create_transaction("Passthrough VIP in runtime master mode: create  transaction");
    PSS_TRANSACTION_FAIL: assert(pss_transaction.randomize());
    passthrough_agent.mst_driver.send(pss_transaction);
  endtask  

  /*****************************************************************************************************************
  * Task passthrough_gen_tready shows how passthrough VIP agent in run time slave mode generates one 
  * customerized tready signal. 
  * Declare axi4stream_ready_gen  ready_gen2
  * Call create_ready from agent's driver to create a new class of axi4stream_ready_gen 
  * Set the poicy of ready generation in this example, it select XIL_AXI4STREAM_READY_GEN_OSC 
  * Set low time 
  * Set high time
  * Agent's slv_driver send_tready out
  * Ready generation policy are listed below:
  *   XIL_AXI4STREAM_READY_GEN_SINGLE             - Ready stays low for low_time,goes high and stay high till one 
  *                                         ready/valid handshake occurs, it then goes to low repeats this pattern. 
  *   XIL_AXI4STREAM_READY_GEN_EVENTS             - Ready stays low for low_time,goes high and stay high till one
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
  task passthrough_gen_tready();
    axi4stream_ready_gen                           ready_gen2;
    ready_gen2 = passthrough_agent.slv_driver.create_ready("ready_gen2");
    ready_gen2.set_ready_policy(XIL_AXI4STREAM_READY_GEN_OSC);
    ready_gen2.set_low_time(1);
    ready_gen2.set_high_time(2);
    passthrough_agent.slv_driver.send_tready(ready_gen2);
  endtask

  /***************************************************************************************************
  * Get monitor transaction from master VIP monitor analysis port
  * Put the transactin into master monitor transaction queue 
  ***************************************************************************************************/
  initial begin
    forever begin
      mst_agent.monitor.item_collected_port.get(mst_monitor_transaction);
      master_moniter_transaction_queue.push_back(mst_monitor_transaction);
      master_moniter_transaction_queue_size++;
    end  
  end 

  /***************************************************************************************************
  * Get monitor transaction from slave VIP monitor analysis port
  * Put the transactin into slave monitor transaction queue 
  ***************************************************************************************************/
  initial begin
    forever begin
      slv_agent.monitor.item_collected_port.get(slv_monitor_transaction);
      slave_moniter_transaction_queue.push_back(slv_monitor_transaction);
      slave_moniter_transaction_queue_size++;
    end
  end

  /***************************************************************************************************
  * Get monitor transaction from passthrough VIP monitor analysis port
  * Put the transactin into transaction queues of master side or slave side according to exdes_state
  ***************************************************************************************************/
  initial begin
    forever begin
      passthrough_agent.monitor.item_collected_port.get(passthrough_monitor_transaction);
      if (exdes_state != EXDES_PASSTHROUGH_SLAVE) begin
        passthrough_master_moniter_transaction_queue.push_back(passthrough_monitor_transaction);
        passthrough_master_moniter_transaction_queue_size++;
      end
      if (exdes_state != EXDES_PASSTHROUGH_MASTER) begin
        passthrough_slave_moniter_transaction_queue.push_back(passthrough_monitor_transaction);
        passthrough_slave_moniter_transaction_queue_size++;
      end
    end  
  end 

   // event to trigger passthrough vip switch to runtime master/slave mode
  always @(comparison_cnt) begin
    if(comparison_cnt == 10) begin
      -> passthrough_mastermode_start_event;
    end 
    if(comparison_cnt == 12) begin
      -> passthrough_mastermode_end_event;
    end 
    if(comparison_cnt == 14) begin
      -> passthrough_slavemode_end_event;
    end 
  end

  /***************************************************************************************************
  * Simple scoreboard doing self checking 
  * Comparing transaction from master VIP monitor with transaction from passsthrough VIP in slave side
  * if they are match, SUCCESS. else, ERROR
  ***************************************************************************************************/
  initial begin
   forever begin
      wait (master_moniter_transaction_queue_size>0 ) begin
        mst_scb_transaction = master_moniter_transaction_queue.pop_front;
        master_moniter_transaction_queue_size--;
        wait( passthrough_slave_moniter_transaction_queue_size>0) begin
          passthrough_slv_scb_transaction = passthrough_slave_moniter_transaction_queue.pop_front;
          passthrough_slave_moniter_transaction_queue_size--;
          if (passthrough_slv_scb_transaction.do_compare(mst_scb_transaction) == 0) begin
            $display("ERROR:  Master VIP against passthrough VIP scoreboard Compare failed");
            error_cnt++;
          end else begin
            $display("SUCCESS: Master VIP against passthrough VIP scoreboard Compare passed");
          end
          comparison_cnt++;
        end  
      end 
    end
  end
 
  /***************************************************************************************************
  * Simple scoreboard doing self checking 
  * Comparing transaction from passthrough VIP in master side with transaction from Slave VIP 
  * if they are match, SUCCESS. else, ERROR
  ***************************************************************************************************/
  initial begin
    forever begin
      wait (slave_moniter_transaction_queue_size>0 ) begin
        slv_scb_transaction = slave_moniter_transaction_queue.pop_front;
        slave_moniter_transaction_queue_size--;
        wait( passthrough_master_moniter_transaction_queue_size>0) begin
          passthrough_mst_scb_transaction = passthrough_master_moniter_transaction_queue.pop_front;
          passthrough_master_moniter_transaction_queue_size--;
          if (slv_scb_transaction.do_compare(passthrough_mst_scb_transaction) == 0) begin
            $display("ERROR: Slave VIP against passthrough VIP scoreboard Compare failed");
            error_cnt++;
          end else begin
            $display("SUCCESS: Slave VIP against passthrough VIP scoreboard Compare passed");
          end
          comparison_cnt++;
        end  
      end 
    end
  end

endmodule
