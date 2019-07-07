//寄存器模块：根据输入的两个寄存器地址，输出相应寄存器的值，根据寄存器的写使能信号和Rw,在下降沿将数据写入RF。
module rf(clk,RegWr,ra,rb,rw,busA,busB,busW);
	input clk,RegWr;
	input [4:0]rw,ra,rb;
	input [31:0]busW;
	output [31:0] busA,busB;

	reg[31:0]regs[31:0];
	initial begin
				//初始化，$si = i	(i=0~7)	
		regs[23]=7;
		regs[22]=6;
		regs[20]=4;//s4
		regs[19]=3;//s3
		regs[18]=2;//s2
		regs[17]=1;//s1
		regs[16]=0;//s0
		regs[0]=0;		//$zero = 0
		
	end
	assign busA=regs[ra];	//将Ra,Rb传入BusA,BusB	
	assign busB=regs[rb];
	always @(posedge clk)
	begin
		if((rw!=0)&&(RegWr==1))	//下降沿触发，如果写使能信号为1且Rw不为0时，将数据传入busW
		begin	
			regs[rw]=busW;
		end
	end

endmodule 
		