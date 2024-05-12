//testbench top is the top most file, in which DUT and Verification environment are connected. 

//include interfcae 
`include "interface.sv"

`include "ALU_fixed.svp"
//include one test at a time
`include "random_test.sv"
//`include "directed_test.sv"

module top;
  
  //clock and reset signal declaration
  bit clk;
  bit rstn;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset generation
  initial begin
    rstn = 0;
    #15 rstn =1;
  end
  
  
  //interface instance in order to connect DUT and testcase
  inf i_inf(clk,rstn);
  
  //testcase instance, interface handle is passed to test 
  test t1(i_inf);
  
  //DUT instance, interface handle is passed to test 
    // alu c1 (.A(i_inf.A), .B(i_inf.B), .MODE(i_inf.MODE),
    //         .Y(i_inf.Y), .rstn(i_inf.rstn),.clk(i_inf.clk));
 ALU c1 (.A(i_inf.A), .B(i_inf.B), .mode(i_inf.MODE),
            .Y(i_inf.Y), .rst_n(i_inf.rstn),.clk(i_inf.clk));
endmodule