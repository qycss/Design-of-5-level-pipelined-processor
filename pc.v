
module pc(pc_ctrl,clk,rst,npc,pc);
	input clk;
	input rst;
	input pc_ctrl;
	input [31:0]npc;
	output reg[31:0]pc;
	always @(negedge clk)
	begin
		if(rst)
		begin	//��λ��pcָ��00003000
			pc=32'h00003000;
		end
		else if(pc_ctrl)	//������������ź���ſ�
		;
		else
		begin
			pc=npc;	//��һ��������pc����Ϊnpc��pc+4��
		end
	end
endmodule 