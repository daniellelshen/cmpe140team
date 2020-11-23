module fact_top_tb;
   
    reg         clk;
    reg         rst;
    reg [3:2]   A;
    reg         WE;
    reg  [3:0]  WD;
    wire [31:0] RD;
    
    fact_top fact_top (
        .clk        (clk),
        .rst        (rst),
        .A          (A),
        .WE         (WE),
        .WD         (WD),
        .RD         (RD)
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
    
    integer i = 4;
    initial begin
        reset;
        while (i < 14) begin
            A = 2'b00; #5;
            WD = i;
            WE = 1'b1; #5;
            tick;
            tick;
            tick;
            tick;
            
            A=2'b01; #5;
            WD = 1;
            tick;
            tick;
            tick;
            tick;
           
            WD = i;
            WE = 1'b0; #5;
            A = 2'b10; #5;
            tick;
            tick;
            tick;
            tick;
            
            A = 2'b11; #5;
            while(!fact_top.resDone && i != 14) begin 
                tick;
            end
            
            i = i + 1;
            
            
         end
      tick;
      $finish;
        
    end


endmodule
