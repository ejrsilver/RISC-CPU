module RAM (
    input clk, Read, Write,
    input [31:0] Data_in,
    input [8:0] Addr_in,
    output [31:0] Data_out
);
reg [31:0] RAM1 [0:511];

assign Data_out = (clk == 1'b1 | Write == 1'b0 | Read == 1'b1) ? 9'bZZZZZZZZZ : RAM1[Addr_in];

always @(clk or Write) begin
    @(negedge Write) begin
        if(clk--1'b0) begin
            RAM1[Addr_in] <= Data_in;
        end
    end
end

endmodule