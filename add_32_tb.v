`timescale 1ns/10ps

module add_32_tb;

  reg[31:0] input_a, input_b, cin, cout;
  wire[31:0] add_result;

  add_32 add_instance(input_a, input_b, cin, add_result, cout);

	initial
		begin
			input_a <= 2;
			input_b <= 3;
      cin <= 0;
      #125
      input_a <=2;
      input_b <=3;
      cin <=1;
      #250
      input_a <= 32'hFFFFFFFF;
      input_b <= 10;
      cin <= 0;
      #375
      input_a <= 32'hFFFFFFFF;
      input_b <= 10;
      cin <= 1;
		end
endmodule
