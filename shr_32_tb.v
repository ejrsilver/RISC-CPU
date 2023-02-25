`timescale 1ns/10ps

module shr_32_tb;

	reg[31:0] input_a, shift;
	wire[31:0] shr_result;

	shr_32 shr(input_a, shift, shr_result);

	initial
		begin
			input_a <= 32;
			shift <= 2;
		end
endmodule
