`include "ovm.svh"

class scale_factor_data extends ovm_object;
	
	//para 44.1kHz -> maximo de 8 grupos, com um maximo de 49 bandas de fatores de escala por grupo, sendo que cada fator pode ter de 1 a 19 bits (VLC)	
	//hcod_sf[dpcm_sf[g][sfb]]
	rand bit[7:0][48:0][18:0] scalefactors;
	//FIXME
	function string psprint();
      string texto = $psprintf(" ##SCALE_FACTOR_DATA : scalefactors[0][0]=%d" , scalefactors[0][0]);
	/*
	  for(int i = 0 ; i< 49; i++) begin
		texto += $psprintf(" %d | ", scalefactors[i]);
	  end
	  */
	  psprint = texto;
   endfunction
   
endclass 