//���ݵ�ǰָ���Ƿ�Ϊbeq/jump�������һ��ָ��ĵ�ַ

module npc(br,zero,jump,npc,pc_plus_4,pc_br,pc_jump);
	input br,zero,jump;	//��֧��zero,jump�����ź�
	input [31:0]pc_plus_4,pc_br,pc_jump;	//��֧��jump�����µ�pc,��pc+4
	wire [31:0]npc_br;			//������ָ֧��ʱ����һ��ָ���ַ
	output [31:0]npc;			//����ָ��ĵ�ַ
	mux2 #(32) MUX1((pc_plus_4),(pc_br),(zero & br),(npc_br));	//���ö�·ѡ����ȷ���Ƿ���beq��ת��jump��ת
	mux2 #(32) MUX2(npc_br,pc_jump,jump,npc);		//���ö�·ѡ����ȷ��npc
	

endmodule 