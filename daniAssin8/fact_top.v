module fact_top(
        input         clk,
        input         rst,
        input  [3:2]  A,
        input         WE,
        input  [3:0]  WD,
        output [31:0] RD
    );
    
    wire [31:0] nf, Result;
    wire [3:0]  n;
    wire [1:0]  Rdsel, ErrDone;
    wire        WE1, WE2, go, GoPulse, GoPulseCmb;
    wire        error, done, resErr, resDone;
    
    assign GoPulseCmb = WE2 & WD[0];
    assign ErrDone[1] = resErr;
    assign ErrDone[0] = resDone;
    
    fact_ad Decoder (
        .A     (A),
        .WE    (WE),
        .WE1   (WE1),
        .WE2   (WE2),
        .Rdsel (Rdsel)
    );
    
    reg_file #(4) DataInput (
        .clk        (clk),
        .rst        (rst),
        .load       (WE1),
        .D          (WD),
        .Q          (n)
    );
    
    reg_file #(1) ControlInput (
        .clk        (clk),
        .rst        (rst),
        .load       (WE2),
        .D          (WD[0]),
        .Q          (go)
    );
    
    reg_file #(1) ControlOutput (
        .clk        (clk),
        .rst        (rst),
        .load       (1'b1),
        .D          (GoPulseCmb),
        .Q          (GoPulse)
    );
    
    reg_file DataOutput (  
        .clk        (clk),
        .rst        (rst),
        .load       (done),
        .D          (nf),
        .Q          (Result)
    );
    
    factorial Factorial (
        .clk        (clk),
        .rst        (rst),
        .go         (GoPulse),
        .n          (n),
        .error      (error),
        .done       (done),
        .product     (nf)
    );
    
    latch ErrReg (
        .clk        (clk),
        .rst        (rst),
        .r          (GoPulseCmb),
        .s          (error),
        .q          (resErr)
    );
    
    latch DoneReg (
        .clk        (clk),
        .rst        (rst),
        .r          (GoPulseCmb),
        .s          (done),
        .q          (resDone)
    );
    
    mux4 #(32) fact_mux (
        .a ({28'b0, n}),
        .b ({31'b0, go}),
        .c ({30'b0, ErrDone}),
        .d (Result),
        .sel (Rdsel),
        .y (RD)
    );

endmodule
