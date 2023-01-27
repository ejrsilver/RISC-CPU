module mux_32_1(
  input wire [31:0] R0_busin;
  input wire [31:0] R1_busin;
  input wire [31:0] R2_busin;
  input wire [31:0] R3_busin;
  input wire [31:0] R4_busin;
  input wire [31:0] R5_busin;
  input wire [31:0] R6_busin;
  input wire [31:0] R7_busin;
  input wire [31:0] R8_busin;
  input wire [31:0] R9_busin;
  input wire [31:0] R10_busin;
  input wire [31:0] R11_busin;
  input wire [31:0] R12_busin;
  input wire [31:0] R13_busin;
  input wire [31:0] R14_busin;
  input wire [31:0] R15_busin;
  
  input wire [31:0] HI_busin;
  input wire [31:0] LO_busin;
  
  input wire [31:0] Zhi_busin;
  input wire [31:0] Zlo_busin;
  
  input wire [31:0] PC_busin;
  input wire [31:0] MDR_busin;
  input wire [31:0] InPort_busin;
  input wire [31:0] C_sign_extend;

  input wire [4:0] select
  output reg [31:0] mux_out
);
  
  always @(*) begin
    case(select)
      5'd0 : mux_out <= R0_busin[31:0];
      5'd1 : mux_out <= R1_busin[31:0];
      5'd2 : mux_out <= R2_busin[31:0];
      5'd3 : mux_out <= R3_busin[31:0];      
      5'd4 : mux_out <= R4_busin[31:0];
      5'd5 : mux_out <= R5_busin[31:0];
      5'd6 : mux_out <= R6_busin[31:0];
      5'd7 : mux_out <= R7_busin[31:0];
      5'd8 : mux_out <= R8_busin[31:0];
      5'd9 : mux_out <= R9_busin[31:0];
      5'd10 : mux_out <= R10_busin[31:0];
      5'd11 : mux_out <= R11_busin[31:0];
      5'd12 : mux_out <= R12_busin[31:0];
      5'd13 : mux_out <= R13_busin[31:0];
      5'd14 : mux_out <= R14_busin[31:0];
      5'd15 : mux_out <= R15_busin[31:0];
      5'd16 : mux_out <= HI_busin[31:0];
      5'd17 : mux_out <= LO_busin[31:0];
      5'd18 : mux_out <= Zhi_busin[31:0];
      5'd19: mux_out <= Zlo_busin[31:0];
      5'd20 : mux_out <= PC_busin[31:0];
      5'd21 : mux_out <= MDR_busin[31:0];
      5'd22 : mux_out <= InPort_busin[31:0];
      5'd23 : mux_out <= C_sign_extend[31:0];
      default : mux_out <= 32'd0;
    endcase
  end
endmodule
