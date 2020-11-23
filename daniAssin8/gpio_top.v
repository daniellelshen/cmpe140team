module gpio_top(
        input           clk, rst,
        input  [3:2]    a,
        input           we,
        input  [31:0]   wd,
        input  [31:0]   gpI1,
        input  [31:0]   gpI2,
        output [31:0]   rd,
        output [31:0]   gpO1,
        output [31:0]   gpO2
    );
    
    wire [1:0] Rdsel;
    wire       we1, we2;
    
    gpio_ad Decoder (
        .A      (a),
        .WE     (we),
        .WE1    (we1),
        .WE2    (we2),
        .Rdsel  (Rdsel)
    );
    
    reg_file GPO1 (
        .clk    (clk),
        .rst    (rst),
        .load   (we1),
        .D      (wd),
        .Q      (gpO1)
    );
    
    reg_file GPO2 (
        .clk    (clk),
        .rst    (rst),
        .load   (we2),
        .D      (wd),
        .Q      (gpO2)
    );
    
    mux4 #(32) GPIO_MUX (
        .a (gpI1),
        .b (gpI2),
        .c (gpO1),
        .d (gpO2),
        .sel (Rdsel),
        .y (rd)
    );
    
    
    
endmodule
