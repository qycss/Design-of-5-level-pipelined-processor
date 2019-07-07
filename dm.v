//DM��СΪ4k����������ĵ�ַ���DM��Ӧ�Ĵ�����ֵ����ָ��д��DM
module dm_4k( ALUout, din, we, clk, dout ) ;
	input   [31:0]  ALUout ;  // ��Ҫ��д�ĵ�ַ
	input   [31:0]  din ;   
	input           we ;    //дʹ���ź�
	input           clk ;   
	output  [31:0]  dout ;  // ���
	reg     [31:0]  dm[1023:0] ;
	wire[9:0]addr;
	assign addr=ALUout[11:2];
	assign dout = dm[addr];
	initial begin
		dm[3]=5;
		dm[5]=5;
	end
	always @(negedge clk)	//�½��ش�������din��ֵд��RF
	begin 
		if(we)
		begin
			dm[addr]=din;
		end
	end
endmodule 