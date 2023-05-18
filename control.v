`timescale 1ns/10ps
module control(input clk, clr, stop, input [31:0] IR, output reg Read, Write, IncPC, MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, OutPortin, PCout, Zhighout, Zlowout, MDRout, HIout, LOout, BAout, InPortout, Cout, CONin, Gra, Grb, Grc, Rin, Rout, Run, output reg [15:0] R_select);
parameter _ld = 5'b00000, _ldi = 5'b00001, _st = 5'b00010, _add  = 5'b00011, _sub = 5'b00100, _and = 5'b00101, _or  = 5'b00110, _shr  = 5'b00111,
_shra = 5'b01000, _shl = 5'b01001, _ror = 5'b01010, _rol = 5'b01011, _addi = 5'b01100, _andi = 5'b01101, _ori = 5'b01110, _mul = 5'b01111,
_div = 5'b10000, _neg  = 5'b10001, _not  = 5'b10010, _branch = 5'b10011, _jr = 5'b10100, _jal = 5'b10101, _in = 5'b10110, _out = 5'b10111,
_mfhi = 5'b11000, _mflo = 5'b11001, _nop = 5'b11010, _halt = 5'b11011, _subi = 5'b11100;
parameter Default = 6'd0, T0 = 6'd1, T1 = 6'd2, T2 = 6'd3, A_T3 = 6'd4, A_T4 = 6'd5, A_T5 = 6'd6, N_T3 = 6'd7, N_T4 = 6'd8, MD_T3 = 6'd9, MD_T4 = 6'd10, MD_T5 = 6'd11, MD_T6 = 6'd12,
LD_T3 = 6'd13, LD_T4 = 6'd14, LD_T5 = 6'd15, LD_T6 = 6'd16, LD_T7 = 6'd17, LDI_T3 = 6'd18, LDI_T4 = 6'd19, LDI_T5 = 6'd20, ST_T3 = 6'd21, ST_T4 = 6'd22, ST_T5 = 6'd23, ST_T6 = 6'd24, ST_T7 = 6'd25,
B_T3 = 6'd26, B_T4 = 6'd27, B_T5 = 6'd28, B_T6 = 6'd29, JR_T3 = 6'd30, JAL_T3 = 6'd31, JAL_T4 = 6'd32, MFHI_T3 = 6'd33, MFLO_T3 = 6'd34, IN_T3 = 6'd35, OUT_T3 = 6'd36, NOP_T3 = 6'd37, HALT_T3 = 6'd38,
I_T3 = 6'd39, I_T4 = 6'd40, I_T5 = 6'd41;
reg [5:0] Present_state = Default;
always @(posedge clk, posedge clr, posedge stop) begin
	if (clr == 1'b1) Present_state = Default;
	if (stop == 1'b1) Present_state = HALT_T3;
    case (Present_state)
      Default: Present_state = T0;
      T0: Present_state = T1;
      T1: Present_state = T2;
      T2: begin
        case(IR[31:27])
          _add, _sub, _and, _or, _shr, _shra, _shl, _ror, _rol: Present_state = A_T3;
          _neg, _not: Present_state = N_T3;
          _addi, _subi, _andi, _ori: Present_state = I_T3;
          _ld: Present_state = LD_T3;
          _ldi: Present_state = LDI_T3;
          _st: Present_state = ST_T3;
          _mul, _div: Present_state = MD_T3;
          _branch: Present_state = B_T3;
          _jr: Present_state = JR_T3;
          _jal: Present_state = JAL_T3;
          _in: Present_state = IN_T3;
          _out: Present_state = OUT_T3;
          _mfhi: Present_state = MFHI_T3;
          _mflo: Present_state = MFLO_T3;
          _nop: Present_state = NOP_T3;
          _halt: Present_state = HALT_T3;
          default: Present_state = Default;
        endcase
      end
      A_T3: Present_state = A_T4;
      A_T4: Present_state = A_T5;
      A_T5: Present_state = T0;
      N_T3: Present_state = N_T4;
      N_T4: Present_state = T0;
      MD_T3: Present_state = MD_T4;
      MD_T4: Present_state = MD_T5;
      MD_T5: Present_state = MD_T6;
      MD_T6: Present_state = T0;
      LD_T3: Present_state = LD_T4;
      LD_T4: Present_state = LD_T5;
      LD_T5: Present_state = LD_T6;
      LD_T6: Present_state = LD_T7;
      LD_T7: Present_state = T0;
      LDI_T3: Present_state = LDI_T4;
      LDI_T4: Present_state = LDI_T5;
      LDI_T5: Present_state = T0;
      ST_T3: Present_state = ST_T4;
      ST_T4: Present_state = ST_T5;
      ST_T5: Present_state = ST_T6;
      ST_T6: Present_state = ST_T7;
      ST_T7: Present_state = T0;
      B_T3: Present_state = B_T4;
      B_T4: Present_state = B_T5;
      B_T5: Present_state = B_T6;
      B_T6: Present_state = T0;
      JR_T3: Present_state = T0;
      IN_T3: Present_state = T0;
      OUT_T3: Present_state = T0;
      MFHI_T3: Present_state = T0;
      MFLO_T3: Present_state = T0;
      JAL_T3: Present_state = JAL_T4;
      JAL_T4: Present_state = T0;
      NOP_T3: Present_state = T0;
		I_T3: Present_state = I_T4;
		I_T4: Present_state = I_T5;
		I_T5: Present_state = T0;
		HALT_T3: Present_state = HALT_T3;
		default: Present_state = Default;
    endcase
end

always @(Present_state) begin
	case (Present_state)
/* --------- common instruction steps -------- */
		Default: begin
			PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; InPortout <= 0; HIout <= 0; LOout <= 0; BAout <= 0;
			PCin <= 0; Zin <= 0; MDRin <= 0; MARin <= 0; OutPortin <= 0; HIin <= 0; LOin <= 0; IRin <= 0; Yin <= 0;
			Gra <= 0; Grb <= 0; Grc <= 0; CONin <= 0; Rin <= 0; Rout <= 0;
			IncPC <= 0; Read <= 0; Write <= 0; Cout <= 0; Run <= 1; R_select <= 16'd0;
		end
		T0: begin
			PCout <= 1; MARin <= 1; IncPC <= 1; PCin <= 1;
			Zlowout <= 0; Rin <= 0; Gra <= 0; Zhighout <= 0; HIin <= 0; MDRout <= 0; Write <= 0; Rout <= 0; InPortout <= 0; OutPortin <= 0; HIout <= 0; LOout <= 0;
		end
    T1: begin
			PCout <= 0;  MARin <= 0; IncPC <= 0; PCin <= 0;
      Read <= 1; MDRin <= 1;
		end
		T2: begin
			Read <= 0; MDRin <= 0;
			MDRout <= 1; IRin <= 1;
		end
/* ----------------- */
/* --------- add, sub, and, or, shr, shra, shl, ror, rol -------- */
    A_T3: begin
			MDRout <= 0; IRin <= 0;
			Grb <= 1; Rout <= 1; Yin <= 1;
		end
		A_T4: begin
			Grb <= 0; Rout <= 0; Yin <= 0;
			Grc <= 1; Rout <= 1; Zin <= 1;
		end
		A_T5: begin
			Grc <= 0; Rout <= 0; Zin <= 0;
			Zlowout <= 1; Rin <= 1; Gra <= 1;
		end
/* ----------------- */
/* --------- addi, subi, andi, ori -------- */
    I_T3: begin
			MDRout <= 0; IRin <= 0;
			Grb <= 1; Rout <= 1; Yin <= 1;
		end
		I_T4: begin
			Grb <= 0; Rout <= 0; Yin <= 0;
			Cout <= 1; Zin <= 1;
		end
		I_T5: begin
			Cout <= 0; Zin <= 0;
			Zlowout <= 1; Gra <= 1; Rin <= 1;
		end
/* ----------------- */
/* -------- neg, not --------- */
		N_T3: begin
			MDRout <= 0; IRin <= 0;
			Zin <= 1; Rout <= 1; Grb <= 1;
		end
		N_T4: begin
			Zin <= 0; Rout <= 0; Grb <= 1;
			Zlowout <= 1; Rin <= 1; Gra <= 1;
		end
/* ----------------- */
/* --------- mul, div -------- */
    MD_T3: begin
      MDRout <= 0; IRin <= 0;
			Gra <= 1; Rout <= 1; Yin <= 1;
    end
    MD_T4: begin
			Gra <= 0; Rout <= 0; Yin <= 0;
      Grb <= 1; Rout <= 1; Zin <= 1;
    end
    MD_T5: begin
			Grb <= 0; Rout <= 0; Zin <= 0;
      Zlowout <= 1; LOin <= 1;
    end
		MD_T6: begin
			Zlowout <= 0; LOin <= 0;
			Zhighout <= 1; HIin <= 1;
		end
/* ----------------- */
/* -------- ld --------- */
		LD_T3: begin
			MDRout <= 0; IRin <= 0;
			Grb <= 1; BAout <= 1; Yin <= 1;
		end
		LD_T4: begin
			Grb <= 0; BAout <= 0; Yin <= 0;
			Cout <= 1; Zin <= 1;
		end
		LD_T5: begin
			Cout <= 0; Zin <= 0;
			Zlowout <= 1; MARin <= 1;
		end
		LD_T6: begin
			Zlowout <= 0; MARin <= 0;
			Read <= 1; MDRin <= 1;
		end
		LD_T7: begin
			Read <= 0; MDRin <= 0;
			MDRout <= 1; Gra <= 1; Rin <= 1;
		end
/* ----------------- */

/* -------- ldi --------- */
		LDI_T3: begin
			MDRout <= 0; IRin <= 0;
			Grb <= 1; BAout <= 1; Yin <= 1;
		end
		LDI_T4: begin
			Grb <= 0; BAout <= 0; Yin <= 0;
			Cout <= 1; Zin <= 1;
		end
		LDI_T5: begin
			Cout <= 0; Zin <= 0;
			Gra <= 1; Zlowout <= 1; Rin <= 1;
		end
/* ----------------- */
/* -------- st --------- */
		ST_T3: begin
			MDRout <= 0; IRin <= 0;
			Grb <= 1; BAout <= 1; Yin <= 1;
		end
		ST_T4: begin
			Grb <= 0; BAout <= 0; Yin <= 0;
			Cout <= 1; Zin <= 1;
		end
		ST_T5: begin
			Cout <= 0; Zin <= 0;
			Zlowout <= 1; MARin <= 1;
		end
		ST_T6: begin
			Zlowout <= 0; MARin <= 0;
			MDRin <= 1; Gra <= 1; Rout <= 1;
		end
		ST_T7: begin
			MDRin <= 0; Gra <= 0; Rout <= 0;
			MDRout <= 1; Write <= 1;
		end
/* ----------------- */
/* -------- branch (brzr, brnz, brpl, brmi) --------- */
		B_T3: begin
			MDRout <= 0; IRin <= 0;
			Gra <= 1; Rout <= 1; CONin <= 1;
		end
		B_T4: begin
			Gra <= 0; Rout <= 0; CONin <= 0;
			PCout <= 1; Yin <= 1;
		end
		B_T5: begin
			PCout <= 0; Yin <= 0;
			Zin <= 1; Cout <= 1;
		end
		B_T6: begin
			Zin <= 0; Cout <= 0;
			Zlowout <= 1; PCin <= 1;
		end
/* ----------------- */
/* -------- jr --------- */
		JR_T3: begin
			MDRout <= 0; IRin <= 0;
			Gra <= 1; Rout <= 1; PCin <= 1; 
		end
/* ----------------- */
/* -------- jal --------- */
		JAL_T3: begin
      // Select R15 manually, overriding select and encode logic
			MDRout <= 0; IRin <= 0;
			R_select <= 16'h8000; PCout <= 1;
		end
    JAL_T4: begin
			R_select <= 16'h0000; PCout <= 0;
			Gra <= 1; Rout <= 1; PCin <= 1;
		end
/* ----------------- */
/* -------- in --------- */
		IN_T3: begin
			MDRout <= 0; IRin <= 0;
			Gra <= 1; Rin <= 1; InPortout <= 1;
		end
/* ----------------- */
/* -------- out --------- */
		OUT_T3: begin
			MDRout <= 0; IRin <= 0;
			Gra <= 1; Rout <= 1; OutPortin <= 1;
		end
/* ----------------- */
/* -------- mfhi --------- */
		MFHI_T3: begin
			MDRout <= 0; IRin <= 0;
			Gra <= 1; Rin <= 1; HIout <= 1;
		end
/* ----------------- */
/* -------- mflo --------- */
		MFLO_T3: begin
			MDRout <= 0; IRin <= 0;
			Gra <= 1; Rin <= 1; LOout <= 1;
		end
/* ----------------- */
/* -------- nop --------- */
    NOP_T3: begin
    end
/* ----------------- */
/* -------- halt --------- */
    HALT_T3: begin
      Run <= 0;
    end
/* ----------------- */
	endcase
end
endmodule
