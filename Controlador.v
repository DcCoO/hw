module Controlador(clk, opcode, IorD, ULAsrcA, ULAsrcB, Load_IR, ULA_select, RegWrite, Load_A, Load_B, WriteRegMux, WriteDataMux, Load_ULAOut, MemWrite, state, Load_PC);

	integer estado = 0;
	
	//estados
	integer LER = 0, DECODIFICAR = 1, ADDI0 = 2, ADDI1 = 3;
	
	//estado state = LER;	

	input wire clk;
	input wire[5:0] opcode;
	output reg Load_IR, RegWrite, Load_ULAOut, Load_A, Load_B, MemWrite, Load_PC;
	output reg[2:0] IorD, ULAsrcA, ULAsrcB, ULA_select, WriteRegMux, WriteDataMux;
	output reg[31:0] state;
	 

	always @(posedge clk) begin
		
		state = estado;
		
		case(estado)
			
			LER: begin
				Load_PC = 1'b1;
				IorD = 3'b000;
				ULAsrcA = 2'b00;
				ULAsrcB = 2'b01;
				MemWrite = 1'b0;
				Load_IR = 1'b1;
				estado = DECODIFICAR;			
			end
			
			DECODIFICAR: begin
				Load_PC = 1'b0;
				Load_IR = 1'b1;
				Load_ULAOut = 1'b0;
				Load_A = 1'b1;
				Load_B = 1'b1;
				RegWrite = 1'b0;
				
				//estado = PARADO;
				if(opcode == 8) estado = ADDI0;
				
							
				
			end
			
			ADDI0: begin
							
				ULAsrcA = 2'b01;
				ULAsrcB = 2'b10;
				ULA_select = 3'b001;
				Load_ULAOut = 1'b1;
				
				estado = ADDI1;			
			end
			
			ADDI1: begin
				Load_A = 1'b0;
				Load_B = 1'b0;
				Load_ULAOut = 1'b0;
				WriteRegMux = 2'b00;
				WriteDataMux = 2'b00;
				//Load_PC = 1'b1;				
				
				estado = LER;			
			end
			
			
			
		endcase
		
	
	end
	
endmodule
	