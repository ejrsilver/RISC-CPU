module decoder_2_4(input [1:0] in, output reg [3:0] out);
always @(*) begin
    case (in)
        2'b00: out <= 4'h1;
        2'b01: out <= 4'h2;
        2'b10: out <= 4'h4;
        2'b11: out <= 4'h8;
    endcase
end
endmodule