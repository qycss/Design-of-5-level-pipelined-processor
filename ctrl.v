
//根据op字段判断指令类型，并给各信号赋值
module control(OPcode,Branch,Jump,RegDst,ALUSrc,ALUop,MemtoReg,RegWr,MemWr,ExtOp,R_type);
	input [5:0]OPcode;
	output reg Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,R_type;
	output reg[2:0] ALUop;
	initial begin
	Branch=0;
	Jump=0;
	RegDst=0;
	ALUSrc=0;
	ALUop=000;
	MemtoReg=0;
	RegWr=0;
	MemWr=0;
	ExtOp=0;
	R_type=0;
	end
	always @(OPcode)
	begin
		case(OPcode)
			6'b000000:		//R型
			begin
				Branch=0;
				Jump=0;
				RegDst=1;
				ALUSrc=0;
				ALUop=000;
				MemtoReg=0;
				RegWr=1;
				MemWr=0;
				ExtOp=1;
				R_type=1;
			end
			6'b001101:		//or
			begin
				Branch=0;
				Jump=0;
				RegDst=0;
				ALUSrc=1;
				ALUop=010;
				MemtoReg=0;
				RegWr=1;
				MemWr=0;
				ExtOp=0;
				R_type=0;
			end
			6'b001001:		//addiu
			begin
				Branch=0;
				Jump=0;
				RegDst=0;
				ALUSrc=1;
				ALUop=001;
				MemtoReg=0;
				RegWr=1;
				MemWr=0;
				ExtOp=1;
				R_type=0;
			end
			6'b100011:		//lw
			begin
				Branch=0;
				Jump=0;
				RegDst=0;
				ALUSrc=1;
				ALUop=001;
				MemtoReg=1;
				RegWr=1;
				MemWr=0;
				ExtOp=1;
				R_type=0;
			end
			6'b101011:		//sw
			begin
				Branch=0;
				Jump=0;
				RegDst=0;
				ALUSrc=1;
				ALUop=001;
				MemtoReg=0;
				RegWr=0;
				MemWr=1;
				ExtOp=1;
				R_type=0;
			end
			6'b000100:		//beq
			begin
				Branch=1;
				Jump=0;
				RegDst=0;
				ALUSrc=0;
				ALUop=100;
				MemtoReg=0;
				RegWr=0;
				MemWr=0;
				ExtOp=1;
				R_type=0;
			end
			6'b000010:		//jump
			begin
				Branch=0;
				Jump=1;
				RegDst=0;
				ALUSrc=0;
				ALUop=101;
				MemtoReg=0;
				RegWr=0;
				MemWr=0;
				ExtOp=1;
				R_type=0;
			end
			6'b111111:		//nop
			begin
				Branch=0;
				Jump=0;
				RegDst=0;
				ALUSrc=0;
				ALUop=000;
				MemtoReg=0;
				RegWr=0;
				MemWr=0;
				ExtOp=0;
				R_type=0;
			end
		endcase
	end
endmodule
	