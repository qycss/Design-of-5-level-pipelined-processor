//转发操作前的检验
module check(RegWr_mem,rs_ex,rt_ex,rw_mem,rw_wr,RegWr_wr,ALUsrc_ex,ALUsrcA,ALUsrcB);
	input RegWr_mem,RegWr_wr,ALUsrc_ex;
	input [4:0]rs_ex,rt_ex,rw_mem,rw_wr;
	output reg[1:0]ALUsrcA,ALUsrcB;
	wire c1a,c2a,c1b,c2b;
	//根据书上定义对C1A,C2A,C1B,C2B定义
	assign c1a = RegWr_mem & rw_mem != 0 & rw_mem == rs_ex;
	assign c1b = RegWr_mem & rw_mem != 0 & rw_mem == rt_ex;
	assign c2a = RegWr_wr & rw_mem != 0 & rw_mem != rs_ex & rw_wr == rs_ex;
	assign c2b = RegWr_wr & rw_mem != 0 & rw_mem != rt_ex & rw_wr == rt_ex;
	always@(RegWr_mem,RegWr_wr,ALUsrc_ex,rs_ex,rt_ex,rw_mem,rw_wr)
	begin				//根据不同转发方更新ALUsrcA,B，后续传入转发操作部分
		if(c1a==1)
			ALUsrcA=01;
		else if (c2a==1)
			ALUsrcA=10;
		else
			ALUsrcA=00;
		if(ALUsrc_ex==1)
			ALUsrcB=11;
		else if(c1b==1)
			ALUsrcB=01;
		else if (c2b==1)
			ALUsrcB=10;
		else 
			ALUsrcB=00;

	end
endmodule
