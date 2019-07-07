
module branch_forward_check(RegWr_mem,rs_id,rt_id,rw_mem,rw_wr, MemtoReg_wr,BranchsrcA,BranchsrcB);
	input  MemtoReg_wr,RegWr_mem;
	input [4:0]rs_id,rt_id,rw_mem,rw_wr;
	output reg[1:0]BranchsrcA,BranchsrcB;
	wire c1a,c2a,c1b,c2b;
	assign c1a = RegWr_mem & rw_mem != 0 & rw_mem == rs_id;	//�������϶����C1A,C1B,C2A,C2B���ж���
	assign c1b = RegWr_mem & rw_mem != 0 & rw_mem == rt_id;
	assign c2a = MemtoReg_wr & rw_mem != 0 & rw_mem != rs_id & rw_wr == rs_id;
	assign c2b = MemtoReg_wr & rw_mem != 0 & rw_mem != rt_id & rw_wr == rt_id;
	always@(RegWr_mem, MemtoReg_wr,rs_id,rt_id,rw_mem,rw_wr)
	begin
		if(c1a==1)			//���ݲ�ͬð�շ�ʽ����BranchsrcA,B ,������������ð�յĲ��ֽ��д���
			BranchsrcA=01;
		else if (c2a==1)
			BranchsrcA=10;
		else
			BranchsrcA=00;
		if(c1b==1)
			BranchsrcB=01;
		else if (c2b==1)
			BranchsrcB=10;
		else 
			BranchsrcB=00;
	end
endmodule