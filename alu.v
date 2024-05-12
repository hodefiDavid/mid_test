module alu #(
    parameter WIDTH = 4
) (
    clk,
    rstn,
    A,
    B,
    MODE,
    Y
);

  input [WIDTH-1:0] A, B;
  input [1:0] MODE;
   input clk, rstn;
  output reg [WIDTH:0] Y;

  always @(posedge clk or negedge rstn)
    if (!rstn) Y = 0;
    else begin
      case (MODE)
        0: Y = A + B;
        1: Y = A - B;
        2: Y = A + 1;
        3: Y = B + 1;
      endcase

    end

endmodule
