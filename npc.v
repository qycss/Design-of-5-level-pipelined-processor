//根据当前指令是否为beq/jump，输出下一条指令的地址

module npc(br,zero,jump,npc,pc_plus_4,pc_br,pc_jump);
	input br,zero,jump;	//分支，zero,jump控制信号
	input [31:0]pc_plus_4,pc_br,pc_jump;	//分支和jump条件下的pc,和pc+4
	wire [31:0]npc_br;			//发生分支指令时的下一条指令地址
	output [31:0]npc;			//下条指令的地址
	mux2 #(32) MUX1((pc_plus_4),(pc_br),(zero & br),(npc_br));	//利用二路选择器确定是否发生beq跳转或jump跳转
	mux2 #(32) MUX2(npc_br,pc_jump,jump,npc);		//利用二路选择器确定npc
	

endmodule 