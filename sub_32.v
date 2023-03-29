module sub_32(input [31:0] A, B, input Cin, output[31:0] Z, output Cout);
wire[31:0] inter;
neg_32 NEG_INST(B, inter);
add_32 ADD_INST(A, inter, Cin, Z, Cout);
endmodule
