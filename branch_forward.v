//Branchָ�����֧ð��ʱ����Rw��busW��ֵת�����ж�zero(Rs,Rt)�����������
module branch_forward(busA_id,busB_id,ALUout_mem,busW,BranchsrcA,BranchsrcB,BUSA,BUSB);	
	input [31:0]busA_id,busB_id,ALUout_mem,busW;	
	input [1:0]BranchsrcA,BranchsrcB;
	output [31:0]BUSA,BUSB;	//zero������������
	mux3 MUX0(busA_id,ALUout_mem,busW,BranchsrcA,BUSA);	//������·ѡ����ѡ��ת������
	mux3 MUX1(busB_id,ALUout_mem,busW,BranchsrcB,BUSB);
endmodule