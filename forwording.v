//数据冒险时，将Rw或busW转发给ALU两个输入端
module forwording(busA_ex,ALUout_mem,busW,ALUsrcA,ALUA,busB_ex,ext_imm,ALUsrcB,ALUB,busB_new);
	input [31:0]busA_ex,ALUout_mem,busW,busB_ex,ext_imm;	//正常情况ex阶段busA,B的值，立即数的值、以及ALUout、busW的值
	input [1:0]ALUsrcA,ALUsrcB;//判断ALU是否选择立即数
	output [31:0]ALUA,ALUB,busB_new;
	mux3 mux3_0(busA_ex,ALUout_mem,busW,ALUsrcA,ALUA);	//利用选择器判断转发后ALU两个输入端最终所选择的数据
	mux4 mux4_0(busB_ex,ALUout_mem,busW,busB_ex,ALUsrcB,busB_new);
	mux4 mux4_1(busB_ex,ALUout_mem,busW,ext_imm,ALUsrcB,ALUB);
endmodule
