
module im_4k( pc, dout ) ;
	input   [31:0]  pc ;	//����pc[11:2]Ϊָ���ַ
	wire [9:0]addr;  	//ָ���ַ
	output  reg[31:0]  dout ;  // ��ǰλ�õ�ָ��
	reg     [31:0]  im[1023:0] ;
	assign addr=pc[11:2];	
	initial begin	//����ָ��
		$readmemh("code.txt",im);
	end
	always @(addr)
		dout=im[addr];	//���������ָ���ַ�������ǰλ�ô洢��ָ��
endmodule 