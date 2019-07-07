//IF→ID段流水线寄存器
module IFID(if_id_ctrl,clk,pc_plus_4_if,imout_if,pc_plus_4_id,imout_id,Branch,zero,Jump);
	input clk,if_id_ctrl,Branch,zero,Jump;
	input [31:0]pc_plus_4_if,imout_if;
	output [31:0]pc_plus_4_id,imout_id;
	reg [63:0]regs;
	always @(negedge clk)
	begin
		if(if_id_ctrl)	//如果发生阻塞，不进行操作，放空掉一个时钟周期
		;
		else if ((Branch&zero)|Jump)	//如果触发跳转，则将数组置空
		begin
			regs[63:0]=0;
		end
		else	//否则将if阶段的Pc+4和读出的指令存入
		begin
			regs[63:32]=pc_plus_4_if;
			regs[31:0]=imout_if;
		end
	end
	assign pc_plus_4_id=regs[63:32];	//更新信号
	assign imout_id=regs[31:0];
endmodule
		
	
