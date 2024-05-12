//Samples the interface signals, captures the transaction packet 
//and sends the packet to scoreboard.

class monitor;
  
  //create virtual interface handle
  virtual inf vinf;
  
  //create mailbox handle
  mailbox mon2scb;

  //constructor
  function new(virtual inf vinf,mailbox mon2scb);
    //get the interface
    this.vinf = vinf;
    //get the mailbox handle from environment 
    this.mon2scb = mon2scb;
  endfunction
  
  //Samples the interface signal and sends the sampled packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();
      //data in capture from the interface/driver ALU
      @(posedge vinf.clk)
      trans.A = vinf.A;
      trans.B = vinf.B;
      trans.MODE = vinf.MODE;

      fork begin
      //data in capture from the interface/dut ALU
      // @(negedge vinf.clk) 
      @(posedge vinf.clk)
      trans.Y = vinf.Y;

      mon2scb.put(trans);

      trans.display("[ --Monitor-- ]");
      end join_none 

    end
  endtask
  
endclass
