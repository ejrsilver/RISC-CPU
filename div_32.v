module div_32(input [31:0] dividend, divisor, output [31:0] quot, rem);
	reg [31:0] m, q;
    reg [32:0] a;
	
	integer i;
	always @(*) begin
            q = dividend;
            m = divisor;
            a = 0;

            for (i = 0;i < 32;i = i + 1) begin
                a = {a[32:1], q[31]};
				q[31:1] = q[30:0];
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
	assign quot = a[31:0];
	assign rem = q;
endmodule
