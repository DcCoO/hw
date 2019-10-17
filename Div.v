module Div(clk, reset, div, a, b, hi, lo, divByZero);

	input wire clk, reset, div;
	input wire [31:0] a, b;
	output reg [31:0] hi, lo;
	output reg divByZero;
	
	always @(posedge clk) begin	
		if(b == 0)
			divByZero = 1;
		else begin
			divByZero = 0;
			hi = a / b;
			lo = a % b;			
		end
	end
	
endmodule 