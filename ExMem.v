//Ex→Mem流水线寄存器模块
module ExMem(clk,ALUout_ex,busB_ex,rw_ex,ALUout_mem,busB_mem,rw_mem,		//mem阶段信号
	MemWr_ex,MemtoReg_ex,RegWr_ex,MemWr_mem,MemtoReg_mem,RegWr_mem);	//ex阶段信号
	input clk;
	input [31:0]ALUout_ex,busB_ex;		//ex阶段信号
	input [4:0]rw_ex;
	input MemWr_ex,MemtoReg_ex,RegWr_ex;
	output [31:0]ALUout_mem,busB_mem;	//mem阶段信号
	output [4:0]rw_mem;

	output MemWr_mem,MemtoReg_mem,RegWr_mem;
	reg [71:0]regs;
		
	always @(negedge clk)	//下降沿触发，对mem→ex阶段对各信号进行更新
	begin			//先将ex阶段信号作为输入写入
		regs[71]=MemWr_ex;
		regs[70]=MemtoReg_ex;
		regs[69]=RegWr_ex;
		regs[68:37]=ALUout_ex;
		regs[36:5]=busB_ex;
		regs[4:0]=rw_ex;
	end
	assign MemWr_mem=regs[71];	 	//再次读出时更新为mem阶段信号
	assign MemtoReg_mem=regs[70];
	assign RegWr_mem=regs[69];
	assign ALUout_mem=regs[68:37];
	assign busB_mem=regs[36:5];
	assign rw_mem=regs[4:0];
endmodule
		
	