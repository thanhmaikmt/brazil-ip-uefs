/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação do Overlapping/Adding
* Descrição do arquivo: Controlador do Overlapping/Adding
------------------------------------------------------------------------ */





/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;
*
*
*
* int sequencePos - definido de acordo ao enum SequencePosition { middle = 0, first = 1, last = 2}
* pcm_in_1 - ultima metade da primeira seqüência
* pcm_in_2 - primeira metada da segunda seqüência
* pcm_out - saída
-------------------------------------------------------------------------------*/



module overlapController(clk, sequencePos, pcm_in_1, pcm_in_2, pcm_out);
	
	parameter halfWindowSize = 512;
	parameter wordLength = 16;
	
	input clk;
	input [(halfWindowSize * wordLength - 1):0] pcm_in_1; 
	input [(halfWindowSize * wordLength - 1):0] pcm_in_2; 
	input [1:0]sequencePos;
	
	output [(halfWindowSize * wordLength - 1):0] pcm_out;

	reg [(halfWindowSize * wordLength - 1):0] pcm_out;
	
	integer i;
	integer msb, lsb;
	
	reg [ 2* wordLength - 1:0] in_1;
	reg [ 2* wordLength - 1:0] in_2;
	
	overlap over(sequencePos, in_1, in_2, out);
	
	always @(posedge clk )
	begin
 
		for(i = 0; i < halfWindowSize; i = i + 2)
		begin
			msb <= ((2 * i + 1) * wordLength - 1);
			lsb <= (i * wordLength);
			
			in_1 <= pcm_in_1[msb:lsb];
			in_2 <= pcm_in_2[msb:lsb];
			pcm_out[msb:lsb] <= out;
			
		end

	end
	
endmodule