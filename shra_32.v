module shra_32(input signed [31:0] A, input [31:0] num_shift, output [31:0] Z);
assign Z[31:0] = A>>>num_shift;
endmodule
