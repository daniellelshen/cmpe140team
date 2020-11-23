module CNT(
        input clk,
        input en,
        input load_cnt,
        
        input      [3:0] d,
        output reg [3:0] q
    );
    
    always @ (posedge clk)
    begin
        if (load_cnt)
            q = d;
        else if (en)
            q = q - 1;
        else
            q = q;
    end
endmodule