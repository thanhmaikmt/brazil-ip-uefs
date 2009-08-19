/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementa��o do Overlapping/Adding
* Descri��o do arquivo: Controlador do Overlapping/Adding
------------------------------------------------------------------------ */





/*-------------------------------------------------------------------------------
* M�dulo respons�vel por fornecer os endere�os de mem�ria que ser�o utilizados pelo overlap
* n�o � respons�vel por fornecer o endere�o de onde armazenar os resultados
*
* busAddress[9:0]   - wordIndex;
* busAddress[11:10] - secondSequenceIndex;
* busAddress[15:12] - indica o trecho de mem�ria do ovelap na mem�ria
*
-------------------------------------------------------------------------------*/

module overlapController(enable, reset, doOverlap, busAddress);
	
	parameter windowSize = 1024;
	parameter halfWindowSize = 512;

	
	parameter adressBase = 4'b1000; //indica o trecho de mem�ria do ovelap na mem�ria
	
	input reset, enable;
		
	output doOverlap;
	output [15:0] busAddress;
	
	reg doOverlap;	
	reg [15:0] busAddress;
	
	reg loadedFirst;
	
	// n�meros ir�o depender da mem�ria compartilhada entre o overlapping e window switching
	// para secondSequenceIndex de 2 bits s�o compartilhadas 4 Kb de mem�ria
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
					/*n�meros m�gicos (32 e 4) devem ser m�ltiplos da quantidade de sequencias
					* que cabem na parte de mem�ria compartilhada pelo overlap
					*/
					if(secondSequenceIndex >= 32)
						secondSequenceIndex = 4;
									
					wordIndex = 0;
				end
			end
			
			busAddress[15:12] <= adressBase; //indica o trecho de mem�ria do ovelap na mem�ria
			
			if(~loadedFirst) begin
				busAddress[9:0]   <= wordIndex;
				busAddress[11:10] <= secondSequenceIndex;
								
				//sen�o � a primeira sequencia
				//como saber qual � a �ltima?
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

			//ap�s os dados(4 palavras) estarem no barramento, controlador principal tem que enviar o comando load ao overlap
			//ap�s o overlap ter lido o dado o controlador principal libera a saida doOverlap para a entrada action do overlap
		end
		
	
	end
	
endmodule
