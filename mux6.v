module mux6(in0, in1, in2, in3, in4, in5, seletor, out);

	input wire [2:0] seletor;
	input wire [31:0] in0, in1, in2, in3, in4, in5;
	output reg [31:0] out;
	
	always @(seletor) begin
		case(seletor)
			3'b000: out = in0;
			3'b001: out = in1;
			3'b010: out = in2;
			3'b011: out = in3;
			3'b100: out = in4;
			3'b101: out = in5;
		endcase
	end

endmodule 