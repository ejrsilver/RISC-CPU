module div_32(input [31:0] divisor, dividend, output reg [31:0] q, r);
  
  reg check, C;
  reg [31:0] opp, temp;
  always @(*)
    begin
      check = 0;
      q = 0;
      opp = dividend;
      
      while(temp == 0)
        begin
   
          if(opp<divisor)
            begin
              r = opp;
              temp = 1;
            end
          
          if(opp>divisor || opp == divisor)
            begin
              sub_32 S1(opp,divisor,0,temp,C);
              opp = temp;
              add_32 A1(q,1,0,temp,C);
              q = temp;
            end
        end
      endmodule
