module ULAsrcB(B, SignExtended, ShiftLeft2, seletor, out);

	input wire [2:0] seletor;
	input wire [31:0] B, SignExtended, ShiftLeft2;
	output reg [31:0] out;
	
	always @(seletor) begin
		
		case(seletor)
			2'b00: out = B;
			2'b01: out = 4;
			2'b10: out = SignExtended;
			2'b11: out = ShiftLeft2;	
		endcase
		
		
	end

endmodule 