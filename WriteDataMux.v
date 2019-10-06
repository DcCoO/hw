module WriteDataMux(ULAOut, seletor, out);

	input wire [2:0] seletor;
	input wire [31:0] ULAOut;
	output reg [31:0] out;
	
	always @(seletor) begin
		
		out = ULAOut;
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