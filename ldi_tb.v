`timescale 1ns/10ps
module ldi_tb;
    reg Clock, flag, Reset;
    reg PCout, Zhighout, Zlowout, MDRout, HIout, LOout, BAout, InPortout, Cout; 
    reg MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, InPortin, OutPortin;
    reg Gra, Grb, Grc, CONin;
    reg IncPC, Read, Write, Rin, Rout;
    reg [4:0] opcode;

    wire [31:0] OutPort_out;
    reg [31:0] InPort_input;

    parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
    reg [3:0] Present_state = Default;

    datapath DUT(Clock, Reset, Read, Write, IncPC, PCin, Zin, MDRin, MARin, Yin, HIin, LOin, IRin, OutPortin, PCout, Zhighout, Zlowout, HIout, LOout, MDRout, InPortout, Cout, BAout, CONin, Gra, Grb, Grc, Rin, Rout, InPort_input);

    initial begin
        Clock = 0;
        Reset = 0;
        flag = 0;
        forever #10 Clock = ~ Clock;
    end

    always @(posedge Clock) begin
        if (flag == 1) begin
        case (Present_state)
            Default: Present_state = T0;
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
                PCin <= 0; Zin <= 0; MDRin <= 0; MARin <= 0; InPortin <= 0; OutPortin <= 0; HIin <= 0; LOin <= 0; IRin <= 0; Yin <= 0;
                Gra <= 0; Grb <= 0; Grc <= 0; CONin <= 0; Rin <= 0; Rout <= 0;
                IncPC <= 0; Read <= 0; Write <= 0; Cout <= 0;
                InPort_input <= 32'd0;
            end
            T0: begin
					 PCout <= 1; MARin <= 1; IncPC <= 1;
                #10 PCout <= 0;  MARin <= 0; PCin <= 1;
					 #10 PCin <= 0; IncPC <= 0;
            end
            T1: begin
                #10 Read <= 1; MDRin <= 1;
                #15 Read <= 0; MDRin <= 0;
            end
            T2: begin
                #10 MDRout <= 1; IRin <= 1;
                #15 MDRout <= 0; IRin <= 0;
            end
            T3: begin
                #10 Grb <= 1; BAout <= 1; Yin <= 1;
                #15 Grb <= 0; BAout <= 0; Yin <= 0;
            end
            T4: begin
                #10 Cout <= 1; Zin <= 1;
                #15 Cout <= 0; Zin <= 0;
            end
            T5: begin
                #10 Zlowout <= 1; Gra <= 1; Rin <= 1;
                #15 Zlowout <= 0; MARin <= 0; Rin <= 0;
            end
        endcase
    end
endmodule
