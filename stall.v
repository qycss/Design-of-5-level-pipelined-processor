//���������ж��Ƿ���Ҫ��������������ź�����pc,IF_ID,ID_Ex

module stall(clk,rs_id,rt_id,rt_ex,rw_ex,rw_mem,MemtoReg_mem,MemtoReg_ex,RegWr_ex,Branch,pc_ctrl,if_id_ctrl,id_ex_ctrl);
	input [4:0]rs_id,rt_id,rt_ex,rw_ex,rw_mem;
	input MemtoReg_ex,clk,Branch,MemtoReg_mem,RegWr_ex;
	output reg pc_ctrl,if_id_ctrl,id_ex_ctrl;
	wire c,c1a,c1b;
	//lw+R��ָ���load useð��
	assign c = MemtoReg_ex &(( rt_ex == rs_id )|( rt_ex == rt_id ));
	assign c1a = Branch & rw_ex==rs_id & RegWr_ex;
	//beq��ת������
	assign c1b = Branch & rw_ex==rt_id & RegWr_ex;
	assign c2a = Branch & rw_mem==rt_id & MemtoReg_mem;
	//lw+beq��load_useð��
	assign c2b = Branch & rw_mem==rs_id & MemtoReg_mem;
	initial begin	//��ʼ���������ź�Ϊ0
		pc_ctrl=0;
		if_id_ctrl=0;
		id_ex_ctrl=0;
	end
	always@(negedge clk,c,c1a,c1b,c2a,c2b)
	begin
		if(c|c1a|c1b|c2a|c2b)		//��������һ����������3�������ź���1
		begin
			pc_ctrl=1;
			if_id_ctrl=1;
			id_ex_ctrl=1;
		end
		else
		begin
			pc_ctrl=0;
			if_id_ctrl=0;
			id_ex_ctrl=0;
		end
	end

endmodule
	