
//Mem→Wr阶段流水线寄存器
module Mem_Wr(clk,dmout_mem,ALUout_mem,rw_mem,dmout_wr,ALUout_wr,rw_wr,
	MemtoReg_mem,RegWr_mem,MemtoReg_wr,RegWr_wr);
	input clk;
	input [31:0]dmout_mem,ALUout_mem;	//mem阶段各信号
	input [4:0]rw_mem;
	input MemtoReg_mem,RegWr_mem;
	output [31:0]dmout_wr,ALUout_wr;	//wr阶段各信号
	output [4:0]rw_wr;
	output MemtoReg_wr,RegWr_wr;
	reg [70:0]regs;
	always @(negedge clk)	//下降沿触发，对信号进行更新
	begin
		regs[70]=MemtoReg_mem;	//先将mem阶段指令作为输入存入
		regs[69]=RegWr_mem;
		regs[68:37]=dmout_mem;
		regs[36:5]=ALUout_mem;
		regs[4:0]=rw_mem;
	end
	assign MemtoReg_wr=regs[70];		//然后再次读出时就更新为ex阶段的信号
	assign RegWr_wr=regs[69];
	assign dmout_wr=regs[68:37];
	assign ALUout_wr=regs[36:5];
	assign rw_wr=regs[4:0];
endmodule
		