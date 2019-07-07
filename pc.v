
module pc(pc_ctrl,clk,rst,npc,pc);
	input clk;
	input rst;
	input pc_ctrl;
	input [31:0]npc;
	output reg[31:0]pc;
	always @(negedge clk)
	begin
		if(rst)
		begin	//复位后pc指向00003000
			pc=32'h00003000;
		end
		else if(pc_ctrl)	//如果产生阻塞信号则放空
		;
		else
		begin
			pc=npc;	//若一切正常则pc更新为npc（pc+4）
		end
	end
endmodule 