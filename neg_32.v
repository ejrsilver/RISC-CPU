module neg_32(
  input[31:0] A,
  output[31:0] Z
);

  wire [31:0] inter;
  wire cout;
  not_32 NOT_inst(A,inter);
  add_32 ADD_inst(inter, 1, 0, Z, cout);
endmodule
