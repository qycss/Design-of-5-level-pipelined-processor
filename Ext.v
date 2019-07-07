

module ext(imm,ExtOp,ext_imm);
	input [15:0]imm;	//����չ��16λ������
	input ExtOp;	//����չ����
	output reg[31:0]ext_imm;	//��չ���
	initial begin
		ext_imm=0;
	end
	always @(imm,ExtOp)
	begin
		if(ExtOp)
		begin
			ext_imm={{16{imm[15]}},imm[15:0]};	//������չ:��λ������λ
		end
		else
		begin
			ext_imm={{16'b0},imm[15:0]};	//����չ����0
		end
	end
endmodule