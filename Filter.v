module Filter(clk, instr15_0, RD, Shamt, Function);

	input wire clk;
	input wire [15:0] instr15_0;
	output reg [4:0] RD, Shamt;
	output reg [5:0] Function;
	
	always @(posedge clk) begin
		RD = instr15_0[15:11];
		Shamt = instr15_0[10:6];
		Function = instr15_0[5:0];
	end

endmodule 