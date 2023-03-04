module csa_3_2_reducer(input signed [63:0] A, B, D, output signed [63:0] C, S);
    assign C = A&B | A&D | B&D;
    assign S = A^B^D;
endmodule

module add_64_16_term(input signed [63:0] in_terms [15:0], output reg signed [63:0] sum);
    wire [63:0] c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14;
    wire cout;
    csa_3_2_reducer CSA1(in_terms[0], in_terms[1], in_terms[2], c1, s1);    
    csa_3_2_reducer CSA2(in_terms[3], in_terms[4], in_terms[5], c2, s2);    
    csa_3_2_reducer CSA3(in_terms[6], in_terms[7], in_terms[8], c3, s3);    
    csa_3_2_reducer CSA4(in_terms[9], in_terms[10], in_terms[11], c4, s4);
    csa_3_2_reducer CSA5(in_terms[12], in_terms[13], in_terms[14], c5, s5);
    csa_3_2_reducer CSA6(s1, c1, s2, c6, s6);
    csa_3_2_reducer CSA7(c2, s3, c3, c7, s7);
    csa_3_2_reducer CSA8(s4, c4, s5, c8, s8);
    csa_3_2_reducer CSA9(s6, c6, s7, c9, s9);
    csa_3_2_reducer CSA10(c7, s8, c8, c10, s10);
    csa_3_2_reducer CSA11(s9, c9, s10, c11, s11);
    csa_3_2_reducer CSA12(c10, c5, in_terms[15], c12, s12);
    csa_3_2_reducer CSA13(s11, c11, s12, c13, s13);
    csa_3_2_reducer CSA14(c12, s13, c13, c14, s14);
    add_64 ADD_CSAs(c14, s14, 1'b0, sum, cout);
endmodule    