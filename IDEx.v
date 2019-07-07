//ID→EX流水线寄存器模块

module IDEx(id_ex_ctrl,clk,imm16_id,busA_id,busB_id,Rs_id,Rt_id,Rd_id,func_id,imm16_ex,busA_ex,busB_ex,Rs_ex,Rt_ex,Rd_ex,func_ex,
	RegDst,ALUSrc,ALUop,MemtoReg,RegWr,MemWr,ExtOp,R_type,
	RegDst_ex,ALUSrc_ex,ALUop_ex,MemtoReg_ex,RegWr_ex,MemWr_ex,ExtOp_ex,R_type_ex);
	input clk;
	input id_ex_ctrl;		//id ex的阻塞控制信号
	input [15:0]imm16_id;	//id阶段各种信号
	input [31:0]busA_id,busB_id;
	input [4:0]Rs_id,Rt_id,Rd_id;
	input [5:0]func_id;
	input RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,R_type;	//各种控制信号
	input [2:0]ALUop,ALUop_ex;	//ex阶段各种信号
	reg [110:0]regs;
	output [15:0]imm16_ex;
	output [31:0]busA_ex,busB_ex;
	output [4:0]Rs_ex,Rt_ex,Rd_ex;
	output [5:0]func_ex;
	output RegDst_ex,ALUSrc_ex,MemtoReg_ex,RegWr_ex,MemWr_ex,ExtOp_ex,R_type_ex;
	always @(negedge clk)	//下降沿触发，对数据通路上各种信号、数值进行更新
	begin			
		if(id_ex_ctrl)
			regs[99:90]=0;
		else
		begin				//输入为id段信号
			regs[110:106]=Rs_id;
			regs[105:100]=func_id;
			regs[99]=RegDst;
			regs[98]=ALUSrc;
			regs[97:95]=ALUop;
			regs[94]=MemtoReg;
			regs[93]=RegWr;
			regs[92]=MemWr;
			regs[91]=ExtOp;
			regs[90]=R_type;
			regs[89:74]=imm16_id;
			regs[73:42]=busA_id;
			regs[41:10]=busB_id;
			regs[9:5]=Rt_id;
			regs[4:0]=Rd_id;
		end
	end
	assign Rs_ex=regs[110:106];		//将上一周期id阶段的信号更改为下一周期ex阶段的信号
	assign func_ex=regs[105:100];
	assign RegDst_ex=regs[99];
	assign ALUSrc_ex=regs[98];
	assign ALUop_ex=regs[97:95];
	assign MemtoReg_ex=regs[94];
	assign RegWr_ex=regs[93];
	assign MemWr_ex=regs[92];
	assign ExtOp_ex=regs[91];
	assign R_type_ex=regs[90];
	assign imm16_ex=regs[89:74];
	assign busA_ex=regs[73:42];
	assign busB_ex=regs[41:10];
	assign Rt_ex=regs[9:5];
	assign Rd_ex=regs[4:0];

endmodule
