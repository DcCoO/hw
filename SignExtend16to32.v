module SignExtend16to32(in, out);

	input wire [15:0] in;
	output reg [31:0] out;
	
	always begin
		out = {16'b0, in};
	end

endmodule 