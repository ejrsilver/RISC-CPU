module div_32(input [31:0] divisor, dividend, output [31:0] q, r);
	reg [31:0] m, q;
    reg [63:0] a;
	
	integer i;
	always @(*) begin
        begin
            q = dividend;
            m = divisor;
            a = 0;
            
            for(int i = 0;i < 32;i = i + 1) begin
                a = {a[31:0],q[31]};
                q = q<<1;
                a = a - m;

                if(a[31]==1) begin 
					q[0] = 0;
					a = a + m;
				end
                else begin
					q[0] = 1;
				end
            end
        end
	end
	r = A[63:32];
	q = A[31:0];
endmodule
