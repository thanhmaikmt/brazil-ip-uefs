`include "ovm.svh"
//`include "sdi.svh"

class extension_payload extends ovm_object;
		 
	rand bit[3:0] extension_type;
	
	//EXT_FILL_DATA
	rand bit[3:0] fill_nibble; /* must be ‘0000’ */
	constraint fill_nibble_range {
     fill_nibble dist { 0 :/9 };
    }
   
	rand byte fill_byte[267:0]; /* must be ‘10100101’ */
	//constraint fill_byte_range {
    // fill_byte dist { 8'b10100101 :/9 };
    //}
	
	//DEFAULT
	rand bit[267:0] other_bits;
	
	
	function string psprint();
      psprint = $psprintf(" ## EXTENSION_PAYLOAD: extension_type = %d | fill_nibble = %d ", extension_type , fill_nibble);
   endfunction
   
endclass 
