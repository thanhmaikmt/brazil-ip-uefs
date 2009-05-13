`include "ovm.svh"
//`include "sdi.svh"
`include "extension_payload.svh"

class fill_element extends syntatic_element;
		 
	rand bit[3:0] count;
	rand byte esc_count;
	
	rand extension_payload extension_payload[268:0];
	//while (cnt > 0) {
	//	cnt -= extension_payload(cnt);
	//}

	function new();
		for(int i=0; i<269;i++)begin
			extension_payload[i] = new;
		end
	endfunction
	
	function string psprint();
      psprint = $psprintf(" ## FILL_ELEMENT: count = %d | esc_count = %d", count , esc_count);
   endfunction
   
endclass 