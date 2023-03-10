module div_32(input signed [31:0] dividend, divisor, output [31:0] quotient, remainder);
	reg [31:0] r,q,temp;
	integer i;
	
	always @(*)
	begin
		//initialize
		q=dividend;
		r=0;
		
		//32 cycles for 32 bits
		for(i = 0; i<32; i = i+1) 
		begin
			
			//shift left both variables, q's leftmost bit gets carried into r's rightmost after shift
			r = (r << 1);
			r = r | q[31];
			q = q << 1;
			
			//if r is negative add divisor, if positive subtract
			if(r[31]) temp = divisor;
			else temp = ~divisor+1;
			//add or subtract is executed accordingly
			r = r+temp;
			
			//check if r is negative. if positive rightmost bit of q set to 1
			if(r[31]) q = q | 0;
			else q = q | 1;
			
		end
		
		// if r negative restore
		if(r[31])
			r=r+divisor;
	end
	assign quotient = q;
	assign remainder = r;
endmodule
	
	
