module seg_7_out(input [3:0] datain, output reg [7:0] dataout);
always @(*) begin
	case (datain)
	4'b0000: dataout <= 8'b11000000;
	4'b0001: dataout <= 8'b11111001;
	4'b0010: dataout <= 8'b10100100;
	4'b0011: dataout <= 8'b10110000;
	4'b0100: dataout <= 8'b10011001;
	4'b0101: dataout <= 8'b10010010;
	4'b0110: dataout <= 8'b10000010;
	4'b0111: dataout <= 8'b11111000;
	4'b1000: dataout <= 8'b10000000;
	4'b1001: dataout <= 8'b10010000;
	4'b1010: dataout <= 8'b10001000;
	4'b1011: dataout <= 8'b10000011;
	4'b1100: dataout <= 8'b11000110;
	4'b1101: dataout <= 8'b10100001;
	4'b1110: dataout <= 8'b10000110;
	4'b1111: dataout <= 8'b10001110;
	endcase
end
endmodule	