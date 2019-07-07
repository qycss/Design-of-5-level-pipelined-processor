

module ext(imm,ExtOp,ext_imm);
	input [15:0]imm;	//待扩展的16位立即数
	input ExtOp;	//零扩展符号
	output reg[31:0]ext_imm;	//扩展结果
	initial begin
		ext_imm=0;
	end
	always @(imm,ExtOp)
	begin
		if(ExtOp)
		begin
			ext_imm={{16{imm[15]}},imm[15:0]};	//符号扩展:高位补符号位
		end
		else
		begin
			ext_imm={{16'b0},imm[15:0]};	//零扩展：补0
		end
	end
endmodule