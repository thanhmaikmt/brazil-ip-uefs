/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação do Overlapping/Adding
* Descrição do arquivo: Overlapping/Adding e sua função de sobreposição de seqüência de janelas adjacentes
------------------------------------------------------------------------ */





/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;

* função utilizada na verificação
* function void overlap(int sequencePos,
* 						int pcm_in_1[(HALF_WINDOW_SIZE-1):0],
* 						int pcm_in_2[(HALF_WINDOW_SIZE-1):0],
*						ref int pcm_out[(HALF_WINDOW_SIZE-1):0]);
*
*
* int sequencePos - definido de acordo ao enum SequencePosition { middle = 0, first = 1, last = 2}
* pcm_in_1 - ultima metade da primeira seqüência
* pcm_in_2 - primeira metada da segunda seqüência
* pcm_out - saída
-------------------------------------------------------------------------------*/



module overlap(sequencePos, pcm_in_1, pcm_in_2, pcm_out);
	
	parameter wordLength = 16;
	
	
	input [((2 * wordLength) - 1):0] pcm_in_1; //sem sinal
	input [((2 * wordLength) - 1):0] pcm_in_2; //sem sinal
	input [1:0]sequencePos;
	
	output [((2 * wordLength) - 1):0] pcm_out;

	reg [((2 * wordLength) - 1):0] pcm_out;
	
	
	always
	begin
		case (sequencePos)
			2'b00:
			begin
				pcm_out[wordLength-1:0] <= pcm_in_1[wordLength-1:0] + pcm_in_2[wordLength-1:0];
				pcm_out[(2 * wordLength) - 1:wordLength] <= pcm_in_1[(2 * wordLength) - 1:wordLength] + pcm_in_2[(2 * wordLength) - 1:wordLength];
			end
			
			2'b01:
			begin
				pcm_out <= pcm_in_2;
			end
				
			2'b10:
			begin
				pcm_out <= pcm_in_1;
			end
			
			/*default:
			begin
				/*for (i = 0;i < 2 * wordLength;i = i + 1)
				begin
					pcm_out[i] = 1b'x;
				end* /
				
				pcm_out = 32b'z;
			end*/
			  
			  
		endcase

	end
	
endmodule