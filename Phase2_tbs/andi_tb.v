`timescale 1ns/10ps
module andi_tb;
    reg PCout, Zhighout, Zlowout, MDRout, HIout, LOout, BAout, InPortout, Cout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, OutPortin;
    reg Gra, Grb, Grc, CONin;
    reg IncPC, Read, Write, Rin, Rout;
    reg [4:0] opcode;
    reg Clock;
	reg Reset;
    reg flag;
	reg [15:0] R0_15_enable, R0_15_out;
    wire [31:0] OutPort_out;
    reg [31:0] InPort_input;
	 
    parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;

    reg [3:0] Present_state = Default;

    initial begin
        Clock = 0;
		  Reset = 0;
		  flag = 0;
    end
	 
	 always
		Clock = ~ Clock;
	 
	 datapath DUT(Clock, Reset, Read, Write, IncPC, R0_15_enable, R0_15_out, PCin, Zin, MDRin, MARin, Yin, HIin, LOin, IRin, OutPortin, PCout, Zhighout, Zlowout, HIout, LOout, MDRout, InPortout, Cout, BAout, CONin, Gra, Grb, Grc, Rin, Rout, InPort_input);

    always @(posedge Clock) begin
        if (flag == 1) begin
        case (Present_state)
            Default: Present_state = T0
            T0: Present_state = T1;
            T1: Present_state = T2;
            T2: Present_state = T3;
            T3: Present_state = T4;
            T4: Present_state = T5;
        endcase
        flag = 0;
    end else begin
	flag = 1;
    end
    end

    always @(Present_state) begin
        case (Present_state)
            Default: begin
                PCout <= 0; Zlowout <= 0; Zhighout <= 0; MDRout <= 0; InPortout <= 0; HIout <= 0; LOout <= 0; BAout <= 0;
                PCin <= 0; Zin <= 0; MDRin <= 0; MARin <= 0; OutPortin <= 0; HIin <= 0; LOin <= 0; IRin <= 0; Yin <= 0;
                Gra <= 0; Grb <= 0; Grc <= 0; CONin <= 0; Rin <= 0; Rout <= 0;
                IncPC <= 0; Read <= 0; Write <= 0;
                InPort_input <= 32'd0; Mdatain <= 32'd0;
                R0_15_enable <= 16'd0; R0_15_out <= 16'd0;
            end
            T0: begin
				PCout <= 1; MARin <= 1; IncPC <= 1;
                #10 PCout <= 0;  MARin <= 0; PCin <= 1;
				#10 PCin <= 0; IncPC <= 0;
            end
            T1: begin
                Mdatain <= 32'69180025; // opcode for “andi r2, r3, $25”
                #10 Read <= 1; MDRin <= 1; Zlowout <= 1;
                #15 Read <= 0; MDRin <= 0; Zlowout <= 0;
            end
            T2: begin
                #10 MDRout <= 1; IRin <= 1;
                #15 MDRout <= 0; IRin <= 0;
            end
            T3: begin
                #10 Grb <= 1; Rout <= 1; Yin <= 1;
                #15 Grb <= 0; Rout <= 0; Yin <= 0;
            end
            T4: begin
                #10 Cout <= 1; Zin <= 1;
                #15 Cout <= 0; Zin <= 0;
            end
            T5: begin
                #10 Zlowout <= 1; Gra <= 1; Rin <= 1;
                #15 Zlowout <= 0; Gra <= 0; Rin <= 0; Rout <= 1;
            end
        endcase
    end
endmodule

