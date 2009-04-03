`include "ovm.svh"
//`include "sdi.svh"

class section_data extends ovm_object;
	// podem existir até 8 grupos. Cada grupo pode possuir até 49 fatores de escala. Cada grupo é dividido em seções, sendo que o tamanho da seção é dado em quantidade de sfb
	rand bit[3:0] sect_cb[7:0][48:0];
	
	//ate 4 possiveis incrementos para o tamanho da secao
	rand bit[4:0] sect_len_incr[7:0][48:0][3:0];

	function string psprint();
	 string texto = $psprintf(" ##SECTION DATA: sect_cb[0][0]=%d", sect_cb[0][0]);
	 /*
	 for(int i = 0 ; i< 49; i++) begin
		texto += $psprintf(" %d | ", sect_cb[i]);
	 end
	 */
	 psprint = texto;
   endfunction
   
endclass 