`timescale 1ns/10ps
module control_tb;
reg Clock, Reset, Stop;
wire [31:0] OutPort_out;
reg [31:0] InPort_input;
datapath DUT(Clock, Reset, Stop, InPort_input, OutPort_out);
initial begin
  Clock = 0;
  Stop = 0;
  Reset = 0;
  forever #10 Clock = ~ Clock;
end
endmodule
