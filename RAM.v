`timescale 1ns/10ps

module RAM (
    input clk, Read, Write,
    input [31:0] Data_in,
    input [8:0] Addr_in,
    output reg [31:0] Data_out
);
reg [31:0] RAM1 [0:511];

initial begin
    RAM1[0] = 32'h08800002;
    RAM1[1] = 32'h08080000;
    RAM1[2] = 32'h01000068;
    RAM1[3] = 32'h0917FFFC;
    RAM1[4] = 32'h00900001;
    RAM1[5] = 32'h09800069;
    RAM1[6] = 32'h99980004;
    RAM1[7] = 32'h09980002;
    RAM1[8] = 32'h039FFFFD;
    RAM1[9] = 32'hD0000000;
    RAM1[10]= 32'h9B900002;
    RAM1[11]= 32'h09000005;
    RAM1[12]= 32'h09880002;
    RAM1[13]= 32'h19918000;
    RAM1[14]= 32'h63B80002;
    RAM1[15]= 32'h8BB80000;
    RAM1[16]= 32'h93B80000;
    RAM1[17]= 32'h6BB8000F;
    RAM1[18]= 32'h50880000;
    RAM1[19]= 32'h7388001C;
    RAM1[20]= 32'h43B80000;
    RAM1[21]= 32'h39180000;
    RAM1[22]= 32'h11000052;
    RAM1[23]= 32'h59100000;
    RAM1[24]= 32'h31180000;
    RAM1[25]= 32'h28908000;
    RAM1[26]= 32'h11880060;
    RAM1[27]= 32'h21918000;
    RAM1[28]= 32'h48900000;
    RAM1[29]= 32'h0A000006;
    RAM1[30]= 32'h0A800032;
    RAM1[31]= 32'h7AA00000;
    RAM1[32]= 32'hC3800000;
    RAM1[33]= 32'hCB000000;
    RAM1[34]= 32'h82A00000;
    RAM1[35]= 32'h0C27FFFF;
    RAM1[36]= 32'h0CAFFFED;
    RAM1[37]= 32'h0D300000;
    RAM1[38]= 32'h0DB80000;
    RAM1[39]= 32'hAD000000;
    RAM1[40]= 32'hD8000000;
    
	RAM1[82]= 32'h00000026;
	RAM1[104]=32'h00000055;

    RAM1[300]=32'h1EC50000;
    RAM1[301]=32'h264D8000;
    RAM1[302]=32'h26EE0000;
    RAM1[303]=32'hA7800000;
end

always @(posedge clk) begin
    if(Write == 1) begin
        RAM1[Addr_in] <= Data_in;
    end
	 Data_out <= RAM1[Addr_in];
end

endmodule