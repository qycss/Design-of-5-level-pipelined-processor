//Branch指令发生分支冒险时，将Rw或busW的值转发给判断zero(Rs,Rt)的两个输入端
module branch_forward(busA_id,busB_id,ALUout_mem,busW,BranchsrcA,BranchsrcB,BUSA,BUSB);	
	input [31:0]busA_id,busB_id,ALUout_mem,busW;	
	input [1:0]BranchsrcA,BranchsrcB;
	output [31:0]BUSA,BUSB;	//zero检测的两个输入
	mux3 MUX0(busA_id,ALUout_mem,busW,BranchsrcA,BUSA);	//利用三路选择器选择转发内容
	mux3 MUX1(busB_id,ALUout_mem,busW,BranchsrcB,BUSB);
endmodule