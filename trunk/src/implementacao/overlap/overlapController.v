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

module overlapController(clk);
	
	parameter windowSize = 1024;
	parameter halfWindowSize = 512;
	parameter wordLength = 16;
	
	input clk, rst;
	
	output [((2 * wordLength) - 1):0] pcm_0;
	output [((2 * wordLength) - 1):0] pcm_1;
	output [1:0]sequencePos;
	
	unsigned integer secondSequenceIndex;
	unsigned integer wordIndex;
	
	
	always @(posedge clk or rst)
	begin
	
		if(rst) begin
			secondSequenceIndex = 0;
			wordIndex = 0;
		end
		else begin
			if(secondSequenceIndex == 0) begin
				sequencePos <= 2b'01;
				
				/*
				* read memory
				* 
				* read [secondSequenceIndex][wordIndex: wordIndex+1]
				*
				* write data on the bus
				*
				* active the overlapping
				*/
			end
			else begin
				sequencePos <= 2b'00;
				
				/*
				* read memory
				* 
				* read [secondSequenceIndex - 1][(wordIndex + halfWindowSize): (wordIndex + halfWindowSize) + 1] //duas palavras adjacentes
				* read [secondSequenceIndex][wordIndex: wordIndex+1]
				*
				* write data on the bus
				*
				* active the overlapping
				*/
				
				
			end
			
			wordIndex = wordIndex + 2; //dois dados lidos por vez
			if(wordIndex >= halfWindowSize) begin
				wordIndex = 0;
				secondSequenceIndex = secondSequenceIndex ++;
			end
			
		end
		
	
	end
	
endmodule
