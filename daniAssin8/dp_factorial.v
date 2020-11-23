module dp_factorial(
        input [3:0]   n,
        input         clk, load_cnt, en, load_reg, sel1, sel2, reset,
        output [31:0] product,
        output        err, gt
    );
    
    wire [31:0] mul_out, mux_out, reg_out;
    wire[3:0] count_out;
    
    CNT U0(
            .clk        (clk),
            .en         (en),
            .load_cnt   (load_cnt),
            .d          (n),
            .q          (count_out)
           );
           
    CMP U1(
            .a(n), 
            .b(4'b1100), 
            .gt(err)
           );
           
    CMP U2(
            .a(count_out), 
            .b(4'b0001), 
            .gt(gt)
           );
            
    MUX U3(
            .in1(1), 
            .in2(mul_out), 
            .sel(sel1), 
            .out(mux_out)
           );
           
    MUX U4(
            .in1(0), 
            .in2(reg_out), 
            .sel(sel2), 
            .out(product)
           );
           
    reg_file U5(
            .clk(clk), 
            .rst(reset),           
            .load(load_reg), 
            .D(mux_out), 
            .Q(reg_out)
           ); 
            
    MUL U6(
            .x(count_out), 
            .y(reg_out), 
            .z(mul_out)
           );  
           
endmodule