//����ð��ʱ����Rw��busWת����ALU���������
module forwording(busA_ex,ALUout_mem,busW,ALUsrcA,ALUA,busB_ex,ext_imm,ALUsrcB,ALUB,busB_new);
	input [31:0]busA_ex,ALUout_mem,busW,busB_ex,ext_imm;	//�������ex�׶�busA,B��ֵ����������ֵ���Լ�ALUout��busW��ֵ
	input [1:0]ALUsrcA,ALUsrcB;//�ж�ALU�Ƿ�ѡ��������
	output [31:0]ALUA,ALUB,busB_new;
	mux3 mux3_0(busA_ex,ALUout_mem,busW,ALUsrcA,ALUA);	//����ѡ�����ж�ת����ALU���������������ѡ�������
	mux4 mux4_0(busB_ex,ALUout_mem,busW,busB_ex,ALUsrcB,busB_new);
	mux4 mux4_1(busB_ex,ALUout_mem,busW,ext_imm,ALUsrcB,ALUB);
endmodule
