
module im_4k( pc, dout ) ;
	input   [31:0]  pc ;	//其中pc[11:2]为指令地址
	wire [9:0]addr;  	//指令地址
	output  reg[31:0]  dout ;  // 当前位置的指令
	reg     [31:0]  im[1023:0] ;
	assign addr=pc[11:2];	
	initial begin	//载入指令
		$readmemh("code.txt",im);
	end
	always @(addr)
		dout=im[addr];	//根据输入的指令地址，输出当前位置存储的指令
endmodule 