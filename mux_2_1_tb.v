`timescale 1ns/10ps

module mux_2_1_tb;

	reg [31:0] input1, input2;
   reg sig;
   wire [31:0] out;

	mux_2_1 mux1(input1, input2, sig, out);

	initial
		begin
			input1 <= 1;
			input2 <= 2;
			sig <= 0;
			#150
			input1 <= 1;
			input2 <= 2;
			sig <= 1;
		end
endmodule
