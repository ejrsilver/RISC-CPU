module select_and_encode(input [31:0] IR, input Gra, input Grb, input Grc, input Rin, input Rout, input BAout,
                         output [31:0] C_sign_extended, output [4:0] opcode, output [15:0] regIn, output [15:0] regOut, output wire [3:0] decoderIn);
  //get encoded reg value
  assign decoderIn = (IR[26:23] & {4{Gra}}) | (IR[22:19] & {4{Grb}}) | (IR[18:15] & {4{Grc}});
  
  wire [15:0] decoderOut;
  //decode encoded reg value
  decode_4_16 decoderInstance(decoderIn,decoderOut);
  
  //strip opcode from IR
  assign opcode = IR[31:27];
  
  //and gates following decoder
  assign regIn = decoderOut & {16{Rin}};
  assign regOut = decoderOut & ({16{Rout}} | {16{BAout}});
  //derive C sign extended
  assign C_sign_extended = {{13{IR[18]}},IR[18:0]};
endmodule
