//二路选择器，默认width为32

module mux2 #(parameter WIDTH=32) (d0,d1,s,y);
	input [WIDTH-1:0]d0,d1;
	input s;
	output reg[WIDTH-1:0]y;
	always@(d0,d1,s,y)
	begin
		if (s==0)
			y = d0;
		else 
			y = d1;
	end
endmodule


