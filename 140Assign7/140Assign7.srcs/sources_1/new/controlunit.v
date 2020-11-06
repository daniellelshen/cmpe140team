module controlunit (
    	input  wire [5:0]  opcode,
    	input  wire [5:0]  funct,
    	output wire    	branch,
    	output wire    	jump,
    	output wire    	jump2,
    	output wire    	reg_dst,
    	output wire    	we_reg,
    	output wire    	alu_src,
    	output wire    	we_dm,
    	output wire    	dm2reg,
    	output wire    	wd_sel,
    	output wire    	wa_sel,
    	output wire [1:0]  result_op,
    	output wire    	shift_op,
    	output wire    	mult_we,
    	output wire [2:0]  alu_ctrl
	);
	
	wire [1:0] alu_op;
	maindec md (
    	.opcode     	(opcode),
    	.branch     	(branch),
    	.jump       	(jump),
    	.reg_dst    	(reg_dst),
    	.we_reg     	(we_reg),
    	.alu_src    	(alu_src),
    	.we_dm      	(we_dm),
    	.dm2reg     	(dm2reg),
    	.wd_sel     	(wd_sel),
    	.wa_sel     	(wa_sel),
    	.alu_op     	(alu_op)
	);
	auxdec ad (
    	.alu_op     	(alu_op),
    	.funct      	(funct),
    	.jump2      	(jump2),
    	.result_op  	(result_op),
    	.shift_op   	(shift_op),
    	.mult_we    	(mult_we),
    	.alu_ctrl   	(alu_ctrl)
	);
endmodule
