/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação do Overlapping/Adding
* Descrição do arquivo: Controlador do Overlapping/Adding
------------------------------------------------------------------------ */





/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;
*
* int sequencePos - definido de acordo ao enum SequencePosition { middle = 0, first = 1, last = 2}
-------------------------------------------------------------------------------*/

module overlapController(enable, rst, firstAddress, secondAddress);
	
	parameter windowSize = 1024;
	parameter halfWindowSize = 512;
	parameter wordLength = 16;
	
	parameter adressBase = 0;
	
	input rst, enable;
		
	output [15:0] firstAddress;
	output [15:0] secondAddress;
	
	
	reg    [15:0] firstAddress;
	reg    [15:0] secondAddress;
	
	// números irão depender da memória compartilhada entre o overlapping e window switching
	// para secondSequenceIndex de 2 bits são compartilhadas 4 Kb de memória
	integer secondSequenceIndex;
	integer wordIndex;
	
	
	always @(enable or rst)
	begin
	
		if(rst) begin
			secondSequenceIndex = 0;
			wordIndex = 0;
		end
		else begin
			
			if(enable == 1) begin
				wordIndex = wordIndex + 2;
				
				if(wordIndex >= 512) begin
					secondSequenceIndex = secondSequenceIndex + 1;
					wordIndex = 0;
				end
			
			end				
			
		end
		
		secondAddress[9:0] = wordIndex;
		firstAddress[9:0]  = wordIndex + 512;
		
		secondAddress[11:10] = secondSequenceIndex;
		firstAddress [11:10] = secondSequenceIndex - 1;
	
	end
	
endmodule
