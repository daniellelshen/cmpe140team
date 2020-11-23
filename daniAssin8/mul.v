module MUL(
        input       [31:0] y,         //factorial subtotal
        input       [3:0]  x,         //multiplier
        output reg  [31:0] z 
    );
    
    always @ (x, y, z)
    begin
        z = x * y;
    end
   
endmodule