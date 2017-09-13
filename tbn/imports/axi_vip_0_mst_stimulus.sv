
/***************************************************************************************************
* Description: 
* This file contains examples showing how user can generate simple write and/or read transaction 
* According to VIP's WRITE_READ_MODE. user will see different examples.
* WRITE_ONLY - simple write transaction
* READ_ONLY  - simple read transaction
* READ_WRITE - both simple write and read transaction

*  For Master VIP to work correctly, user environment MUST have to do the following lists of item
*  and follow the same order as shown here.  Item 1 to 5 can be copied into a user testbench but
*  care of the ordering must be taken into account.    
*    1. import two packages.
*         import axi_vip_v1_0_2_pkg::*; 
*         import ex_sim_axi_vip_mst_0_pkg::*;
*    2. delcare "component_name"_mst_t agent
*    3. new agent (passing instance IF correctly)
*    4. start_master
*    5. generate transaction
*      5.1 create_transaction
*      5.2. Fill in transaction( two methods. randomization and API)
*      5.3. send transaction
* More details about generate transaction please refer task wr/rd_tran_method_one/two
***************************************************************************************************/

import axi_vip_v1_0_2_pkg::*;
import ex_sim_axi_vip_mst_0_pkg::*;

module axi_vip_0_mst_stimulus();
  
  /*************************************************************************************************
  * "Component_name"_mst_t for master agent
  * "Component_name can be easily found in vivado bd design: click on the instance, 
  * Then click CONFIG under Properties window and Component_Name will be shown
  * More details please refer PG267 for more details
  *************************************************************************************************/
  ex_sim_axi_vip_mst_0_mst_t                              agent;

  initial begin
    /***********************************************************************************************
    * Before agent is newed, user has to run simulation with an empty testbench to find the hierarchy
    * path of the AXI VIP's instance.Message like
    * "Xilinx AXI VIP Found at Path: my_ip_exdes_tb.DUT.axi_vip_mst.inst" will be printed 
    * out. Pass this path to the new function. 
    ***********************************************************************************************/
    agent = new("master vip agent",DUT.axi_vip_mst.inst.IF);
    agent.start_master();                   // agent start to run

    fork                                    // Fork process of write/read transaction generation                    
  
      begin  
        wr_tran_method_one();
        wr_tran_method_two();   
      end
 
      begin
        rd_tran_method_one();
        rd_tran_method_two(); 
      end  
    join

    agent.wait_drivers_idle();              // Wait driver is idle then stop the simulation
    if(generic_tb.error_cnt ==0) begin
      $display("EXAMPLE TEST DONE : Test Completed Successfully");
    end else begin  
      $display("EXAMPLE TEST DONE ",$sformatf("Test Failed: %d Comparison Failed", generic_tb.error_cnt));
    end 
    $finish;
  end

  /*************************************************************************************************
  * Write transaction method one
  * This simple task shows how user can generate one write transaction with randomization
  * 1. Declare a handle for write transaction
  * 2. Write driver of the agent creates write transaction
  * 3. Randomized the transaction - WR_TRANSACTION_FAIL is a tag to tell user when randomization fails
  * 4. Write driver of the agent sends the transaction to Master VIP interface
  *************************************************************************************************/
  task wr_tran_method_one();
    axi_transaction                         wr_transaction; 
    wr_transaction = agent.wr_driver.create_transaction( "write transaction with randomization");
    WR_TRANSACTION_FAIL: assert(wr_transaction.randomize());
    agent.wr_driver.send(wr_transaction);
  endtask :wr_tran_method_one

  /*************************************************************************************************
  * Write transaction method two:
  * This simple task shows how user can generate a transaction and fill in information with APIs
  * 1. Declare a handle for write transaction
  * 2. Declare all the variables needed for APIs
  * 3. Assign values to the variables - please make sure that values being assigned here do not
  *    violate protocol. For example, mtestADDR can't exceed address range(0,1<<addr_width-1)  
  * 4. Write driver of the agent creates write transaction 
  * 5. Fill in the transaction with APIs 
  *   5.1 Fill in addr, burst,ID,length,size by calling set_write_cmd(addr, burst,ID,length,size), 
  *       different protocol has minimum arguments: 
  *       x here means user can use default value 
  *       AXI4-Lite, set_write_cmd(addr,x,x,x,x),
  *       AXI3, set_write_cmd(addr,x,x,length,size)
  *       AXI4, set_write_cmd(addr,x,x,length, size)
  *   5.2 Fill in beats
  *   5.3 Fill in AWUSER if AWUSER_WIDH is bigger than 0
  *   5.4 Fill in WUSER if WUSR_WIDTH is bigger than 0
  *   Note: members inside transaction is not set here are using default value
  * 6. Write driver of the agent sends the transaction 
  *************************************************************************************************/
  task wr_tran_method_two();
    axi_transaction              wr_transaction;     //Declare an object handle of write transaction
    xil_axi_uint                 mtestID;            // Declare ID  
    xil_axi_ulong                mtestADDR;          // Declare ADDR  
    xil_axi_len_t                mtestBurstLength;   // Declare Burst Length   
    xil_axi_size_t               mtestDataSize;      // Declare SIZE  
    xil_axi_burst_t              mtestBurstType;     // Declare Burst Type  
    xil_axi_data_beat [255:0]    mtestWUSER;         // Declare Wuser  
    xil_axi_data_beat            mtestAWUSER;        // Declare Awuser  
    /***********************************************************************************************
    * A burst can not cross 4KB address boundry for AXI4
    * Maximum data bits = 4*1024*8 =32768
    * Write Data Value for WRITE_BURST transaction
    * Read Data Value for READ_BURST transaction
    ***********************************************************************************************/
    bit [32767:0]                 mtestWData;         // Declare Write Data 

    mtestID = 0;
    mtestADDR = 0;
    mtestBurstLength = 0;
    mtestDataSize = xil_axi_size_t'(xil_clog2(32/8));
    mtestBurstType = XIL_AXI_BURST_TYPE_INCR; 
    wr_transaction = agent.wr_driver.create_transaction("write transaction in API");
    wr_transaction.set_write_cmd(mtestADDR,mtestBurstType,mtestID,mtestBurstLength,mtestDataSize);
    wr_transaction.set_data_block(mtestWData);
    agent.wr_driver.send(wr_transaction);
  endtask :wr_tran_method_two

  /*************************************************************************************************
  * Read transaction method one 
  * This simple task shows how user can generate one read transaction with randomization
  * 1. Declare a handle for read transaction
  * 2. Read driver of the agent create_transaction
  * 3. Randomized the transaction - RD_TRANSACTION_FAIL is a tag to tell user when randomization fails
  * 4. Read driver of the agent sends the transaction to Master VIP interface
  *************************************************************************************************/
  task rd_tran_method_one();  
    axi_transaction                         rd_transaction;
    rd_transaction = agent.rd_driver.create_transaction("read transaction with randomization");
    RD_TRANSACTION_FAIL_1a:assert(rd_transaction.randomize());
    agent.rd_driver.send(rd_transaction);
  endtask 

  /************************************************************************************************
  * Read transaction method two
  * This simple task shows how user can generate a transaction and fill in information with APIs 
  * 1. Declare a handle for read transaction
  * 2. Declare all the variables needed for APIs
  * 3. Assign values to the variables - please make sure that values being assigned here do not
  *    violate protocol. For example, mtestADDR can't exceed address range(0,1<<addr_width-1)  
  * 4. Read driver of the agent create_transaction 
  * 5. Fill in the transaction with APIs 
  *   5.1 Fill in addr, burst,ID,length,size by calling set_read_cmd(addr, burst,ID,length,size), 
  *       different protocol has minimum arguments: 
  *       x here means user can use default value 
  *       AXI4-Lite, set_read_cmd(addr,x,x,x,x),
  *       AXI3, set_read_cmd(addr,x,x,length,size)
  *       AXI4, set_read_cmd(addr,x,x,length, size)
      5.2 Fill in ARUSER if ARUSER_WIDH is bigger than 0
  * 6. Read driver of the agent sends the transaction out
  *************************************************************************************************/
  task rd_tran_method_two();
    axi_transaction              rd_transaction;     // Declare an object handle of read transaction
    xil_axi_uint                 mtestID;           // Declare ID  
    xil_axi_ulong                mtestADDR;         // Declare ADDR  
    xil_axi_len_t                mtestBurstLength;  // Declare Burst Length   
    xil_axi_size_t               mtestDataSize;     // Declare SIZE  
    xil_axi_burst_t              mtestBurstType;    // Declare Burst Type  
    xil_axi_data_beat            mtestARUSER;       // Declare Aruser  

    /***********************************************************************************************
    * A burst can not cross 4KB address boundry for AXI4
    * Maximum data bits = 4*1024*8 =32768
    * Write Data Value for WRITE_BURST transaction
    * Read Data Value for READ_BURST transaction
    ***********************************************************************************************/
    bit [32767:0]                 mtestRData;         // Declare Read Data
    mtestID = 0;
    mtestADDR = 0;
    mtestBurstLength = 0;
    mtestDataSize = xil_axi_size_t'(xil_clog2(32/8));
    mtestBurstType = XIL_AXI_BURST_TYPE_INCR; 
    rd_transaction = agent.rd_driver.create_transaction("read transaction");
    rd_transaction.set_read_cmd(mtestADDR,mtestBurstType,mtestID,mtestBurstLength,mtestDataSize);
    agent.rd_driver.send(rd_transaction);
  endtask

  /*************************************************************************************************
  * RREADY Generation with customized pattern
  * Master read driver create rready
  * Set rready generation policy
  * Set low/high time
  * Master read driver send rready
  * NOTE: if user wants default pattern of ready generation,nothing needs to be done

  task user_gen_rready();  
    axi_ready_gen                           rready_gen;
    rready_gen = agent.rd_driver.create_ready("rready");
    rready_gen.set_ready_policy(XIL_AXI_READY_GEN_AFTER_VALID_OSC);
    rready_gen.set_low_time(2);
    rready_gen.set_high_time(1);
    agent.rd_driver.send_rready(rready_gen);
  endtask
  *************************************************************************************************/

  /**********************************************************************************************
  * Note: if multiple agents are called in one testbench,it will be hard to tell which
  * agent is complaining. set_agent_tag can be used to set a name tag for each agent
    agent.set_agent_tag("My Master VIP one");

  * If user wants to know all the details of each transaction, set_verbosity can be used to set
  * up information being printed out or not. Default is no print out 
    * Verbosity level which specifies how much debug information to produce
    *    0       - No information will be printed out.
    *   400      - All information will be printed out
    agent.set_verbosity(0);

  * These two lines should be added anywhere after agent is being newed  
  *************************************************************************************************/



endmodule 
