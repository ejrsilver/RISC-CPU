`timescale 1ns/10ps

module select_encode_logic(input [31:0] IR_out, input Gra, Grb, Grc, Rin, Rout, BAout, output[4:0] opcode,
    output [31:0] C_sign_extend, output [15:0] R0_15_in, R0_15_out);

wire [3:0] RA, RB, RC, R_dec_in;
wire [15:0] R_dec_out;
assign RA = IR_out[26:23] & {4{Gra}};
assign RB = IR_out[22:19] & {4{Grb}};
assign RC = IR_out[18:15] & {4{Grc}};

assign R_dec_in = RA | RB | RC;
decoder_4_16 DECOD(R_dec_in, R_dec_out);

assign opcode = IR_out[31:27];
assign C_sign_extend = {{13{IR_out[18]}}, IR_out[18:0]};
assign R0_15_in = {16{Rin}} & R_dec_out;
assign R0_15_out = {16{Rout | BAout}} & R_dec_out;

endmodule