/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação do Overlapping/Adding
* Descrição do arquivo: Controlador do Overlapping/Adding
------------------------------------------------------------------------ */





/*-------------------------------------------------------------------------------
* Módulo responsável por fornecer os endereços de memória que serão utilizados pelo overlap
* não é responsável por fornecer o endereço de onde armazenar os resultados
*
* busAddress[9:0]   - wordIndex;
* busAddress[11:10] - secondSequenceIndex;
* busAddress[15:12] - indica o trecho de memória do ovelap na memória
*
-------------------------------------------------------------------------------*/

module overlapController(enable, reset, doOverlap, busAddress);
	
	parameter windowSize = 1024;
	parameter halfWindowSize = 512;

	
	parameter adressBase = 4'b1000; //indica o trecho de memória do ovelap na memória
	
	input reset, enable;
		
	output doOverlap;
	output [15:0] busAddress;
	
	reg doOverlap;	
	reg [15:0] busAddress;
	
	reg loadedFirst;
	
	// números irão depender da memória compartilhada entre o overlapping e window switching
	// para secondSequenceIndex de 2 bits são compartilhadas 4 Kb de memória
	integer secondSequenceIndex;
	integer wordIndex;
	
	always @(posedge reset or posedge enable)
	begin
	
		if(reset) begin
			secondSequenceIndex <= 0;
			wordIndex <= -4;
			loadedFirst <= 0;
			doOverlap <= 0;
		end
		else begin
			//atualizar indices
			if(~loadedFirst) begin
				wordIndex = wordIndex + 4; //4 palavras lidas por vez
				
				if(wordIndex >= 512) begin
					secondSequenceIndex = secondSequenceIndex + 1;
					
					//evitar overflow em secondSequenceIndex
					/*números mágicos (32 e 4) devem ser múltiplos da quantidade de sequencias
					* que cabem na parte de memória compartilhada pelo overlap
					*/
					if(secondSequenceIndex >= 32)
						secondSequenceIndex = 4;
									
					wordIndex = 0;
				end
			end
			
			busAddress[15:12] <= adressBase; //indica o trecho de memória do ovelap na memória
			
			if(~loadedFirst) begin
				busAddress[9:0]   <= wordIndex;
				busAddress[11:10] <= secondSequenceIndex;
								
				//senão é a primeira sequencia
				//como saber qual é a última?
				if(secondSequenceIndex != 0) begin
					loadedFirst <= 1;
					doOverlap <= 0;
				end else
					doOverlap <= 1;
					
			end
			else begin
				busAddress[9:0]   <= wordIndex + 512;
				busAddress[11:10] <= secondSequenceIndex - 1;

				loadedFirst <= 0;
				doOverlap <= 1;
			end

			//após os dados(4 palavras) estarem no barramento, controlador principal tem que enviar o comando load ao overlap
			//após o overlap ter lido o dado o controlador principal libera a saida doOverlap para a entrada action do overlap
		end
		
	
	end
	
endmodule
