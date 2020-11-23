module reg_file # (parameter WIDTH = 32) (
    input [WIDTH-1:0] D,
    input load, clk, rst,
    output reg [WIDTH-1:0] Q);        

    always@(posedge clk, posedge rst)
    begin
        if(rst) 
            Q <= 0;
        else if (load)
            Q <= D;
        else
            Q <= Q;
    end
endmodule
