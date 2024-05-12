class transaction #(parameter WIDTH = 4);

  //declare the transaction fields for ALU DUT
  rand bit [WIDTH-1:0] A;
  rand bit [WIDTH-1:0] B;
  rand bit[1:0] MODE;
  bit [WIDTH:0] Y;
  //rstn signal defualt value is 1 becasue it is active low
  bit rstn =1;

  

  function void display(string name);
    $display("-------------------------");
    $display("- %s ", name);
    display_in("port in");
    display_out("port out");
    $display("-------------------------");

  endfunction

  function void display_in(string name);
    $display(name);
    $display("A = %b", A);
    $display("B = %b", B);
    $display("MODE = %b", MODE);

  endfunction

  function void display_out(string name);
    $display(name);
    $display("Y = %b", Y);
  endfunction

endclass
