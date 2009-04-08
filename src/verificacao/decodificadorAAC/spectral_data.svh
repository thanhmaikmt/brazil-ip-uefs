  `include "ovm.svh"
//`include "sdi.svh"

class spectral_data extends ovm_object;

	 //maximo de 8 grupos, cada grupo com um maximo de 49 secoes, cada secao podera ter no maximo 512 coeficientes, caso seja sempre usado livro de codigo duplo!
	rand bit[15:0] hcod[1023:0];
	constraint hcod_range { //FIXME 
		foreach (hcod[i]) hcod[i] dist { /*Livro 1*/ 0 :/ 60 , [8'h10:8'h17] :/40 , [8'h60:8'h77] :/35, [12'h1e0:12'h1f7] :/20 , [12'h3f0:12'h3f7] :/10, [12'h7f0:12'h7ff] :/5, /*Livro 2*/ 0 :/40, 2 :/ 30, [4'h6:4'hc] :/ 25, [8'h1a:8'h31] :/ 20, [8'h64:8'h72] :/ 15, [8'he6:8'hf8] :/ 10, [12'h1f2:12'h1ff] :/5, /*Livro 3*/ 0 :/ 50 , [4'hb:4'h9] :/ 40, [8'h18:8'h19] :/ 30, [8'h34:8'h39] :/25, [8'h74:8'h76] :/ 20, [8'hee:8'hf2] :/ 18, [12'h1e6:12'h1f4] :/ 16, [12'h3ea:12'h3f8] :/ 14, [12'h7f2:12'h7f9] :/ 12,[12'hff4:12'hffc] :/ 10, [16'h1ffa:16'h1ffc] :/ 8, [16'h3ffa:16'h3ffc] :/ 8, [16'h7ffa:16'h1ffe] :/ 6, [16'hfffe:16'hffff] :/ 4, /*Livro 4*/ [4'h0:4'h9] :/ 50, [8'h14:8'h19] :/ 40, [8'h68:8'h70] :/ 30, [8'he3:8'hf5] :/ 25, [12'h1ee:12'h1f5] :/ 20, [12'h3ec:12'h3f9] :/ 15, [12'h7f4:12'h7fe] :/ 10, [12'hffe:12'hfff] :/ 5, /*Livro 5*/ 1'h0 :/ 60, [4'h8:4'hb] :/40 , [5'h18:5'h1b] :/35 , [7'h70:7'h73] :/32 , [8'he8:8'hf3] :/ 30 , [9'h1e8:9'h1f3] :/25 , [10'h3e8:10'h3f3] :/20 , [11'h7e8:11'h7f9] :/15, [12'hff4:12'hffd] :/10, [13'h1ffc:13'h1fff] :/20, /*Livro 6*/ [4'h0:4'h8] :/ 50, [6'h24:6'h33] :/ 40, [7'h68:7'h74] :/ 30 , [8'hea:8'hf1] :/ 20, [9'h1e4:9'h1fa] :/ 10, [10'h3f6:10'h3fd] :/ 7, [11'h7fc:11'h7ff] :/ 4, /*Livro 7*/ 1'h0 :/ 50, [3'h4:3'h5] :/ 40, 4'hc :/ 35, [6'h34:6'h37] :/ 30, [8'hea:8'hf3] :/ 25, [9'h1e8:9'h1f5] :/ 20, [10'h3ec:10'h3fa] :/ 15, [11'h7f7:11'h7fd] :/ 10, [12'hffc:12'hfff] :/ 5, /*Livro 8*/ 3'h0 :/ 50 , [4'h2:4'h6] :/ 40, [5'he:5'h14] :/ 30, [6'h2a:6'h33] :/ 20, [7'h68:7'h75] :/ 55, [8'hec:8'hf9] :/ 12 , [9'h1f6:9'h1fd] :/ 10, [10'h3fc:10'h3ff] :/ 5, /*Livro 9*/ 1'h0 :/ 60 , [3'h4:3'h5] :/ 55, 4'hc :/ 50, [6'h34:6'h37] :/ 50, [7'h70:7'h72] :/ 45, [8'he6:8'hed] :/ 40, [9'h1dc:9'h1e5] :/ 35, [10'h3ce:10'h3e1] :/ 30, [11'h7c4:11'h7e2] :/ 25, [12'hfc6:12'hfeb] :/ 20 , [13'h1fd8:13'h1ff6] :/ 15, [14'h3ff0:14'h3ffd] :/ 10, [15'h7ffc:15'h7fff] :/ 5 };
	}

	/*
	constraint hcod_range {
		(codebook == 1 ) -> foreach (hcod[i]) hcod[i] dist {  0 :/ 60 , [8'h10:8'h17] :/40 , [8'h60:8'h77] :/35, [12'h1e0:12'h1f7] :/20 , [12'h3f0:12'h3f7] :/10, [12'h7f0:12'h7ff] :/5  };
		
		(codebook == 2  ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 3 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 4 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 5  ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 6 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 7 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 8  ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 9 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 10 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };
		
		(codebook == 11 ) -> foreach (hcod[i]) hcod[i] dist {  [0:10000] };

	}
	*/
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