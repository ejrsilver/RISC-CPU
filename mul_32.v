module mul_32(
	input [31:0] B, A,
	output [31:0] HI, LO
);
	reg [64:0] temp;
	reg [2:0] A_for_booth[15:0];
	
 	reg [63:0] product;
	
	wire cin;
	assign cin = 0;
	wire cout;
	wire [32:0] N_A;
	wire [32:0] N_A_2;
	wire [32:0] A_2;
  
	integer j,i;
	
	neg_32(A, N_A);
	shl_32(A, A_2);
	shl_32(N_A, N_A_2);
	
	
  always @ (A or B)
	begin
		A_for_booth[0] = {b[1], b[0], 0};
		
		for (j=1; j < 32; j = j+2)
			A_for_booth[j] = {b[j+1], b[j], b[j-1]};
			
    		for (j=0; j < 16; j = j+1) begin	
			case(A_for_booth[j])
				3'b001 : 
					add_32(B,A,cin,temp[31+2*j:0+2*j],temp[32+2*j]);
				3'b010 :
					add_32(B,A,cin,temp[31+2*j:0+2*j],temp[32+2*j]);
				3'b011 :
					add_32(B,A_2,cin,temp[31+2*j:0+2*j],temp[32+2*j]);
				3'b100 :
					add_32(B,N_A_2,cin,temp[31+2*j:0+2*j],temp[32+2*j]);
				3'b101 :
					add_32(B,N_A,cin,temp[31+2*j:0+2*j],temp[32+2*j]);
				3'b110 :
					add_32(B,N_A,cin,temp[31+2*j:0+2*j],temp[32+2*j]);
				default :
			endcase
		end
	end
assign HI[31:0] = temp[63:32];
assign LO[31:0] = temp[31:0];				
endmodule
