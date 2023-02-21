`timescale 1ns/10ps

module mul_32_tb;

  reg[31:0] input_a, input_b;
  wire[31:0] HI, LO;

  mul_32 mul_instance(input_a, input_b, HI, LO);
	initial
		begin
			input_a <= 2;
			input_b <= 3;
      #125
      input_a <=5;
      input_b <=3;
      #250
      input_a <= 32'hFFFFFFFF;
      input_b <= 24;
      #375
      input_a <= 32'hFFFFFFFF;
      input_b <= 10;
		end
endmodule
