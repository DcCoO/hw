module WriteRegMux(Instr25_21, seletor, out);

	input wire [2:0] seletor;
	input wire [4:0] Instr25_21;
	output reg [4:0] out;
	
	always @(seletor) begin
		
		out = Instr25_21;
		/*
		case(seletor)
			2'b00: out = B;
			2'b01: out = 4;
			2'b10: out = SignExtended;
			2'b11: out = ShiftLeft2;	
		endcase
		*/
		
	end

endmodule 