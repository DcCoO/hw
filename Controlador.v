module Controlador(clk, IorD);

	integer estado = 0;
	
	//estado state = LER;	

	input wire clk;
	output reg[2:0] IorD; 

	always @(posedge clk) begin
	
	//codigo
		case(estado)
			
			0: begin
				//codigo
				IorD = 3'b000;
				
				//estado = DECODIFICAR;
			end
			
			1: begin
				//codigo
			end
		endcase
	
	end
	
endmodule
	