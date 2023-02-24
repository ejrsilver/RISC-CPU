module incPC(
    input [31:0] PCin,
    input IncPC,
    output [31:0] PCout
);

add_32 ADD(PCin, 1, PCout);

endmodule