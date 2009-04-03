`include "ovm.svh"

class scale_factor_data extends ovm_object;
	
	//para 44.1kHz -> maximo de 8 grupos, com um maximo de 49 bandas de fatores de escala por grupo, sendo que cada fator pode ter de 1 a 19 bits (VLC)	
	//hcod_sf[dpcm_sf[g][sfb]]
	//rand bit[18:0] scalefactors[7:0][48:0];
	rand bit[18:0] scalefactors[1:0][48:0];
	//constraint scalefactors_range {
	//	scalefactors dist { 0 :/ 30 , 4 :/ 20, [4'ha:4'hc] :/ 20,[8'h1a:8'h1b] :/ 15,[8'h38:8'hc] :/ 14, [8'h78:8'h7a] :/ 13, [8'hf6:8'hfa] :/ 12, [12'h1f6:12'h1f9] :/ 11, [12'h3f4:12'h3f9] :/ 10, [12'h7f4:12'h7f9] :/ 9, [12'hff4:12'hff9] :/ 9, [16'h1ff4:16'h1ff8] :/ 8, [16'h3ff2:16'h3ff9] :/ 7, [16'h7ff4:16'h7ff7] :/ 6, [16'hfff0:16'hfff6] :/ 5, [20'h1ffee:20'h1fff0] :/ 4, [20'h3ffe2:20'h3ffe8] :/ 3, [20'h7ffd2:20'h7ffd2] :/ 3 };
  //  }
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