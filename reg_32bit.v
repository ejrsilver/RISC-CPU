module reg_32bit(input [31:0] D, input clk, reset, enable, output reg [31:0] q);
  initial q = 0;
  
  always @(posedge clk) begin
    if (reset) begin
      q[31:0] = 32'b0;
    end
    else if (enable) begin
      q[31:0] = D[31:0];
    end
  end
endmodule
