`include "ovm.svh"
//`include "sdi.svh"
`include "individual_channel_stream.svh"
`include "syntatic_element.svh"

class single_channel_element extends syntatic_element;
		 
	rand individual_channel_stream ics = new;

	function string psprint();
      psprint = $psprintf("ID_SYN_ELE: %d | %s ", id_syn_ele ,ics.psprint());
   endfunction
   
endclass 