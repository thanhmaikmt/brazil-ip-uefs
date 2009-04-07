  `include "ovm.svh"
//`include "sdi.svh"

class spectral_data extends ovm_object;
		 
	 //FIXME definir a quantiade de coeficientes
	 //
	 //maximo de 8 grupos, cada grupo com um maximo de 49 secoes, cada secao podera ter no maximo 512 coeficientes, caso seja sempre usado livro de codigo duplo!
	rand bit[15:0] hcod[1023:0];
	constraint hcod_range { //FIXME
		foreach (hcod[i]) hcod[i] dist {  [0:10000] };
	}
	/*
	constraint codeword_range {
     codeword dist { [32'h00000000:32'h00000045] :/ 5 , [32'h00000054:32'h00000059] :/ 2, [32'h00000060:32'h0000007a] :/ 2, [32'h0000008c:32'h000000fa] :/ 1, [32'h00000190:32'h000001ff] :/ 1, [32'h0000038a:32'h000003ff] :/ 1, [32'h000007c4:32'h000007ff] :/ 1, [32'h00000fc6:32'h00000fff] :/ 1, [32'h00001fd8:32'h00001fff] :/ 1, [32'h00003ff0:32'h00003ffd] :/ 1, [32'h00007ff4:32'h00007fff] :/ 1, [32'h0000fff0:32'h0000ffff] :/ 1, [32'h0001ffee:32'h0001ffef] :/ 1, [32'h0003ffe2:32'h0003ffe8] :/ 1, [32'h0007ffd2:32'h0007ffff] :/ 1 };
   }
   */
/*	constraint hcod_range {
		foreach (hcod[i]) // For every element
			foreach (hcod[,j])
				foreach (hcod[,,h])
					hcod[i][j][h] dist { [0:255] };
		}
*/
	//CORRETO = [7:0][48:0][511:0]
	rand bit[3:0] quad_sign_bits[1023:0];	
	rand bit[1:0] pair_sign_bits[1023:0];	
	
	/*
	complemento dos coeficientes y e z, para os casos onde se usa o livro de código de ESCAPE (0 a 8 "1's" seguido de um separador "0" seguido da quantidade de ("1's" + 4) bits ) -> valor do coef = 2^(N+4) + esc_word, onde N é a quantiade de "1's"
	*/
	rand bit[20:0] hcod_esc_y[1023:0];	
	rand bit[20:0] hcod_esc_z[1023:0];	
	
	function string psprint();
      psprint = $psprintf(" ##SPECTRAL_DATA: hcod[0] = %d" , hcod[0] );
   endfunction
   
endclass 