
//Mem��Wr�׶���ˮ�߼Ĵ���
module Mem_Wr(clk,dmout_mem,ALUout_mem,rw_mem,dmout_wr,ALUout_wr,rw_wr,
	MemtoReg_mem,RegWr_mem,MemtoReg_wr,RegWr_wr);
	input clk;
	input [31:0]dmout_mem,ALUout_mem;	//mem�׶θ��ź�
	input [4:0]rw_mem;
	input MemtoReg_mem,RegWr_mem;
	output [31:0]dmout_wr,ALUout_wr;	//wr�׶θ��ź�
	output [4:0]rw_wr;
	output MemtoReg_wr,RegWr_wr;
	reg [70:0]regs;
	always @(negedge clk)	//�½��ش��������źŽ��и���
	begin
		regs[70]=MemtoReg_mem;	//�Ƚ�mem�׶�ָ����Ϊ�������
		regs[69]=RegWr_mem;
		regs[68:37]=dmout_mem;
		regs[36:5]=ALUout_mem;
		regs[4:0]=rw_mem;
	end
	assign MemtoReg_wr=regs[70];		//Ȼ���ٴζ���ʱ�͸���Ϊex�׶ε��ź�
	assign RegWr_wr=regs[69];
	assign dmout_wr=regs[68:37];
	assign ALUout_wr=regs[36:5];
	assign rw_wr=regs[4:0];
endmodule
		