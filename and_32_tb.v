`timescale 1ns/10ps

module and_32_tb;

	reg[31:0] input_a, input_b;
	wire[31:0] and_result;

	and_32 and_instance(input_a, input_b, and_result);

	initial
		begin
			input_a <= 2;
			input_b <= 3;
		end
endmodule
