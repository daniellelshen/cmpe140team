module latch(
        input       clk,
        input       rst,
        input       r, s,
        output reg  q
    );
    
    always @ (posedge clk, posedge rst)
    begin
        if (rst)
            q <= 1'b0;
        else
            q <= (~r) & (s | q);
    end
endmodule
