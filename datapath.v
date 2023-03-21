`timescale 1ns/10ps
module datapath(
	input clk, clr,
	input Read, Write,
	input IncPC,
	input [15:0] R0_15_in_enable_in, R0_15_out_enable_in,
	input PC_enable, Z_enable, MDR_enable, MAR_enable, Y_enable, HI_enable, LO_enable, IR_enable, OutPort_enable,
	input PCout, ZHighout, ZLowout, HIout, LOout, MDRout, InPortout, Cout, BAout,
	input CONin, Gra, Grb, Grc, Rin, Rout;
	input [31:0] InPort_input,
	input [31:0] Mdatain
);
	wire [31:0] R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out,
				PC_out, ZHI_out, ZLO_out, HI_out, LO_out, MDR_out, Y_out, InPort_out, IR_out, C_data, C_sign_extend, RAM_out, C_out_HI, C_out_LO, MAR_out, InPort_out, OutPort_out;

	wire [31:0] busout;
	wire [4:0] encoder_out;
	wire [4:0] opcode;
	wire branch_flag;

	wire [15:0] R0_15_in_enable_IR, R0_15_out_enable_IR,
	reg [15:0] R0_15_in_enable, R0_15_out_enable;

	initial begin
		R0_15_out_enable = 16'd0;
		R0_15_in_enable = 16'd0;
	end

	always @(*) begin
		if (R0_15_in_enable_IR) R0_15_in_enable <= R0_15_in_enable_IR;
		else R0_15_in_enable <= R0_15_in_enable_in;
		if (R0_15_out_enable_IR) R0_15_out_enable <= R0_15_out_enable_IR;
		else R0_15_out_enable <= R0_15_out_enable_in;
	end

	// General purpose registers r0-r15
	wire [31:0] R0_regout;
	assign R0_out = R0_regout & {32{BAout}};
	reg_32 r0 (clk, clr, R0_15_in_enable[0], busout, R0_regout);	
	reg_32 r1 (clk, clr, R0_15_in_enable[1], busout, R1_out); 
	reg_32 r2 (clk, clr, R0_15_in_enable[2], busout, R2_out);
	reg_32 r3 (clk, clr, R0_15_in_enable[3], busout, R3_out);
	reg_32 r4 (clk, clr, R0_15_in_enable[4], busout, R4_out);
	reg_32 r5 (clk, clr, R0_15_in_enable[5], busout, R5_out);
	reg_32 r6 (clk, clr, R0_15_in_enable[6], busout, R6_out);
	reg_32 r7 (clk, clr, R0_15_in_enable[7], busout, R7_out);
	reg_32 r8 (clk, clr, R0_15_in_enable[8], busout, R8_out);
	reg_32 r9 (clk, clr, R0_15_in_enable[9], busout, R9_out);
	reg_32 r10 (clk, clr, R0_15_in_enable[10], busout, R10_out);
	reg_32 r11 (clk, clr, R0_15_in_enable[11], busout, R11_out);
	reg_32 r12 (clk, clr, R0_15_in_enable[12], busout, R12_out);
	reg_32 r13 (clk, clr, R0_15_in_enable[13], busout, R13_out);
	reg_32 r14 (clk, clr, R0_15_in_enable[14], busout, R14_out);
	reg_32 r15 (clk, clr, R0_15_in_enable[15], busout, R15_out);

	// Other
	reg_32 HI (clk, clr, HI_enable, busout, HI_out);
	reg_32 LO (clk, clr, LO_enable, busout, LO_out);
	reg_32 Z_HI (clk, clr, Z_enable, C_out_HI, ZHI_out);
	reg_32 Z_LO (clk, clr, Z_enable, C_out_LO, ZLO_out);
	reg_32 Y (clk, clr, Y_enable, busout, Y_out);

	reg_32 inport(clk, clr, 1'b1, busout, InPort_input, InPort_out);
	reg_32 outport(clk, clr, OutPort_enable, busout, OutPort_out);
	
	// PC
	wire [31:0] PC_select;
	mux_2_1 PC_MUX (busout, C_out_LO, IncPC, PC_select);
	reg_32 PC (clk, clr, PC_enable, PC_select, PC_out);

	// Select and Encode Logic
	reg_32 IR(clk, clr, IR_enable, busout, IR_out);
	select_encode_logic SELogic(IR_out, Gra, Grb, Grc, Rin, Rout, BAout, opcode, C_sign_extend, R0_15_in_enable_IR, R0_15_out_enable_IR);

	// CON FF
	conff CFF(IR_out[20:19], busout, CONin, branch_flag);

	// Memory Subsystem
	MDR_reg_32 MDR (clk, clr, MDR_enable, Read, busout, Mdatain, MDR_out);
	reg_32 MAR (clk, clr, MAR_enable, busout, MAR_out);
	RAM ram_mod(clk, Read, Write, MDR_out, MAR_out[8:0], RAM_out);
	
	// BUS
	encoder_32_5 bus_enc ({8'd0, Cout, InPortout, MDRout, PCout, ZLowout, ZHighout, LOout, HIout, R0_15_out_enable}, encoder_out);
	mux_32_1 bus_mux (R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, ZHI_out, ZLO_out, PC_out, MDR_out, InPort_out, C_sign_extend, encoder_out, busout);

	// ALU
	alu alu_(clk, IncPC, branch_flag, busout, Y_out, opcode, C_out_HI, C_out_LO);
endmodule
