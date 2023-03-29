module mux_32_1(input [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, Zhi, Zlo, PC, MDR, InPort, C_sign_extend, input [4:0] select, output reg [31:0] mux_out);  
always @(*) begin
  case(select)
    5'd0 : mux_out <= R0[31:0];
    5'd1 : mux_out <= R1[31:0];
    5'd2 : mux_out <= R2[31:0];
    5'd3 : mux_out <= R3[31:0];
    5'd4 : mux_out <= R4[31:0];
    5'd5 : mux_out <= R5[31:0];
    5'd6 : mux_out <= R6[31:0];
    5'd7 : mux_out <= R7[31:0];
    5'd8 : mux_out <= R8[31:0];
    5'd9 : mux_out <= R9[31:0];
    5'd10 : mux_out <= R10[31:0];
    5'd11 : mux_out <= R11[31:0];
    5'd12 : mux_out <= R12[31:0];
    5'd13 : mux_out <= R13[31:0];
    5'd14 : mux_out <= R14[31:0];
    5'd15 : mux_out <= R15[31:0];
    5'd16 : mux_out <= HI[31:0];
    5'd17 : mux_out <= LO[31:0];
    5'd18 : mux_out <= Zhi[31:0];
    5'd19: mux_out <= Zlo[31:0];
    5'd20 : mux_out <= PC[31:0];
    5'd21 : mux_out <= MDR[31:0];
    5'd22 : mux_out <= InPort[31:0];
    5'd23 : mux_out <= C_sign_extend[31:0];
    default : mux_out <= 32'd0;
  endcase
end
endmodule
