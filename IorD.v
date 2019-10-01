module IorD(PC, ULA_Result, ULAOut, ex_opcode, ex_overflow, ex_div0, seletor, out);

	input wire [2:0] seletor;
	input wire [31:0] PC, ULA_Result, ULAOut, ex_opcode, ex_overflow, ex_div0;
	output reg [31:0] out;
	
	always @(seletor) begin
		case(seletor)
			3'b000: out = PC;
			3'b001: out = ULA_Result;
			3'b010: out = ULAOut;
			3'b011: out = ex_opcode;
			3'b100: out = ex_overflow;
			3'b101: out = ex_div0;			
		endcase
	end

endmodule 