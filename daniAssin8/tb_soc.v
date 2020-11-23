module tb_soc;

    reg         clk;
    reg         rst;
    wire [31:0] pc_current;    
    wire [31:0] DONT_USE;
    wire [31:0] gpO1, gpO2;
    wire [31:0] rd;
    
    soc soc (
        .clk        (clk),
        .rst        (rst),
        .ra3        (5'h0),
        .gpI1       ({28'd0, 4'd5}),
        .gpI2       (32'd0),
        .pc_current (pc_current),
        .rd3        (DONT_USE),  
        .gpO1       (gpO1),
        .gpO2       (gpO2),
        .rd         (rd)    
    );
    
    task tick;
    begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    endtask
    
    task reset;
    begin
        rst = 1'b0; #5;
        rst = 1'b1; #5;
        rst = 1'b0;
    end
    endtask
    
    initial begin
        reset;
        while (pc_current != 48'h40) tick;
        $finish;
    end

endmodule
