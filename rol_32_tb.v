`timescale 1ns/10ps

module rol_32_tb;

	reg[31:0] input_a, shift;
	wire[31:0] rol_result;

	rol_32 rol(input_a, shift, rol_result);

	initial
		begin
			input_a <= 32'hxFF000F00;
			shift <= 2;
		end
endmodule
