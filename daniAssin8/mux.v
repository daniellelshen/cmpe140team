module MUX(
        input [31:0] in1, in2,
        input        sel,
        output reg [31:0]  out
    );
    
    always @ (in1, in2, sel)
    begin
        out = sel ? in1 : in2;
    end
endmodule
