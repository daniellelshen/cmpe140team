module factorial(
        input         clk,
        input         rst,
        input         go,
        input  [3:0]  n,
        output        error, done,
        output [1:0]  CS,
        output [31:0] product
    );
    
    wire load_cnt, en, load_reg, sel1, sel2, gt;
    
    cu_factorial CU (clk, go, error, gt, load_cnt, en, load_reg, sel1, sel2, done, rst, CS);
    dp_factorial DP (n, clk, load_cnt, en, load_reg, sel1, sel2, rst, product, error, gt);
    
endmodule
