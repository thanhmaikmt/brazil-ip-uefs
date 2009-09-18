/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementa��o do Overlapping/Adding
* Descri��o do arquivo: Overlapping/Adding e sua fun��o de sobreposi��o de seq��ncia de janelas adjacentes
------------------------------------------------------------------------ */





/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;

* fun��o utilizada na verifica��o
* function void overlap(int sequencePos,
* 						int pcm_in_1[(HALF_WINDOW_SIZE-1):0],
* 						int pcm_in_2[(HALF_WINDOW_SIZE-1):0],
*						ref int pcm_out[(HALF_WINDOW_SIZE-1):0]);
*
*
* pcm_in_1 - ultima metade da primeira seq��ncia
* pcm_in_2 - primeira metada da segunda seq��ncia
* pcm_out - sa�da
-------------------------------------------------------------------------------*/



module overlap(clock, reset, load, action, dataBusIn, dataBusOut);
	
	parameter wordLength = 16;
	
	parameter busSize = 4 * wordLength;
	
	input clock, reset, load, action;
	
	//era inout mas n�o deu para fazer a verifica��o
	//inout [(busSize - 1):0] dataBus; //sem ponto flutuante
	
	input [(busSize - 1):0] dataBusIn;
	output [(busSize - 1):0] dataBusOut; //para debug
	
	wire [(busSize - 1):0] dataBusIn;
	wire [(busSize - 1):0] dataBusOut;
	
	//so para debug
	reg [(busSize - 1):0] dataBusTemp;
	
	reg [(wordLength - 1):0] pcm1 [3:0];
	reg [(wordLength - 1):0] pcm2 [3:0];
	

	integer i;
	reg loadedFirst; //deveria ser algum booleano
	
	assign dataBusOut = action? dataBusTemp : 64'bz;
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
				
					pcm1[0] <= dataBusIn[((0+1) * wordLength) - 1: 0 * wordLength];
					pcm1[1] <= dataBusIn[((1+1) * wordLength) - 1: 1 * wordLength];
					pcm1[2] <= dataBusIn[((2+1) * wordLength) - 1: 2 * wordLength];
					pcm1[3] <= dataBusIn[((3+1) * wordLength) - 1: 3 * wordLength];
					/*for(i = 0; i < 4; i = i + 1) begin
						pcm1[i] <= dataBusIn[((i+1) * wordLength) - 1: i * wordLength];
						pcm2[i] <= 16'b0000000000000000;
					end*/
					
					pcm2[0] <= 0;
					pcm2[1] <= 0;
					pcm2[2] <= 0;
					pcm2[3] <= 0;
					
					loadedFirst <= 1;
				end
				else begin
					/*for(i = 0; i < 4; i = i + 1) begin
						pcm2[i] <= dataBusIn[((i+1) * wordLength) - 1: i * wordLength];
					end*/
					pcm2[0] <= dataBusIn[((0+1) * wordLength) - 1: 0 * wordLength];
					pcm2[1] <= dataBusIn[((1+1) * wordLength) - 1: 1 * wordLength];
					pcm2[2] <= dataBusIn[((2+1) * wordLength) - 1: 2 * wordLength];
					pcm2[3] <= dataBusIn[((3+1) * wordLength) - 1: 3 * wordLength];
					
					loadedFirst <= 0;
				end
			end
		end
		
		if(action && ~load) begin
      loadedFirst <= 0;
		end
		  
		dataBusTemp[((0+1) * wordLength) - 1: 0 * wordLength] <= pcm1[0] + pcm2[0];
		dataBusTemp[((1+1) * wordLength) - 1: 1 * wordLength] <= pcm1[1] + pcm2[1];
		dataBusTemp[((2+1) * wordLength) - 1: 2 * wordLength] <= pcm1[2] + pcm2[2];
		dataBusTemp[((3+1) * wordLength) - 1: 3 * wordLength] <= pcm1[3] + pcm2[3];
		
	end
	
endmodule