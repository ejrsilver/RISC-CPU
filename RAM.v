`timescale 1ns/10ps

module RAM (
    input clk, Read, Write,
    input [31:0] Data_in,
    input [8:0] Addr_in,
    output reg [31:0] Data_out
);
reg [31:0] RAM1 [0:511];

always @(posedge clk) begin
    if(Write == 1) begin
        RAM1[Addr_in] <= Data_in;
    end
	 Data_out <= RAM1[Addr_in];
end

endmodule