module ULAsrcB(PC, A, MDR, seletor, out);

	input wire [2:0] seletor;
	input wire [31:0] PC, A, MDR;
	output reg [31:0] out;
	
	always @(seletor) begin
		out = 4;
	/*
		case(seletor)
			2'b00: out = PC;
			2'b01: out = A;
			2'b10: out = MDR;	
		endcase
		*/
	end

endmodule 