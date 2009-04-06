  `include "ovm.svh"
//`include "sdi.svh"

class spectral_data extends ovm_object;
		 
	 //FIXME definir a quantiade de coeficientes
	 //
	 //maximo de 8 grupos, cada grupo com um maximo de 49 secoes, cada secao podera ter no maximo 512 coeficientes, caso seja sempre usado livro de codigo duplo!
	rand bit[15:0] hcod[1:0][1:0][63:0];
	constraint hcod_range {
		foreach (hcod[i]) // For every element
			foreach (hcod[,j])
				foreach (hcod[,,h])
					hcod[i][j][h] dist { [0:255] };
		}

	//CORRETO = [7:0][48:0][511:0]
	rand bit[3:0] quad_sign_bits[1:0][1:0][63:0];	
	rand bit[1:0] pair_sign_bits[1:0][1:0][63:0];	
	
	/*
	complemento dos coeficientes y e z, para os casos onde se usa o livro de código de ESCAPE (0 a 8 "1's" seguido de um separador "0" seguido da quantidade de ("1's" + 4) bits ) -> valor do coef = 2^(N+4) + esc_word, onde N é a quantiade de "1's"
	*/
	rand bit[20:0] hcod_esc_y[1:0][1:0][63:0];	
	rand bit[20:0] hcod_esc_z[1:0][1:0][63:0];	
	
	function string psprint();
      psprint = $psprintf(" ##SPECTRAL_DATA: hcod[0][0][0] = %d" , hcod[0][0][0] );
   endfunction
   
endclass 