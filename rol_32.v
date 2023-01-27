module rol_32(
  input [31:0] A, num_rotate,
  output [31:0] Z
);
  genvar i;
  wire [31:0] t;
  wire [31:0] t2;
  //assign t = A<<31-num_rotate;
  //assign t = t>>31-num_rotate;
  //assign Z = A<<num_rotate | t;
  
  shl_32 SL(A, 31-num_rotate, t);
  shr_32 SR(t, 31-num_rotate, t);
  shr_32 SR2(A, num_rotate, t2);
  or_32 OR(t2, t, Z);

endmodule
