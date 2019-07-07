//三路选择器，默认位数为32
module mux3 #(parameter WIDTH=32) (d0,d1,d2,s,y);
	input [WIDTH-1:0]d0,d1,d2;
	input [1:0]s;
	output reg[WIDTH-1:0]y;
	always@(d0,d1,d2,s,y)
	begin
		if (s==2'b00)
		begin
			y=d0;
		end
		if (s==2'b01)
		begin
			y=d1;
		end
		if (s==2'b10)
		begin
			y=d2;
		end
	end
			
endmodule

