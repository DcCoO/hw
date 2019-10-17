module Controlador(clk, opcode, IorD, ULAsrcA, ULAsrcB, Load_IR, ULA_select, RegWrite, Load_A, Load_B,
					WriteRegMux, WriteDataMux, Load_ULAOut, MemWrite, state, Load_PC, funct, shamt, 
					divStart, multStart, Load_HI, Load_LO);

	integer estado = 0;
	
	//integer writeReg, writeData;
	
	//estados
	integer LER = 0, DECODIFICAR = 1, WAIT = 2, LOAD_ULAOUT = 3, WRITEREG = 4, LOAD_HILO = 5, TEMP = 6, DIV = 7;
	
	//estado state = LER;	

	input wire clk;
	input wire[4:0] shamt;
	input wire[5:0] opcode, funct;
	output reg Load_IR, RegWrite, Load_ULAOut, Load_A, Load_B, MemWrite, Load_PC, Load_HI, Load_LO, divStart, multStart;
	output reg[2:0] IorD, ULAsrcA, ULAsrcB, ULA_select, WriteRegMux;
	output reg[4:0] WriteDataMux;
	output reg[31:0] state;
	
	integer afterWait;
	integer waiting = 0;
	 

	always @(posedge clk) begin
		
		state = estado;
		
		case(estado)
			
			LER: begin
				Load_HI = 1'b0;
				Load_LO = 1'b0;
				Load_ULAOut = 1'b0;
				RegWrite = 1'b0;
				Load_PC = 1'b1;
				ULAsrcA = 2'b00;
				ULAsrcB = 2'b01;
				ULA_select = 3'b001;
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
							20: begin					//ADD
								Load_A = 1'b1;
								Load_B = 1'b1;
								Load_ULAOut = 1'b1;
								ULA_select = 3'b001;
								ULAsrcA = 2'b01;
								ULAsrcB = 2'b00;
								WriteRegMux = 2'b00;
								WriteDataMux = 5'b00000;								
								estado = LOAD_ULAOUT;
									
							end
							
							24: begin					//AND
								Load_A = 1'b1;
								Load_B = 1'b1;
								Load_ULAOut = 1'b1;
								ULA_select = 3'b011;
								ULAsrcA = 2'b01;
								ULAsrcB = 2'b00;
								WriteRegMux = 2'b00;
								WriteDataMux = 5'b00000;								
								estado = LOAD_ULAOUT;
									
							end
							
							26: begin					//DIV
								Load_A = 1'b1;
								Load_B = 1'b1;
								ULAsrcA = 2'b01;
								ULAsrcB = 2'b00;	
								divStart = 1;	
								Load_HI = 1'b1;
								Load_LO = 1'b1;						
								estado = DIV;
								afterWait = LOAD_HILO;								
							end
							
							22: begin					//SUB
								Load_A = 1'b1;
								Load_B = 1'b1;
								Load_ULAOut = 1'b1;
								ULA_select = 3'b010;
								ULAsrcA = 2'b01;
								ULAsrcB = 2'b00;
								WriteRegMux = 2'b00;
								WriteDataMux = 5'b00000;								
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
						WriteRegMux = 2'b01;
						WriteDataMux = 5'b00000;
						estado = LOAD_ULAOUT;				
					end
					
				endcase
			end
			
			LOAD_ULAOUT: begin
				if(funct == 26)
					estado = WAIT;
				else
					estado = WRITEREG;
			end	
			
			LOAD_HILO: begin
				Load_HI = 1'b1;
				Load_LO = 1'b1;						
				estado = LER;	
			end
			
			WRITEREG: begin
				RegWrite = 1'b1;
				//Load_ULAOut = 1'b0;
				estado = LER;
			end
			
			DIV: begin
				estado = afterWait;
			end
			
			TEMP: begin
			
			end
			
			
		endcase
		
	
	end
	
endmodule
	