`timescale 1ns/10ps

module shl_32_tb;

	reg[31:0] input_a, shift;
	wire[31:0] shl_result;

	shl_32 shl(input_a, shift, shl_result);

	initial
		begin
			input_a <= 6;
			shift <= 2;
		end
endmodule
