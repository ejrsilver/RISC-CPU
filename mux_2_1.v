module mux_2_1(
  input [31:0] in1, in2,
  input read, 
  output [31:0] mux_2_1_out
);
  if (read) begin
    mux_2_1_out[31:0] <= in1[31:0];
  end
  else begin
    mux_2_1_out[31:0] <= in2[31:0];
  end
endmodule
