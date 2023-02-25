module divide_32(input [31:0] divisor, dividend, output [31:0] quot, rem);
	reg [31:0] m, q;
    reg [63:0] a;
	
	integer i;
	always @(*) begin
            q = dividend;
            m = divisor;
            a = 0;
            
            for(i = 0;i < 32;i = i + 1) begin
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
	assign rem = a[63:32];
	assign quot = a[31:0];
endmodule
