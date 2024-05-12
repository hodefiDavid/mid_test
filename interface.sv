interface inf #(parameter WIDTH = 4) (input logic clk,rstn);
  
  //declare the signals for the interface ALU DUT

  bit [WIDTH-1:0] A;
  bit [WIDTH-1:0] B;
  bit [1:0] MODE;
  bit [WIDTH:0] Y;
           
  modport DUT (input A,B,MODE,rstn,clk,output Y);
  
endinterface