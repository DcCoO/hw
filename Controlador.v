module Controlador(clk, opcode, IorD, ULAsrcA, ULAsrcB, 
					Load_IR, ULA_select, RegWrite, Load_A, Load_B,
					WriteRegMux, WriteDataMux, Load_ULAOut, MemWrite, state, Load_PC, funct, shamt);

	integer estado = 0;
	
	integer writeReg, writeData;
	
	//estados
	integer LER = 0, DECODIFICAR = 1, WAIT = 2, LOAD_ULAOUT = 3, WRITEREG = 4, TEMP = 5;
	
	//estado state = LER;	

	input wire clk;
	input wire[4:0] shamt;
	input wire[5:0] opcode, funct;
	output reg Load_IR, RegWrite, Load_ULAOut, Load_A, Load_B, MemWrite, Load_PC;
	output reg[2:0] IorD, ULAsrcA, ULAsrcB, ULA_select, WriteRegMux;
	output reg[4:0] WriteDataMux;
	output reg[31:0] state;
	 

	always @(posedge clk) begin
		
		state = estado;
		
		case(estado)
			
			LER: begin
				Load_ULAOut = 1'b0;
				RegWrite = 1'b0;
				Load_PC = 1'b1;
				//IorD = 3'b000;
				ULAsrcA = 2'b00;
				ULAsrcB = 2'b01;
				ULA_select = 3'b001;
				//MemWrite = 1'b0;
				//Load_IR = 1'b1;
				estado = DECODIFICAR;			
			end
			
			DECODIFICAR: begin
				Load_PC = 1'b0;
				Load_IR = 1'b1;
				
				estado = WAIT;
				
							
				
			end
			
			WAIT: begin
			
				Load_IR <= 1'b0;
				case(opcode)
					0: begin
						
						case(funct)
							22: begin					//SUB
								Load_A = 1'b1;
								Load_B = 1'b1;
								Load_ULAOut = 1'b1;
								ULA_select = 3'b010;
								ULAsrcA = 2'b01;
								ULAsrcB = 2'b00;
								writeReg = 2'b00;
								writeData = 5'b00000;								
								estado = LOAD_ULAOUT;
									
							end
						endcase
						
											
					end
			
					8: begin							//ADDI
						Load_A = 1'b1;
						Load_B = 1'b1;
						Load_ULAOut = 1'b1;
						ULA_select = 3'b001;
						ULAsrcA = 2'b01;
						ULAsrcB = 2'b10;
						writeReg = 2'b01;
						writeData = 5'b00000;
						estado = LOAD_ULAOUT;				
					end
					
				endcase
			end
			
			LOAD_ULAOUT: begin
				estado = WRITEREG;
			end	
			
			WRITEREG: begin
				RegWrite = 1'b1;
				WriteRegMux = writeReg;
				WriteDataMux = writeData;
				//Load_ULAOut = 1'b0;
				estado = LER;
			end
			
			TEMP: begin
			end
			
			
			
		endcase
		
	
	end
	
endmodule
	