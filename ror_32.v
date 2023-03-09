module ror_32(
  input [31:0] A, num_rotate,
  output [31:0] Z
);
  wire [31:0] t;
  wire [31:0] t2;
  
  shl_32 SL(A, 32-num_rotate, t);
  shr_32 SR2(A, num_rotate, t2);
  or_32 OR(t2, t, Z);
endmodule
