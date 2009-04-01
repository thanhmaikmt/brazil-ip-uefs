`include "ovm.svh"
//`include "sdi.svh"
`include "single_channel_element.svh"
`include "channel_pair_element.svh"
`include "data_stream_element.svh"
`include "fill_element.svh"
`include "program_config_element.svh"

class raw_data_block extends ovm_object;
		 
	rand single_channel_element sce[1:0];
	rand channel_pair_element cpe[1:0];
	rand data_stream_element dse[1:0];
	rand fill_element fill[1:0];
	rand program_config_element pce[1:0];

	function new();
		for(int i=0; i<2;i++)begin
			sce[i] = new;
			cpe[i] = new;
			dse[i] = new;
			fill[i] = new;
			pce[i] = new;
		end
	endfunction
	
	function string psprint();
      psprint = $psprintf(" ## RAW_DATA_BLOCK :  %s", sce[0].psprint());
   endfunction
   
endclass 