// Esse Mult calcula o valor correto em 33 ciclos! 


module Mult (MultStart, out_A, out_B, rst, clk, HI, LOW, EndMult);
	input wire MultStart;
	input wire [31:0] out_A;
	input wire [31:0] out_B;
	output reg [31:0] HI;			// 32 bits mais significativos do resultado
	output reg [31:0] LOW;			// 32 bits menos significativos do resultado
	input wire rst;
	input wire clk;

	reg sinal;

	reg [64:0] A;
	reg [64:0] B;
	reg [64:0] negaA;

	reg [6:0] cont;
	output reg EndMult;

	always @(posedge clk) begin
		if (rst) begin
			sinal = 0; A = 0; B = 0; negaA = 0; cont = 0;
		end else if (MultStart == 1'd1) begin

			if (cont == 7'd0) begin		// atribuições iniciais do programa
				A = {out_A, 33'd0};			// formato: "bits do operando A + 33 bits 0"
				negaA = {(~out_A) + 1, 33'd0};	// ^~
				B = {32'd0, out_B, 1'b0};	// formato: "32 bits 0 + bits do operando B + 1 bit 0"
			end
			if (cont == 7'd32) begin		// cont == 32 => 0100000
				HI = B [64:33];
				LOW = B [32:1];		// descartando o bit mais extremo à direita
			end
			
			case (B[1:0])
				2'b01: begin
					B = B + A;		// 01
					sinal = B[64];		// bit de sinal
					B = (B >> 1);
				end
				2'b10: begin
					B = B + negaA;	// 10
					sinal = B[64];
					B = (B >> 1);
				end
				2'b00: begin			// esse valor e os outros dentro do case garantirão que o sinal ao fim
					sinal = B[64];		// da operação será garantido, pois uma vez tendo aparecido o bit de sinal
					B = (B >> 1);		// ele será mantido por cada uma das subsequentes atribuições.
				end
				2'b11: begin
					sinal = B[64];
					B = (B >> 1);
				end

			endcase
			B [64] = sinal;

			if (cont == 32) cont = 0;
			else cont = cont + 1;
			
			if (cont == 31) EndMult = 1'b1;
			if (cont == 0) EndMult = 1'b0;

		end // end if do MultSource

	end		// end always

endmodule 