module div_32(input [31:0] divisor, dividend, output [31:0] quot, rem);
	reg [31:0] m, q;
    reg [63:0] a;
	
	integer i;
	always @(*) begin
            q = dividend;
            m = divisor;
            a = {32'b0,q};

            for (i = 0;i < 32;i = i + 1) begin
                a = a<<1;
                a = {a[63:32] - m, a[31:0]};

                if(a[31]==1) begin
					a[0] = 0;
                    a = {a[63:32] + m, a[31:0]};
				end
                else begin
					a[0] = 1;
				end
            end
        end
	assign rem = a[63:32];
	assign quot = a[31:0];
endmodule
