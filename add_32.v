module add_32(input [31:0] A, B,
              input Cin,
              output [31:0] Z,
             output Cout);
  wire cout1;
  add_16 a1 (A[15:0],B[15:0],Cin,Z[15:0],cout1);
  add_16 a2 (A[31:16],B[31:16],cout1,Z[31:16],Cout);
endmodule
  
  
module  add_16(input [15:0] A, B,
                input c0,
                 output [15:0] Z,
                 output Cout
                );
    wire cout1, cout2, cout3;
    add_4 a1 (A[3:0], B[3:0], c0, Z[3:0], cout1);
    add_4 a2 (A[7:4], B[7:4], cout1, Z[7:4], cout2);
    add_4 a3 (A[11:8], B[11:8], cout2, Z[11:8], cout3);
    add_4 a4 (A[15:12], B[15:12], cout3, Z[15:12], Cout);
endmodule

  
module add_4(input [3:0] A, B,
               input Cin,
               output [3:0] Z,
               output Cout);
    wire [3:0] P,G,c;
    assign P = A^B; 
    assign G = A&B;
    
    assign c[0] = Cin;
    assign c[1] = G[0] | (P[0]&c[0]);
    assign c[2] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&c[0]);
    assign c[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&P[0]&c[0]) | (P[2] & P[1] & G[0]);
    assign Cout = G[3] | (P[3]&G[2]) | (P[3]&P[2]&P[1]&P[0]&c[0]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & G[0] & P[1]);
    assign Z[3:0] = P^c;
endmodule
