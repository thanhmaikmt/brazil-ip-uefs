`include "ovm.svh"
//`include "sdi.svh"
`include "individual_channel_stream.svh"
`include "syntatic_element.svh"

class single_channel_element extends syntatic_element;
		 
	rand individual_channel_stream ics = new;

	function string psprint();
      psprint = $psprintf("ICS:  %s ", ics.psprint());
   endfunction
   
endclass 