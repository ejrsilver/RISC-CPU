module div_32(input [31:0] divisor, dividend, output reg [31:0] q, r);
  reg [63:0] A;
  A[31:0] = dividend;
  
  genvar i;
  generate 
    for(int i = 0;i < 32;i = i + 1) begin
      A = A<<1;
      A[63:32] = A[63:32] - divisor;
      if(A[63:32]<0) 
        begin 
          A[0] = 0;
          A[63:32] = A[63:32] + divisor;
        end
      if(A[63:32] > 0 || A[63:32] == 0)
        begin
          A[0] = 1;
          A[0] = 1;
        end
    end
   endgenerate
  r = A[63:32];
  q = A[31:0];
    end
   endgenerate
  r = A[63:32];
  q = A[31:0];
endmodule
