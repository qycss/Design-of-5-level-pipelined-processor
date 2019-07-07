//IF��ID����ˮ�߼Ĵ���
module IFID(if_id_ctrl,clk,pc_plus_4_if,imout_if,pc_plus_4_id,imout_id,Branch,zero,Jump);
	input clk,if_id_ctrl,Branch,zero,Jump;
	input [31:0]pc_plus_4_if,imout_if;
	output [31:0]pc_plus_4_id,imout_id;
	reg [63:0]regs;
	always @(negedge clk)
	begin
		if(if_id_ctrl)	//������������������в������ſյ�һ��ʱ������
		;
		else if ((Branch&zero)|Jump)	//���������ת���������ÿ�
		begin
			regs[63:0]=0;
		end
		else	//����if�׶ε�Pc+4�Ͷ�����ָ�����
		begin
			regs[63:32]=pc_plus_4_if;
			regs[31:0]=imout_if;
		end
	end
	assign pc_plus_4_id=regs[63:32];	//�����ź�
	assign imout_id=regs[31:0];
endmodule
		
	
