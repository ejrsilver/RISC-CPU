`timescale 1ns/10ps

module conff(input [1:0] IR, input [31:0] busout, input CONin, output reg CONout);
wire [3:0] dec_out;
wire eq;
wire neq;
wire p;
wire n;
wire br_flag;

assign eq = (busout == 32'd0);
assign neq = ~eq;
assign p = (busout[31] == 0);
assign n = ~p;

decoder_2_4 dec_conff(IR, dec_out);

assign br_flag = (dec_out[0] & eq | dec_out[1] & neq | dec_out[2] & p | dec_out[3] & n);

initial
    CONout = 0;

always @(CONin) begin
    CONout <= br_flag;
end

endmodule