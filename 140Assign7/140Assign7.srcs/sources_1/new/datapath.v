module datapath (
    	input  wire    	clk,
    	input  wire    	rst,
    	input  wire    	branch,
    	input  wire    	jump,
    	input  wire    	jump2,
    	input  wire    	reg_dst,
    	input  wire    	we_reg,
    	input  wire    	alu_src,
    	input  wire    	dm2reg,
    	input  wire [1:0]  result_op,
    	input  wire    	shift_op,
    	input  wire    	wd_sel,
    	input  wire    	wa_sel,
    	input  wire    	mult_we,
    	input  wire [2:0]  alu_ctrl,
    	input  wire [4:0]  ra3,
    	input  wire [31:0] instr,
    	input  wire [31:0] rd_dm,
    	
    	output wire [31:0] pc_current,
    	output wire [31:0] wd_dm,
    	output wire [31:0] rd3,
    	output wire [31:0] result
	);
	wire [4:0]  rf_wa;
	wire [4:0]  wa;
	wire [31:0] wd;
	wire    	pc_src;
	wire [31:0] pc_plus4;
	wire [31:0] pc_pre;
	wire [31:0] pc_next;
	wire [31:0] sext_imm;
	wire [31:0] ba;
	wire [31:0] bta;
	wire [31:0] jta;
	wire [31:0] jtal;
	wire [31:0] pc_jump_out;
	wire [31:0] alu_pa;
	wire [31:0] alu_pb;
	wire [31:0] wd_rf;
	wire [31:0] alu_out;
	wire [31:0] mfhi;
	wire [31:0] mflo;
	wire [31:0] shift_out;
	wire    	zero;
	
	assign pc_src = branch & zero;
	assign ba = {sext_imm[29:0], 2'b00};
	assign jta = {pc_plus4[31:28], instr[25:0], 2'b00};
	assign jtal = jta + 4'b1000;
	
	// --- PC Logic --- //
	dreg pc_reg (
        	.clk        	(clk),
        	.rst        	(rst),
        	.d          	(pc_next),
        	.q          	(pc_current)
    	);
	adder pc_plus_4 (
        	.a          	(pc_current),
        	.b          	(32'd4),
        	.y          	(pc_plus4)
    	);
	adder pc_plus_br (
        	.a          	(pc_plus4),
        	.b          	(ba),
        	.y          	(bta)
    	);
	mux2 #(32) pc_src_mux (
        	.sel        	(pc_src),
        	.a          	(pc_plus4),
        	.b          	(bta),
        	.y          	(pc_pre)
    	);
	mux2 #(32) pc_jmp_mux (
        	.sel        	(jump),
        	.a          	(pc_pre),
        	.b          	(jta),
        	.y          	(pc_jump_out)
    	);
    	
 	mux2 #(32) j_mux2 (
        	.sel        	(jump2),
        	.a          	(pc_jump_out),
        	.b          	(alu_pa),
        	.y          	(pc_next)
 	);
	// --- RF Logic --- //
	mux2 #(5) rf_wa_mux (
        	.sel        	(reg_dst),
        	.a          	(instr[20:16]),
        	.b          	(instr[15:11]),
        	.y          	(rf_wa)
    	);
	regfile rf (
        	.clk        	(clk),
        	.we         	(we_reg),
        	.ra1        	(instr[25:21]),
        	.ra2        	(instr[20:16]),
        	.ra3        	(ra3),
        	.wa         	(wa),
        	.wd         	(wd),
        	.rd1        	(alu_pa),
        	.rd2        	(wd_dm),
        	.rd3        	(rd3)
    	);
	signext se (
        	.a          	(instr[15:0]),
        	.y          	(sext_imm)
    	);
    	
	mux2 #(5) rf_wa_31_mux (
        	.sel        	(wa_sel),
        	.a          	(rf_wa),
        	.b          	(5'd31),
        	.y          	(wa)
	);
	// --- ALU Logic --- //
	mux2 #(32) alu_pb_mux (
        	.sel        	(alu_src),
        	.a          	(wd_dm),
        	.b          	(sext_imm),
        	.y          	(alu_pb)
    	);
	alu alu (
        	.op         	(alu_ctrl),
        	.a          	(alu_pa),
        	.b          	(alu_pb),
        	.zero       	(zero),
        	.y          	(alu_out)
    	);
 
 // added module for ALU logic
    	
	multu multu (
        	.a          	(alu_pa),
        	.b          	(wd_dm),
        	.mult_we    	(mult_we),
        	.mfhi       	(mfhi),
        	.mflo       	(mflo)
	);
	
	shift shift (
        	.num        	(wd_dm),
        	.amt        	(instr[10:6]),
        	.op         	(shift_op),
        	.out        	(shift_out)
	);
	
	mux4 #(32) result_mux (
        	.sel        	(result_op),
        	.a          	(alu_out),
        	.b          	(mfhi),
        	.c          	(mflo),
        	.d          	(shift_out),
        	.y          	(result)
	);
	// --- MEM Logic --- //
	mux2 #(32) rf_wd_mux (
        	.sel        	(dm2reg),
        	.a          	(result),
        	.b          	(rd_dm),
        	.y          	(wd_rf)
    	);
	
	mux2 #(32) wd_mux (
        	.sel        	(wd_sel),
        	.a          	(wd_rf),
        	.b          	(pc_plus4),
        	.y          	(wd)
	);
endmodule
