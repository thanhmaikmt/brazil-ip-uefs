`include "ovm.svh"
//`include "sdi.svh"

class data_stream_element extends syntatic_element;
		 
	rand bit data_byte_align_flag;
	rand byte count;
	rand byte esc_count;

	//if (cnt == 255) {
	//cnt += esc_count; 8 uimsbf
	//}
	//if (data_byte_align_flag) {
	//byte_alignment();
	//}
	//for (i = 0; i < cnt; i++) {
	//ate 510 bytes de dados para cada instancia de data_stream_element (podem haver até 16 instancias)
	rand byte data_stream_byte[15:0][509:0]; //8 uimsbf
	//}
	
	function string psprint();
      psprint = $psprintf(" ## DATA_STREAM_ELEMENT: data_byte_align_flag = %d | count = %d", data_byte_align_flag , count);
   endfunction
   
endclass 