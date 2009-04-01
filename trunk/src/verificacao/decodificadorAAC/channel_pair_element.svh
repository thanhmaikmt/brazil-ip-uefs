`include "ovm.svh"
//`include "sdi.svh"

class channel_pair_element extends syntatic_element;
		 
	rand bit common_window;
	
	rand ics_info ics_info = new;
	rand bit[1:0] ms_mask_present;
	
	//maximo de 8 grupos. Cada grupo pode ter o maximo de 49 bandas de fator de escala
	//ms_used[g][sfb]
	rand bit[7:0][48:0] ms_used;
	
	rand individual_channel_stream ics = new;
	rand individual_channel_stream ics2 = new;

	function string psprint();
      psprint = $psprintf(" ##CHANNEL_PAIR_ELEMENT: commom_window = %d \nICS_INFO=%s", common_window, ics_info.psprint());
   endfunction
   
endclass 