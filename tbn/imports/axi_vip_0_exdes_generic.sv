//----------------------------------------------------------------------------------------------
// Description: 
// This file contains example test lists for one design which consistes of one AXI VIP
// in master mode, one AXI VIP in passthrough mode and one AXI VIP in slave mode.
// In the following scenarios,It demonstrates how master AXI VIP create transactions, slave AXI VIP 
// generate responses and also how passthrough AXI VIP switch into run time master or/and slave mode.
// It also has two simple scoreboards to do self-checking. One scoreboard checks master AXI VIP against
// passthrough AXI VIP and the other scoreboard checks slave AXI VIP against passthrough AXI VIP
// Three methods to setup the transaction after it is being created are done in some of the example tests

import axi_vip_v1_0_2_pkg::*;

module axi_vip_0_exdes_generic(
  );

  typedef enum {
    EXDES_PASSTHROUGH,
    EXDES_PASSTHROUGH_MASTER,
    EXDES_PASSTHROUGH_SLAVE
  } exdes_passthrough_t;

  exdes_passthrough_t                     exdes_state = EXDES_PASSTHROUGH;

  // Error count to check how many comparison failed
  xil_axi_uint                            error_cnt = 0; 
  // Comparison count to check how many comparsion happened
  xil_axi_uint                            comparison_cnt = 0;


  //----------------------------------------------------------------------------------------------
  // the following monitor transactions are for simple scoreboards doing self-checking
  // two Scoreboards are built here
  // one scoreboard checks master vip against passthrough VIP (scoreboard 1)
  // the other one checks passthrough VIP against slave VIP (scoreboard 2)
  // monitor transaction from master VIP
  //----------------------------------------------------------------------------------------------
  axi_monitor_transaction                 mst_monitor_transaction;
  // monitor transaction queue for master VIP 
  axi_monitor_transaction                 master_moniter_transaction_queue[$];
  // size of master_moniter_transaction_queue
  xil_axi_uint                           master_moniter_transaction_queue_size =0;
  //scoreboard transaction from master monitor transaction queue
  axi_monitor_transaction                 mst_scb_transaction;
  // monitor transaction for slave VIP
  axi_monitor_transaction                 slv_monitor_transaction;
  // monitor transaction queue for slave VIP
  axi_monitor_transaction                 slave_moniter_transaction_queue[$];
  // size of slave_moniter_transaction_queue
  xil_axi_uint                            slave_moniter_transaction_queue_size =0;
  // scoreboard transaction from slave monitor transaction queue
  axi_monitor_transaction                 slv_scb_transaction;


  // master vip monitors all the transaction from interface and put then into transaction queue
  initial begin
    #2ps;
    mst_monitor_transaction = new("master monitor transaction");
    forever begin
      mst.agent.monitor.item_collected_port.get(mst_monitor_transaction);
      master_moniter_transaction_queue.push_back(mst_monitor_transaction);
      master_moniter_transaction_queue_size++;
    end  
  end 

  // slave vip monitors all the transaction from interface and put then into transaction queue 
  initial begin
    #2ps;
    slv_monitor_transaction = new("slave monitor transaction");
    forever begin
      slv.agent.monitor.item_collected_port.get(slv_monitor_transaction);
      slave_moniter_transaction_queue.push_back(slv_monitor_transaction);
      slave_moniter_transaction_queue_size++;
    end
  end

  
  //----------------------------------------------------------------------------------------------
  //comparing transaction from passthrough in master side with transaction from Slave VIP 
  // if they are match, SUCCESS. else, ERROR
  //----------------------------------------------------------------------------------------------
  initial begin
    forever begin
      wait (slave_moniter_transaction_queue_size>0 ) begin
        slv_scb_transaction = slave_moniter_transaction_queue.pop_front;
        slave_moniter_transaction_queue_size--;
        wait( master_moniter_transaction_queue_size>0) begin
          mst_scb_transaction = master_moniter_transaction_queue.pop_front;
          master_moniter_transaction_queue_size--;
          if (slv_scb_transaction.do_compare(mst_scb_transaction) == 0) begin
            $display("ERROR: Slave VIP against Master VIP scoreboard Compare failed");
            error_cnt++;
          end else begin
            $display("SUCCESS: Slave VIP against Master VIP scoreboard Compare passed");
          end
          comparison_cnt++;
        end  
      end 
    end
  end
  
endmodule
