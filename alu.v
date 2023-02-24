`timescale 1ns/10ps

module alu(
    input clk, IncPC,
    input [31:0] B, Y,
    input [4:0] opcode,
    output [31:0] HI, LO
);

parameter   _add  = 5'b00011, _sub = 5'b00100, _and = 5'b00101, _or  = 5'b00110, _shr  = 5'b00111, 
            _shra = 5'b01000, _shl = 5'b01001, _ror = 5'b01010, _rol = 5'b01011, _addi = 5'b01100,
            _andi = 5'b01101, _ori = 5'b01110, _mul = 5'b01111, _div = 5'b10000, _neg  = 5'b10001,
            _not  = 5'b10010;


wire[31:0]  or_out,    and_out, rol_out,  ror_out,   shl_out,   shr_out,
            shra_out,  not_out, neg_out,  HImul_out, LOmul_out, HIdiv_out,
            LOdiv_out, add_out, sub_out,  incPC_out;
wire add_cout, sub_cout;

// Operations 
or_32   OR  (Y, B, or_out);
and_32  AND (Y, B, and_out);
rol_32  ROL (Y, B, rol_out);
ror_32  ROR (Y, B, ror_out);
shl_32  SHL (Y, B, shl_out);
shr_32  SHR (Y, B, shr_out);
shra_32 SHRA(Y, B, shra_out);

not_32  NOT (B, not_out);
neg_32  NEG (B, neg_out);

mul_32  MUL (Y, B, HImul_out, LOmul_out);
div_32  DIV (Y, B, HIdiv_out, LOdiv_out);

add_32  ADD (Y, B, 1'b0, add_out, add_cout);
sub_32  SUB (Y, B, 1'b0, sub_out, sub_cout);
incPC   INC (Y, IncPC, incPC_out);

always @(*) begin
    if (IncPC==1) begin
        PC_out <= IncPC_out;
    end
    case (opcode)
        _add: begin
            LO <= add_out;
            HI <= 32'd0;
        end
        _sub: begin
            LO <= sub_out;
            HI <= 32'd0;
        end
        _and: begin
            LO <= and_out;
            HI <= 32'd0;
        end
        _or: begin
            LO <= or_out;
            HI <= 32'd0;
        end
        _shr: begin
            LO <= shr_out;
            HI <= 32'd0;
        end
        _shra: begin
            LO <= shra_out;
            HI <= 32'd0;
        end
        _shl: begin
            LO <= shl_out;
            HI <= 32'd0;
        end
        _ror: begin
            LO <= ror_out;
            HI <= 32'd0;
        end
        _rol: begin
            LO <= rol_out;
            HI <= 32'd0;
        end
        _addi: begin
            LO <= addi_out;
            HI <= 32'd0;
        end
        _andi: begin
            LO <= andi_out;
            HI <= 32'd0;
        end
        _ori: begin
            LO <= ori_out;
            HI <= 32'd0;
        end
         _mul: begin
            LO <= mul_out;
            HI <= 32'd0;
        end
        _div: begin
            LO <= div_out;
            HI <= 32'd0;
        end
        _neg: begin
            LO <= neg_out;
            HI <= 32'd0;
        end
        _not: begin
            LO <= not_out;
            HI <= 32'd0;
        end
        default: begin
            LO <= 32'd0;
            HI <= 32'd0;
        end
    endcase
end