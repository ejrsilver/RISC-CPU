`timescale 1ns/10ps
module datapath(
	input clk, clr,

	input [31:0] Mdatain,
	
	input Read,

	input IncPC,

	input [15:0] R0_15_enable_in,
	input [15:0] R0_15_out_in,

	input PC_enable, Z_enable, MDR_enable, MAR_enable, Y_enable, HI_enable, LO_enable, IR_enable,

	input PCout, ZHighout, ZLowout, HIout, LOout, MDRout, InPortout,

	input [4:0] opcode
);

	wire [31:0] R0_busin,	R1_busin,	R2_busin,		R3_busin,	R4_busin,	R5_busin,	R6_busin,	R7_busin,
				R8_busin,	R9_busin,	R10_busin,		R11_busin,	R12_busin,	R13_busin,	R14_busin,	R15_busin,
				PC_busin,	ZHI_busin,	ZLO_busin,		HI_busin,	LO_busin,	MDR_busin,	Y_busin,	InPort_busin,
				IR_busin,	C_data,		C_sign_extend,	RAM_out,	C_out_HI,	C_out_LO,	MAR_data;
	
	wire [31:0] busout;
	wire cout;
	assign cout = 0;

	reg [15:0] R0_15_enable;
	reg [15:0] R0_15_out;

	initial begin
		R0_15_out = 16'd0;
		R0_15_enable = 16'd0;
	end

	always @(*) begin
		R0_15_enable <= R0_15_enable_in;
		R0_15_out	 <= R0_15_out_in;
	end

	// General purpose registers r0-r15
	reg_32 r0 (clk, clr, R0_15_enable[0], busout, R0_busin);
	reg_32 r1 (clk, clr, R0_15_enable[1], busout, R1_busin); 
	reg_32 r2 (clk, clr, R0_15_enable[2], busout, R2_busin);
	reg_32 r3 (clk, clr, R0_15_enable[3], busout, R3_busin);
	reg_32 r4 (clk, clr, R0_15_enable[4], busout, R4_busin);
	reg_32 r5 (clk, clr, R0_15_enable[5], busout, R5_busin);
	reg_32 r6 (clk, clr, R0_15_enable[6], busout, R6_busin);
	reg_32 r7 (clk, clr, R0_15_enable[7], busout, R7_busin);
	reg_32 r8 (clk, clr, R0_15_enable[8], busout, R8_busin);
	reg_32 r9 (clk, clr, R0_15_enable[9], busout, R9_busin);
	reg_32 r10 (clk, clr, R0_15_enable[10], busout, R10_busin);
	reg_32 r11 (clk, clr, R0_15_enable[11], busout, R11_busin);
	reg_32 r12 (clk, clr, R0_15_enable[12], busout, R12_busin);
	reg_32 r13 (clk, clr, R0_15_enable[13], busout, R13_busin);
	reg_32 r14 (clk, clr, R0_15_enable[14], busout, R14_busin);
	reg_32 r15 (clk, clr, R0_15_enable[15], busout, R15_busin);

	// Other
	reg_32 HI (clk, clr, HI_enable, busout, HI_busin);
	reg_32 LO (clk, clr, LO_enable, busout, LO_busin);
	reg_32 Z_HI (clk, clr, Z_enable, C_out_HI, ZHI_busin);
	reg_32 Z_LO (clk, clr, Z_enable, C_out_LO, ZLO_busin);
	reg_32 Y (clk, clr, Y_enable, busout, Y_busin);
	
	wire [31:0] PC_select;
	mux_2_1 PC_MUX (busout, C_out_LO, IncPC, PC_select);
	reg_32 PC (clk, clr, PC_enable, PC_select, PC_busin);
	

	// IR will be used for select and encode logic in phase 2
	reg_32 IR (clk, clr, IR_enable, busout, IR_busin);

	MDR_reg_32 MDR (clk, clr, MDR_enable, Read, busout, Mdatain, MDR_busin);
	reg_32 MAR (clk, clr, MAR_enable, busout, MAR_data);

	// Space for IO, RAM, Con FF, and other stuff
	
	wire [4:0] encoder_out;
	wire [31:0] encoder_in;
	assign encoder_in = {8'd0, cout, InPortout, MDRout, PCout, ZLowout, ZHighout, LOout, HIout, R0_15_out};

	encoder_32_5 bus_enc (encoder_in, encoder_out);

	mux_32_1 bus_mux (R0_busin, R1_busin, R2_busin, 
					R3_busin, R4_busin, R5_busin, 
					R6_busin, R7_busin, R8_busin, 
					R9_busin, R10_busin, R11_busin, 
					R12_busin, R13_busin, R14_busin, 
					R15_busin, HI_busin, LO_busin, 
					ZHI_busin, ZLO_busin, PC_busin, 
					MDR_busin, InPort_busin, C_sign_extend, 
					encoder_out, busout);

	alu alu_(clk, IncPC, busout, Y_busin, opcode, C_out_HI, C_out_LO);

endmodule
