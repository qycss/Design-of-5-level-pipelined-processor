# Design of 5-level pipelined processor
能执行 add，sub，and，or，slt，lw，sw，beq 和 jump指令，不支持溢出。

**【仅给未来要做36/45条流水线的dalao提供思路】**




## 模块化及层次化结构： ##
![](https://i.imgur.com/3eGDzqk.jpg)


## 数据通路： ##
![](https://i.imgur.com/kBVZzGp.png)

![](https://i.imgur.com/nTeMnty.png)

![](https://i.imgur.com/XbJDh24.png)

![](https://i.imgur.com/2PjD2LL.png)


## 模块定义 ##
**NPC模块**：NPC主要功能是根据当前指令是否为beq指令，输出下一条指令的地址。该模块调用了MUX模块


**ALU模块**：实现加、减、与、或和slt

**MUX模块**：多路选择

**REGFILE模块**：根据输入的两个寄存器地址，输出相应寄存器的值，根据寄存器写信号和寄存器地址，将输入的数据选择写入寄存器

**im_4k模块**：指令内存大小为4K，初始化从code.txt载入指令。根据输入的指令地址，输出当前位置存储的指令

**dm_4k模块**：
数据内存大小为 4K，根据输入的地址读出数据内存中的数据，并根据数据写信号，将输入的数据选择写入数据内存中

**ctrl模块**：根据输入的指令高 6 位(Op 字段)，利用真值表化简，输出 RegDst, ALUsrc, 
MemtoReg, RegWr, MemWr, branch, jump, ALUop控制信号。真值表采用书上200页图4-22，再加上jump指令的输入输出

**ext模块**：
将输入的16位地址扩展为32位

**IFID模块**：寄存器，输入if_id_ctrl,clk,pc_plus_4_if, imout_if,pc_plus_4_id,imout_id,Branch,zero,Jump，并存储。在branch&zero或jump信号为1时将存储的指令清零。

**IDEx模块**：根据clk,输入id_ex_ctrl,clk,imm16_id,busA_id,busB_id,Rs_id,Rt_id,Rd_id,func_id,RegDst,ALUSrc,ALUop,MemtoReg,RegWr,MemWr,ExtOp,R_type,输出imm16_ex,busA_ex,busB_ex,Rs_ex,Rt_ex,Rd_ex,func_ex,RegDst_ex,ALUSrc_ex,ALUop_ex,MemtoReg_ex,RegWr_ex,MemWr_ex,ExtOp_ex,R_type_ex

**ExMem模块**：根据clk,输入ALUout_ex,busB_ex,rw_ex,MemWr_ex,MemtoReg_ex,RegWr_ex,
输出ALUout_mem,busB_mem,rw_mem,MemWr_mem,MemtoReg_mem,RegWr_mem 


**MemWr模块**：
根据clk,输入dmout_mem,ALUout_mem,rw_mem,MemtoReg_mem,RegWr_mem,
输出dmout_wr,ALUout_wr,rw_wr,MemtoReg_wr,RegWr_wr 

**forwarding模块**：数据冒险时，将rw或者busW转发给ALU的两个输入端

**branch_forward**：Branch指令数据冒险时，将rw或者busW转发给zero判断的两个输入端 

**stall模块**：经过条件判断是否需要阻塞，并输出控制信号阻塞pc,ifid和idex 

**zero_check模块**：
在id阶段计算zero的值，判断是否需要跳转

## 各控制信号的逻辑表达式 ##
    `branch = beq = !op<5> & !op<4> & !op<3> & op<2> & !op<1> & !op<0> jump = jump = !op<5> & !op<4> & !op<3> & !op<2> & op<1> & !op<0>
	
	 RegDst = R-type = !op<5> & !op<4> & !op<3> & !op<2> & !op<2> & !op<0>

	 ALUsrc = ori + addiu + lw + sw 
     = !op<5> & !op<4> & op<3> & op<2> & !op<2> & op<0> // ori 
     = !op<5> & !op<4> & op<3> & !op<2> & !op<2> & op<0> // addiu 
     = op<5> & !op<4> & !op<3> & !op<2> & op<2> & op<0> // lw 
     = op<5> & !op<4> & op<3> & !op<2> & op<2> & op<0> // sw

	MemtoReg = lw = op<5> & !op<4> & !op<3> & !op<2> & op<2> & op<0> 
	
	ExtOp = R-type + addiu + lw + sw 
	= !op<5> & !op<4> & !op<3> & !op<2> & !op<2> & !op<0> // R-type 
    = !op<5> & !op<4> & op<3> & !op<2> & !op<2> & op<0> // addiu 
    = op<5> & !op<4> & !op<3> & !op<2> & op<2> & op<0> // lw 
    = op<5> & !op<4> & op<3> & !op<2> & op<2> & op<0> // sw 

	RegWr = R-type + ori + addiu + lw 
    = !op<5> & !op<4> & !op<3> & !op<2> & !op<2> & !op<0> // R-type 
	= !op<5> & !op<4> & op<3> & op<2> & !op<2> & op<0> // ori 
    = !op<5> & !op<4> & op<3> & !op<2> & !op<2> & op<0> // addiu 
    = op<5> & !op<4> & !op<3> & !op<2> & op<2> & op<0> // lw 


	`