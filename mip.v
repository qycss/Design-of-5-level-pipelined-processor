//创建所有信号，并进行实例化
module mips(clk,rst);
	input clk,rst;
	wire [31:0] pc,npc,pc_plus_4_if,imout_if,pc_plus_4_id,imout_id,busA_id,busB_id;
	wire [5:0]op,func_id;
	wire [4:0]rs_id,rt_id,rd_id;
	wire [15:0]imm16_id;
	wire [25:0]target_id;
	wire Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,R_type;
	wire [2:0]ALUop;
	wire [31:0] pc_br,busA_ex,busB_ex,ALUA,ALUB,BUSA,BUSB,busB_new,ALUout_ex,ext_imm;
	wire [15:0] imm16_ex;
	wire [4:0] rs_ex,rt_ex,rd_ex,rw_ex;
	wire [5:0] func_ex;
	wire [1:0]ALUsrcA,ALUsrcB,BranchsrcA,BranchsrcB;
	wire [2:0]ALUop_ex,ALUctr;
	wire RegDst_ex,ALUSrc_ex,MemtoReg_ex,RegWr_ex,MemWr_ex,ExtOp_ex,R_type_ex;
	wire [31:0]pc_jump,ALUout_mem,busB_mem,dmout_mem;
	wire MemWr_mem,MemtoReg_mem,RegWr_mem;
	wire [4:0]rw_mem;
	wire [31:0]dmout_wr,ALUout_wr,busW;
	wire [4:0]rw_wr;
	wire MemtoReg_wr,RegWr_wr;
	wire pc_ctrl,if_id_ctrl,id_ex_ctrl;


	assign pc_plus_4_if=pc+4;
	pc PC(pc_ctrl,clk,rst,npc,pc);
	im_4k im(pc,imout_if);


	IFID if_id(if_id_ctrl,clk,pc_plus_4_if,imout_if,pc_plus_4_id,imout_id,Branch,zero,Jump);

	assign op=imout_id[31:26];
	assign rs_id=imout_id[25:21];
	assign rt_id=imout_id[20:16];
	assign rd_id=imout_id[15:11];
	assign func_id=imout_id[5:0];
	assign imm16_id=imout_id[15:0];
	assign target_id=imout_id[25:0];
	control ctrl(op,Branch,Jump,RegDst,ALUSrc,ALUop,MemtoReg,RegWr,MemWr,ExtOp,R_type);
	rf RF(clk,RegWr_wr,rs_id,rt_id,rw_wr,busA_id,busB_id,busW);//id


	IDEx id_ex(id_ex_ctrl,clk,imm16_id,busA_id,busB_id,rs_id,rt_id,rd_id,func_id,imm16_ex,busA_ex,busB_ex,rs_ex,rt_ex,rd_ex,func_ex,
	RegDst,ALUSrc,ALUop,MemtoReg,RegWr,MemWr,ExtOp,R_type,
	RegDst_ex,ALUSrc_ex,ALUop_ex,MemtoReg_ex,RegWr_ex,MemWr_ex,ExtOp_ex,R_type_ex);

	
	ext EXT(imm16_ex,ExtOp_ex,ext_imm);
	check fwdcheck(RegWr_mem,rs_ex,rt_ex,rw_mem,rw_wr,RegWr_wr,ALUSrc_ex,ALUsrcA,ALUsrcB);
	forwording fwd(busA_ex,ALUout_mem,busW,ALUsrcA,ALUA,busB_ex,ext_imm,ALUsrcB,ALUB,busB_new);

	aluctrl ALUCTRL(ALUop_ex,func_ex,R_type_ex,ALUctr);
	alu ALU(ALUctr,ALUA,ALUB,ALUout_ex);
	mux2 #(5)MUX1(rt_ex,rd_ex,RegDst_ex,rw_ex);//ex


	ExMem ex_mem(clk,ALUout_ex,busB_new,rw_ex,ALUout_mem,busB_mem,rw_mem,
	MemWr_ex,MemtoReg_ex,RegWr_ex,MemWr_mem,MemtoReg_mem,RegWr_mem);

	dm_4k DM(ALUout_mem,busB_mem,MemWr_mem,clk,dmout_mem);//mem
	
	
	Mem_Wr mem_wr(clk,dmout_mem,ALUout_mem,rw_mem,dmout_wr,ALUout_wr,rw_wr,
	MemtoReg_mem,RegWr_mem,MemtoReg_wr,RegWr_wr);
	
	mux2 #(32)MUX2(ALUout_wr,dmout_wr,MemtoReg_wr,busW);//wr
	
	branch_forward_check Bfwdcheck(RegWr_mem,rs_id,rt_id,rw_mem,rw_wr, MemtoReg_wr,BranchsrcA,BranchsrcB);
	branch_forward bfwd(busA_id,busB_id,ALUout_mem,busW,BranchsrcA,BranchsrcB,BUSA,BUSB);
	assign pc_jump={pc[31:28],target_id,2'b00};
	assign pc_br = pc_plus_4_id+{{14{imm16_id[15]}},imm16_id,2'b00};
	zero_check ZC(BUSA,BUSB,zero);
	npc NPC(Branch,zero,Jump,npc,pc_plus_4_if,pc_br,pc_jump);
	stall STALL(clk,rs_id,rt_id,rt_ex,rw_ex,rw_mem,MemtoReg_mem,MemtoReg_ex,RegWr_ex,Branch,pc_ctrl,if_id_ctrl,id_ex_ctrl);
	
endmodule
