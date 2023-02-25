`timescale 1ns/10ps

module shra_32_tb;

	reg[31:0] input_a, shift;
	wire[31:0] shra_result;

	shra_32 shr(input_a, shift, shra_result);

	initial
		begin
			input_a <=-600;
			shift <= 2;
		end
endmodule
