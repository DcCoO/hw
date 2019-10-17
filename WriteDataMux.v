module WriteDataMux(seletor, ULAOut, LS, HI, LO, SignExtend1to32, SignExtend16to32, ShiftLeft16, Exception, ShiftReg, out);

	input wire [4:0] seletor;
	input wire [31:0] ULAOut, LS, HI, LO, SignExtend1to32, SignExtend16to32, ShiftLeft16, Exception, ShiftReg;
	output reg [31:0] out;
	
	always @(seletor) begin
		
		case(seletor)
			5'b00000: out = ULAOut;
			5'b00001: out = LS;
			5'b00010: out = HI;
			5'b00011: out = LO;
			5'b00100: out = SignExtend1to32;
			5'b00101: out = SignExtend16to32;
			5'b00110: out = ShiftLeft16;
			5'b00111: out = Exception;
			5'b01000: out = ShiftReg;	
		endcase
		
		
	end

endmodule 


