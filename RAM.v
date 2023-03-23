`timescale 1ns/10ps

module RAM (
    input clk, Read, Write,
    input [31:0] Data_in,
    input [8:0] Addr_in,
    output reg [31:0] Data_out
);
reg [31:0] RAM1 [0:511];

initial begin
    // Phase 2 (All Instructions in One Demo)
    RAM1[0] = 32'h00800075; // ld R1, $75
    RAM1[1] = 32'h00080045; // ld R0, $45(R1)
    RAM1[2] = 32'h08800075; // ldi R1, $75
    RAM1[3] = 32'h08080045; // ldi R0, $45(R1)

    RAM1[4] = 32'h0A000067; // ldi R4, $67
    RAM1[5] = 32'h12000090; // st $90, R4
    RAM1[6] = 32'h12200090; // st $90(R4), R4

    RAM1[7] = 32'h09800015; // ldi R3, 21
    RAM1[8] = 32'h611FFFFD; // addi R2, R3, -3
    RAM1[9] = 32'h69180025; // andi R2, R3, $25
    RAM1[10]= 32'h71180025; // ori R2, R3, $25

    RAM1[11]= 32'h0B000014; // ldi R6, 20
    RAM1[12]= 32'h9B000019; // brzr R6, 25
    RAM1[13]= 32'h9B080019; // brnz R6, 25
    RAM1[14]= 32'h9B100019; // brpl R6, 25
    RAM1[15]= 32'h9B180019; // brmi R6, 25

    RAM1[16]= 32'h79A00000; // mul R3, R4
    RAM1[17]= 32'hC2000000; // mfhi R4
    RAM1[18]= 32'hCB000000; // mflo R6

    RAM1[19]= 32'hB9000000; // out R2
    RAM1[20]= 32'hB1800000; // in R3

    RAM1[21]= 32'h0900001C; // ldi R2, 28
    RAM1[22]= 32'hA9000000; // jal R2

    RAM1[25]= 32'h09000012; // ldi R2, 14
    RAM1[26]= 32'h0B000000; // ldi R6, 0
    RAM1[27]= 32'hA1000000; // jr R2

    RAM1[28]= 32'hD8000000; // halt

    RAM1[106]=32'h00000029; // Sample Number
    RAM1[117]=32'h00000025; // Sample Number

    // // Phase 3
    // RAM1[0] = 32'h08800002; // ldi R1, 2
    // RAM1[1] = 32'h08080000; // ldi R0, 0(R1)
    // RAM1[2] = 32'h01000068; // ld R2, $68
    // RAM1[3] = 32'h0917FFFC; // ldi R2, -4(R2)
    // RAM1[4] = 32'h00900001; // ld R1, 1(R2)
    // RAM1[5] = 32'h09800069; // ldi R3, $69
    // RAM1[6] = 32'h99980004; // brmi R3, 4
    // RAM1[7] = 32'h09980002; // ldi R3, 2(R3)
    // RAM1[8] = 32'h039FFFFD; // ld R7, -3(R3)
    // RAM1[9] = 32'hD0000000; // nop
    // RAM1[10]= 32'h9B900002; // brpl R7, 2
    // RAM1[11]= 32'h09000005; // ldi R2, 5(R0)
    // RAM1[12]= 32'h09880002; // ldi R3, 2(R1)
    // RAM1[13]= 32'h19918000; // add R3, R2, R3 (Branch target)
    // RAM1[14]= 32'h63B80002; // addi R7, R7, 2
    // RAM1[15]= 32'h8BB80000; // neg R7, R7
    // RAM1[16]= 32'h93B80000; // not R7, R7
    // RAM1[17]= 32'h6BB8000F; // andi R7, R7, $0F
    // RAM1[18]= 32'h50880000; // ror R1, R1, R0
    // RAM1[19]= 32'h7388001C; // ori R7, R1, $1C
    // RAM1[20]= 32'h43B80000; // shra R7, R7, R0
    // RAM1[21]= 32'h39180000; // shr R2, R3, R0
    // RAM1[22]= 32'h11000052; // st $52, R2
    // RAM1[23]= 32'h59100000; // rol R2, R2, R0
    // RAM1[24]= 32'h31180000; // or R2, R3, R0
    // RAM1[25]= 32'h28908000; // and R1, R2, R1
    // RAM1[26]= 32'h11880060; // st $60(R1), R3
    // RAM1[27]= 32'h21918000; // sub R3, R2, R3
    // RAM1[28]= 32'h48900000; // shl R1, R2, R0
    // RAM1[29]= 32'h0A000006; // ldi R4, 6
    // RAM1[30]= 32'h0A800032; // ldi R5, $32
    // RAM1[31]= 32'h7AA00000; // mul R5, R4
    // RAM1[32]= 32'hC3800000; // mfhi R7
    // RAM1[33]= 32'hCB000000; // mflo R6
    // RAM1[34]= 32'h82A00000; // div R5, R4
    // RAM1[35]= 32'h0C27FFFF; // ldi R8, -1(R4)
    // RAM1[36]= 32'h0CAFFFED; // ldi R9, -19(R5)
    // RAM1[37]= 32'h0D300000; // ldi R10, 0(R6)
    // RAM1[38]= 32'h0DB80000; // ldi R11, 0(R7)
    // RAM1[39]= 32'hAD000000; // jal R10
    // RAM1[40]= 32'hD8000000; // halt
    
	// RAM1[82]= 32'h00000026; // $26 (location $52)
	// RAM1[104]=32'h00000055; // $55 (location $68)

    // RAM1[300]=32'h1EC50000; // add R13, R8, R10 (location $12C)
    // RAM1[301]=32'h264D8000; // sub R12, R9, R11
    // RAM1[302]=32'h26EE0000; // sub R13, R13, R12
    // RAM1[303]=32'hA7800000; // jr R15
end

always @(posedge clk) begin
    if(Write == 1) begin
        RAM1[Addr_in] <= Data_in;
    end
	 Data_out <= RAM1[Addr_in];
end

endmodule