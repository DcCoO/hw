module WriteRegMux(seletor, RD, RT, out);

	input wire [2:0] seletor;
	input wire [4:0] RD, RT;
	output reg [4:0] out;
	
	always @(seletor) begin	
		
		case(seletor)
			2'b00: out = RD;
			2'b01: out = RT;
			2'b10: out = 30;
			2'b11: out = 31;	
		endcase
				
	end

endmodule 