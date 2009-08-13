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
* pcm_in_1 - ultima metade da primeira seqüência
* pcm_in_2 - primeira metada da segunda seqüência
* pcm_out - saída
-------------------------------------------------------------------------------*/



module overlap(clock, reset, load, action, dataBus, dataBusOut);
	
	parameter wordLength = 16;
	
	parameter busSize = 4 * wordLength;
	
	input clock, reset, load, action;
	
	inout [(busSize - 1):0] dataBus; //sem ponto flutuante
	
	output [(busSize - 1):0] dataBusOut; //para debug
	
	//output [(busSize - 1):0] dataBusOut;
	
	wire [(busSize - 1):0] dataBus;
	
	reg [(busSize - 1):0] dataBusOut;
	
	reg [(wordLength - 1):0] pcm1 [3:0];
	reg [(wordLength - 1):0] pcm2 [3:0];
	

	integer i;
	integer loadedFirst; //deveria ser algum booleano
	
	assign dataBus = action? dataBusOut : 64'bz;
	//assign dataBus = 64'bz;
	
	always @(posedge clock or posedge reset)
	begin
		if(reset) begin
			for(i = 0; i < 4; i = i + 1) begin
				pcm1[i] <= 16'b0000000000000000;
				pcm2[i] <= 16'b0000000000000000;
			end
			
			loadedFirst <= 0;
			
		end
		else begin
			if(load) begin
				//primeiros valores foram carregados
				if(loadedFirst == 0) begin
				
					pcm1[0] <= dataBus[((0+1) * wordLength) - 1: 0 * wordLength];
					pcm1[1] <= dataBus[((1+1) * wordLength) - 1: 1 * wordLength];
					pcm1[2] <= dataBus[((2+1) * wordLength) - 1: 2 * wordLength];
					pcm1[3] <= dataBus[((3+1) * wordLength) - 1: 3 * wordLength];
					/*for(i = 0; i < 4; i = i + 1) begin
						pcm1[i] <= dataBusIn[((i+1) * wordLength) - 1: i * wordLength];
						pcm2[i] <= 16'b0000000000000000;
					end*/
					
					loadedFirst <= 1;
				end
				else begin
					/*for(i = 0; i < 4; i = i + 1) begin
						pcm2[i] <= dataBusIn[((i+1) * wordLength) - 1: i * wordLength];
					end*/
					pcm2[0] <= dataBus[((0+1) * wordLength) - 1: 0 * wordLength];
					pcm2[1] <= dataBus[((1+1) * wordLength) - 1: 1 * wordLength];
					pcm2[2] <= dataBus[((2+1) * wordLength) - 1: 2 * wordLength];
					pcm2[3] <= dataBus[((3+1) * wordLength) - 1: 3 * wordLength];
					
					loadedFirst <= 0;
				end
			end
			/*else if(action) begin
				/ *for(i = 0; i < 4; i = i + 1) begin
					dataBusOut[((i+1) * wordLength) - 1: i * wordLength] <= pcm1[i] + pcm2[i];
				end * /
				
				//dataBus <= dataBusOut;
			end*/
		end
		
		dataBusOut[((0+1) * wordLength) - 1: 0 * wordLength] <= pcm1[0] + pcm2[0];
		dataBusOut[((1+1) * wordLength) - 1: 1 * wordLength] <= pcm1[1] + pcm2[1];
		dataBusOut[((2+1) * wordLength) - 1: 2 * wordLength] <= pcm1[2] + pcm2[2];
		dataBusOut[((3+1) * wordLength) - 1: 3 * wordLength] <= pcm1[3] + pcm2[3];
		
	end
	
endmodule