module tb_gpio;

    reg  [1:0]  a;
    reg  [31:0] wd, gpI1, gpI2;
    reg         we, rst, clk;
    wire [31:0] rd, gpO1, gpO2;
    
    integer count = 0;
    
    task tick;
    begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
        count = count + 1;
    end
    endtask
    
    gpio_top gpio (
        .clk        (clk),
        .rst        (rst),
        .a          (a),
        .we         (we),
        .wd         (wd),
        .gpI1       (gpI1),
        .gpI2       (gpI2),
        .rd         (rd),
        .gpO1       (gpO1),
        .gpO2       (gpO2)
    );
    
    initial begin
        rst = 0;
        we = 1;
        
        //Testing output gpI1
        a = 0;
        gpI1 = 32'd168;
        tick;
        tick;
        
        //Testing output gpI2 
        a = 1;
        gpI2 = 32'd169;
        tick;
        tick;
        
        //Testing output gpO1 
        a = 2;
        wd = 32'd170;
        tick;
        
        //Testing output gpO2 
        a = 3;
        wd = 32'd171;
        tick;
        tick;
        
        we = 0;
        
        //Testing input gpI1
        a = 0;
        gpI1 = 32'd168;
        tick;
        tick;
        
        //Testing input gpI2 
        a = 1;
        gpI2 = 32'd169;
        tick;
        tick;
        
        //Testing input gpO1 
        a = 2;
        wd = 32'd170;
        tick;
        
        //Testing input gpO2 
        a = 3;
        wd = 32'd171;
        tick;
        tick;
        
    end
    
endmodule
