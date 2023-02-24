module incPC(
    input [31:0] PCin,
    input IncPC,
    output [31:0] PCout
);
wire pc_cout;
add_32 ADD(PCin, 32'd1, 1'b1, PCout, pc_cout);

endmodule