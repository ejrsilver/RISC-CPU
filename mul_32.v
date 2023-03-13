module mul_32(
	input signed [31:0] A, B,
	output [31:0] HI, LO
);
	reg [2:0] B_for_booth[15:0];
	reg signed [32:0] pp [15:0];
	reg signed [63:0] spp [15:0];
	reg signed [63:0] temp;

	wire signed [31:0] N_A;
	wire signed [31:0] N_A_2;
	wire signed [31:0] A_2;

	integer j;

	assign N_A = -A;
	assign A_2 = A<<1;
	assign N_A_2 = N_A<<1;

  always @ (A or B or N_A)
	begin
		B_for_booth[0] = {B[1], B[0], 1'b0};

		for (j=1; j < 16; j = j+1) begin
			B_for_booth[j] = {B[2*j+1], B[2*j], B[2*j-1]};
		end
    		
		for (j=0; j < 16; j = j+1) begin
			case(B_for_booth[j])
				3'b001, 3'b010 :
					pp[j] = {A[31],A};
				3'b011 :
					pp[j] = {A_2[31],A_2};
				3'b100 :
					pp[j] = {N_A_2[31],N_A_2};
				3'b101, 3'b110 :
					pp[j] = {N_A[31],N_A};
				default :
					pp[j] = 0;
			endcase

			spp[j] = pp[j] << (2*j);
		end

		temp = spp[0];
		for (j=1; j < 16; j=j+1) begin
			temp = temp + spp[j];
		end
	end
	assign HI = temp[63:32];
	assign LO = temp[31:0];
endmodule