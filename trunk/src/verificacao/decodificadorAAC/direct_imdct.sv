import "DPI-C" function real Cos(real valor);

parameter nLong = 2048;
parameter nShort = nLong/8;
		
class direct_imdct;
 
 
	real pi = 3.1415926535897932384626433832795;

	function new();
	endfunction
	  
	function void transformar(int is_window_sequence_long, int coef_dequant[1023 : 0], ref int coef_pcm[2047 : 0]);
		
		//////////////////////////EXECUTANDO/////////////////////////////////////
		$display("Valor do window_sequence_long = %d", is_window_sequence_long);
		if(is_window_sequence_long == 1)
		begin
			for(int i = 0; i < nLong; i++)
			begin
				real pcm = 0;
				for(int j = 0; j < (nLong/2); j++)
				begin
					real dequant = coef_dequant[j];
					//$display("Valor pcm e dequant = %f, %f", pcm, dequant);
					//$display("Valor  parcial = %f", cos((pi/(2*nLong))*(2*i+1+(nLong/2))*(2*j+1)));
					//$display("parcial = %f", (pi/(2*nLong))*(2*i+1+(nLong/2))*(2*j+1));
					pcm = pcm + dequant*Cos((pi/(2*nLong))*(2*i+1+(nLong/2))*(2*j+1));
				end
				coef_pcm[i] = pcm;
				//$display("Valor  pcm final= %f, na posição %d", coef_pcm[i], i);
			end
		end
		else
		begin
			for(int n = 0; n < 8; n++)
			begin
				//integer indiceInicial = n*nShort;
				for(int i = 0; i < nShort; i++)
				begin
					real pcm = 0;
					for(int j = 0; j < (nShort/2); j++)
					begin
						real dequant = coef_dequant[j];
						//$display("Valor pcm e dequant = %f, %f", pcm, dequant);
						//$display("Valor  parcial = %f", cos((pi/(2*nLong))*(2*i+1+(nLong/2))*(2*j+1)));
						pcm = pcm + dequant*Cos((pi/(2*nShort))*(2*(i)+1+(nShort/2))*(2*j+1));
					end
					coef_pcm[i + n*nShort] = pcm;
					//$display("Valor  pcm final= %f, na posição %d", coef_pcm[i + n*nShort], i + n*nShort);
				end
			end
		end 
		
		
	endfunction
	 
 endclass
