

module alu(ALUctr,A,B,result);	//根据ALUctr判断ALU进行的运算的类型
	input [2:0]ALUctr ;	
	input [31:0]A,B;
	output reg[31:0]result;
	always@(ALUctr or A or B)
	begin
		case(ALUctr)
			3'b000:result=A+B;	//addu
			3'b001:result=A+B;	//add
			3'b010:result=A|B;	// or
			3'b100:result=A-B;	//subu
			3'b101:result=A-B;	//sub
			3'b110:result=(A<B)?1:0;//sltu
			3'b111:result=(A<B)?1:0;//slt
		endcase
	end
endmodule 