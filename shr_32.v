module shr_32(input [31:0] A, num_shift, output [31:0] Z);
assign Z[31:0] = A>>num_shift;
endmodule
