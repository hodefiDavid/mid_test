//gets the packet from the monitor, generates the expected results 
//and compares with the actual results received from the monitor
`include "reference.sv"

class scoreboard;
   
  //create mailbox handle
  mailbox mon2scb;
  reference rfm;
  transaction res; 

  //count the number of transactions
  int num_transactions;
  
  int num_errors;
  int num_success;

  // coverage group handle
  covergroup covg;
  cover_point_A : coverpoint res.A
  {
    bins A_0 = {0};
    bins A_low = {[0:7]};
    bins A_high = {[8:15]};
    bins A_15 = {15};
  }
  cover_point_B : coverpoint res.B
    {
    bins B_0 = {0};
    bins B_low = {[0:7]};
    bins B_high = {[8:15]};
    bins B_15 = {15};
  }
  cover_point_MODE : coverpoint res.MODE
  {
    bins MODE_ADD = {0};
    bins MODE_SUB = {1};
    bins MODE_INCA = {2};
    bins MODE_INCB = {3};
  }
  cover_point_Y : coverpoint res.Y  
  {
    bins Y_0 = {0};
    bins Y_low = {[0:7]};
    bins Y_high = {[8:15]};
    bins Y_15 = {15};
  }
  //cross coverage  
  res_A_B_special_cross : cross cover_point_A, cover_point_B 
  {
    bins A_gt_B = {A > B};
    bins A_eq_B = {A == B};
    bins A_lt_B = {A < B};
  }
  res_A_B_MODE_cross : cross cover_point_A, cover_point_B , cover_point_MODE;

  res_A_MODE_cross : cross cover_point_A, cover_point_MODE {
    bins A_ADD = {A == 0 && MODE == 0};
    bins A_SUB = {A == 0 && MODE == 1};
    bins A_INCA = {A == 0 && MODE == 2};
    bins A_INCB = {A == 0 && MODE == 3};
  }
  res_B_MODE_cross : cross cover_point_B, cover_point_MODE {
    bins B_ADD = {B == 0 && MODE == 0};
    bins B_SUB = {B == 0 && MODE == 1};
    bins B_INCA = {B == 0 && MODE == 2};
    bins B_INCB = {B == 0 && MODE == 3};
  }
  res_A_B_MODE_cross : cross cover_point_A, cover_point_B, cover_point_MODE {
    bins A_B_ADD = {A == 0 && B == 0 && MODE == 0};
    bins A_B_SUB = {A == 0 && B == 0 && MODE == 1};
    bins A_B_INCA = {A == 0 && B == 0 && MODE == 2};
    bins A_B_INCB = {A == 0 && B == 0 && MODE == 3};
  }

    res_A_B_0_MODE_cross : cross cover_point_A, cover_point_B, cover_point_MODE {
    bins A_B_ADD = {A == 0 && B == 0 && MODE == 0};
    bins A_B_SUB = {A == 0 && B == 0 && MODE == 1};
    bins A_B_INCA = {A == 0 && B == 0 && MODE == 2};
    bins A_B_INCB = {A == 0 && B == 0 && MODE == 3};
  }

    res_A_B_1111_MODE_cross : cross cover_point_A, cover_point_B, cover_point_MODE {
    bins A_B_ADD = {A == 15 && B == 15 && MODE == 0};
    bins A_B_SUB = {A == 15 && B == 15 && MODE == 1};
    bins A_B_INCA = {A == 15 && B == 15 && MODE == 2};
    bins A_B_INCB = {A == 15 && B == 15 && MODE == 3};
  }
  endgroup

  
  //constructor
  function new(mailbox mon2scb);
    //get the mailbox handle from  environment 
    this.mon2scb = mon2scb;
    this.rfm = new();
    this.res = new();
    covg cg = new();

  endfunction
  
  //Compare the actual results with the expected results
  task main;
    //transaction that we receive from the monitor from the driver/Interface
    transaction trans;
    //transaction that we receive from the monitor from the DUT/Interface


    forever begin
      $display("num of transactions: %d", num_transactions);
      $display("num of errors: %d", num_errors);
      $display("num of success: %d", num_success);
      mon2scb.get(trans);
      //here we are sending the transaction packet to reference model
      res = rfm.step(trans);
      //compare the actual results with the expected results
      if(res.Y == trans.Y) begin
          $display("Result is as Expected");
          num_success++;
          //covergroup sample
          cg.sample();
      end
        else begin

          $error("Wrong Result!");
          trans.display("[ --Scoreboard DUT-- ]");
          res.display("[ --Scoreboard REF-- ]");
          num_errors++;
        end
        num_transactions++;
    end
  endtask



  
endclass