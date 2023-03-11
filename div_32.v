module div_32(input [31:0] dividend, divisor, output [31:0] quotient, remainder);
	reg [31:0] m,q;
	reg [32:0] temp;
	integer i;
	
	always @(*)
	begin
		// initialize
		temp = 0;
		q = dividend;
		m = divisor;
		
		// 32 cycles for 32 bits
		for(i = 0; i<32; i = i+1) begin
			
			// shift left both variables, q's leftmost bit gets carried into r's rightmost after shift
			temp = temp<<1;
			temp[0] = q[31];
			q = q<<1;

			// sub m from temp
			temp = temp-m;
			
			// temp negative add m, positive q[0]=0 and restore
			if (temp[31]==1) begin
				temp = temp + m;
				q[0] = 0;
			end else begin
				q[0] = 1;
			end
			// //add or subtract is executed accordingly
			// r = r+temp;
			
			// //check if r is negative. if positive rightmost bit of q set to 1
			// if(r[31]) q = q | 0;
			// else q = q | 1;
			
		end
		
		// // if r negative restore
		// if(r[31])
		// 	r=r+divisor;
	end
	assign quotient = q;
	assign remainder = temp[31:0];
endmodule
	
	
