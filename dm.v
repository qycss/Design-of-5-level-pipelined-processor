//DM大小为4k，根据输入的地址输出DM对应寄存器的值，将指令写入DM
module dm_4k( ALUout, din, we, clk, dout ) ;
	input   [31:0]  ALUout ;  // 需要读写的地址
	input   [31:0]  din ;   
	input           we ;    //写使能信号
	input           clk ;   
	output  [31:0]  dout ;  // 输出
	reg     [31:0]  dm[1023:0] ;
	wire[9:0]addr;
	assign addr=ALUout[11:2];
	assign dout = dm[addr];
	initial begin
		dm[3]=5;
		dm[5]=5;
	end
	always @(negedge clk)	//下降沿触发，将din的值写入RF
	begin 
		if(we)
		begin
			dm[addr]=din;
		end
	end
endmodule 