module mul_32(
  input [31:0] A, B,
  output [63:0] Z
);
  reg [63:0] temp;
  reg [2:0] A_for_booth[15:0];
	
  reg [63:0] product;
	wire [32:0] N_A;
  
	integer j,i;
	
  neg_32(A, N_A);
	
  always @ (A or B or N_A)
	begin
		A_for_booth[0] = {b[1], b[0], 0};
		
    for (j=1; j < 16; j = j+1)
			A_for_booth[j] = {b[2*j+1], b[2*j], b[2*j-1]};
			
    for (j=0; j < 16; j = j+1) begin	
			case(A_for_booth[j])
        3'b001 : 
          add_32 ADD_A (temp[31+2*j:2*j]
        3'b010 :
				3'b011 :
        3'b100 :
				3'b101 :
				3'b110 :
				default :
			endcase
		end
	end
endmodule
