`timescale 1ns/10ps

module ror_32_tb;

	reg[31:0] input_a, shift;
	wire[31:0] ror_result;

	ror_32 ror(input_a, shift, ror_result);

	initial
		begin
			input_a <=33;
			shift <= 2;
		end
endmodule
