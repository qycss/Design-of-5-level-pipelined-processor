//�Ĵ���ģ�飺��������������Ĵ�����ַ�������Ӧ�Ĵ�����ֵ�����ݼĴ�����дʹ���źź�Rw,���½��ؽ�����д��RF��
module rf(clk,RegWr,ra,rb,rw,busA,busB,busW);
	input clk,RegWr;
	input [4:0]rw,ra,rb;
	input [31:0]busW;
	output [31:0] busA,busB;

	reg[31:0]regs[31:0];
	initial begin
				//��ʼ����$si = i	(i=0~7)	
		regs[23]=7;
		regs[22]=6;
		regs[20]=4;//s4
		regs[19]=3;//s3
		regs[18]=2;//s2
		regs[17]=1;//s1
		regs[16]=0;//s0
		regs[0]=0;		//$zero = 0
		
	end
	assign busA=regs[ra];	//��Ra,Rb����BusA,BusB	
	assign busB=regs[rb];
	always @(posedge clk)
	begin
		if((rw!=0)&&(RegWr==1))	//�½��ش��������дʹ���ź�Ϊ1��Rw��Ϊ0ʱ�������ݴ���busW
		begin	
			regs[rw]=busW;
		end
	end

endmodule 
		