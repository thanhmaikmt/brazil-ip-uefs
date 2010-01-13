/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação da interface AMBA-AXI
* Descrição do arquivo: interface AMBA-AXI
------------------------------------------------------------------------ */

/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;
*
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



module amba_axi_read(aclk, aresetn, awid, awaddr, dataBusIn, dataBusOut);
	
	parameter wordLength = 16;
	
	parameter busSize = 4 * wordLength;
	
	input aclk, aresetn;
	
	//
	input [3:0] awid;
	input [31:0] awaddr;
	
	
	
	
	
	
	
	
	
	
	
	
	
	input [(busSize - 1):0] dataBusIn;
	output [(busSize - 1):0] dataBusOut; //para debug
	
	wire [3:0] awid;
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
