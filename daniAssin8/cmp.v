module CMP(
        input [3:0] a, b,
        output reg  gt
    );
    always @ (a, b)
    begin
       gt = (a > b) ? 1 : 0; 
    end
endmodule