module csa_3_2_reducer(input signed [63:0] A, B, D, output signed [63:0] C, S);
    assign C = A&B | A&D | B&D;
    assign S = A^B^D;
endmodule

module add_64_16_term(input signed [63:0] in_term0, in_term1, in_term2, in_term3, in_term4, in_term5, in_term6, in_term7, in_term8, in_term9, in_term10, in_term11, in_term12, in_term13, in_term14, in_term15, output wire signed [63:0] sum);
    wire [63:0] c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14;
    wire cout;
    csa_3_2_reducer CSA1(in_term0, in_term1, in_term2, c1, s1);    
    csa_3_2_reducer CSA2(in_term3, in_term4, in_term5, c2, s2);    
    csa_3_2_reducer CSA3(in_term6, in_term7, in_term8, c3, s3);    
    csa_3_2_reducer CSA4(in_term9, in_term10, in_term11, c4, s4);
    csa_3_2_reducer CSA5(in_term12, in_term13, in_term14, c5, s5);
    csa_3_2_reducer CSA6(s1, c1, s2, c6, s6);
    csa_3_2_reducer CSA7(c2, s3, c3, c7, s7);
    csa_3_2_reducer CSA8(s4, c4, s5, c8, s8);
    csa_3_2_reducer CSA9(s6, c6, s7, c9, s9);
    csa_3_2_reducer CSA10(c7, s8, c8, c10, s10);
    csa_3_2_reducer CSA11(s9, c9, s10, c11, s11);
    csa_3_2_reducer CSA12(c10, c5, in_term15, c12, s12);
    csa_3_2_reducer CSA13(s11, c11, s12, c13, s13);
    csa_3_2_reducer CSA14(c12, s13, c13, c14, s14);
    add_64 ADD_CSAs(c14, s14, 1'b0, sum, cout);
endmodule    