
module aluctrl(ALUop,func,R_type,ALUctr);	//����ALU��op�ֶΣ���func�ֶΣ�����ALUctr
input [2:0]ALUop;
input [5:0]func;	
input R_type;
reg [2:0]ALU_ctr;
output [2:0]ALUctr;
always@(func or ALUop or R_type)
	begin
		case(func)
			6'b100000:
			begin
				ALU_ctr=000;	//add
			end
			6'b100010:
			begin
				ALU_ctr=101;	//sub
			end
			6'b100011:
			begin
				ALU_ctr=100;	
			end
			6'b100101:
			begin
				ALU_ctr=010;	//or
			end
			6'b101010:
			begin
				ALU_ctr=110;	//slt
			end
			6'b101011:
			begin
				ALU_ctr=111;
			end
		endcase
	end
assign ALUctr = (R_type ? ALU_ctr : ALUop);	//�����R��ָ���ALUctr���䣬�������Ϊop�ֶ�
endmodule
