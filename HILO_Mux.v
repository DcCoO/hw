module HILO_Mux(seletor, hidiv, lodiv, himult, lomult, hi, lo);

	input wire seletor;
	input wire [31:0] hidiv, lodiv, himult, lomult;
	output reg [31:0] hi, lo;
	
	always @(seletor) begin	
		case(seletor)
			1'b0: begin
				hi = hidiv;
				lo = lodiv;
			end
			1'b1: begin
				hi = himult;
				lo = lomult;
			end
		endcase
	end
	
endmodule 