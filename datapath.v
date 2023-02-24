`timescale 1ns/10ps
module datapath(
	input PCout,
	input ZHighout, ZLowout,
	input MDRout,
	input R2out, R3out,
	input MARin, PCin, MDRin, IRin, Yin,
	input IncPC,
	input Read,
    input wire [4:0] opcode,
	input R1in, R2in, R3in, 
    input clk,
	input [31:0] MDatain,
);

	wire [31:0] RAM_out, ZHighin, ZLowin, C_out, PC_busin, Y_busin, ZHI_busin, 
				ZLO_busin, HI_busin, LO_busin, R0_busin, R1_busin, R2_busin, 
				R3_busin, R4_busin, R5_busin, R6_busin, R7_busin, R8_busin, R9_busin, 
				R10_busin, R11_busin, R12_busin, R13_busin, R14_busin, R15_busin;

	wire [31:0] busout;
	wire clr;

	reg [15:0] enableReg;
	reg [15:0] Rout;

	initial begin
		Rout = 16'd0;
		enableReg = 16'd0;
	end

	always @(*) begin
		enableReg[1] <= R1in;
		enableReg[2] <= R2in;
		enableReg[3] <= R3in;

		Rout[2] <= R2out;
		Rout[3] <= R3out;
	end

	// General purpose registers r0-r15
	reg_32 r0 (clk, clr, enableReg[0], busout, R0_busin); 
	reg_32 r1 (clk, clr, enableReg[1], busout, R1_busin); 
	reg_32 r2 (clk, clr, enableReg[2], busout, R2_busin);
	reg_32 r3 (clk, clr, enableReg[3], busout, R3_busin);
	reg_32 r4 (clk, clr, enableReg[4], busout, R4_busin);
	reg_32 r5 (clk, clr, enableReg[5], busout, R5_busin);
	reg_32 r6 (clk, clr, enableReg[6], busout, R6_busin);
	reg_32 r7 (clk, clr, enableReg[7], busout, R7_busin);
	reg_32 r8 (clk, clr, enableReg[8], busout, R8_busin);
	reg_32 r9 (clk, clr, enableReg[9], busout, R9_busin);
	reg_32 r10 (clk, clr, enableReg[10], busout, R10_busin);
	reg_32 r11 (clk, clr, enableReg[11], busout, R11_busin);
	reg_32 r12 (clk, clr, enableReg[12], busout, R12_busin);
	reg_32 r13 (clk, clr, enableReg[13], busout, R13_busin);
	reg_32 r14 (clk, clr, enableReg[14], busout, R14_busin);
	reg_32 r15 (clk, clr, enableReg[15], busout, R15_busin);

	// Other
	reg_32 PC (clk, clr, PCin, PCout, PC_busin);
	reg_32 Y (clk, clr, Yin, busout, Y_busin);
	reg_32 Z_HI (clk, clr, ZHighin, C_out, ZHI_busin);
	reg_32 Z_LO (clk, clr, ZLowin, C_out, ZLO_busin);
	reg_32 HI (clk, clr, HIin, busout, HI_busin);
	reg_32 LO (clk, clr, LOin, busout, LO_busin);

	// IR will be used for select and encode logic in phase 2
	reg_32 IR (clk, clr, IRin, busout, IR_busin);

	MDR_reg_32 MDR (clk, clr, MDRin, Mdatain, busout, Read, MDR_busin);

	// Space for IO, MAR, RAM, Con FF, and other stuff



	wire [4:0] encoder_out;

	mux_32_1 bus_mux (R0_busin, R1_busin, R2_busin, 
					R3_busin, R4_busin, R5_busin, 
					R6_busin. R7_busin, R8_busin, 
					R9_busin, R10_busin, R11_busin, 
					R12_busin, R13_busin, R14_busin, 
					R15_busin, HI_busin, LO_busin, 
					ZHI_busin, ZLO_busin, PC_busin, 
					MDR_busin, InPort_busin, C_sign_extend, 
					encoder_out, busout);

	alu alu_(clk, IncPC, busout, busout, opcode, ZHighout, Zlowout, PCout);

endmodule