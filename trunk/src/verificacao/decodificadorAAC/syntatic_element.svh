`include "ovm.svh"
//`include "sdi.svh"

class syntatic_element extends ovm_object;
   
   rand bit[2:0] id_syn_ele;
   constraint id_syn_ele_range {
     id_syn_ele dist { [0:1] :/60 , [4:6] :/20, [2:3] :/1 , 7 :/50 };
   }
   
   /*
    ID_name encoding Abbreviation Syntactic Element
	ID_SCE 	  0x0 		SCE 		single_channel_element()
	ID_CPE 	  0x1 		CPE 		channel_pair_element()
	ID_CCE 	  0x2 		CCE 		coupling_channel_element()
	ID_LFE 	  0x3 		LFE 		lfe_channel_element()
	ID_DSE 	  0x4 		DSE 		data_stream_element()
	ID_PCE 	  0x5 		PCE 		program_config_element()
	ID_FIL 	  0x6 		FIL 		fill_element()
	ID_END 	  0x7 		TERM
   */
   
   rand bit[3:0] element_instance_tag; 
   constraint element_instance_tag_range {
     element_instance_tag dist { [0:15] };
   }
   
   function string psprint();
      psprint = $psprintf(" ## SYNTATIC_ELEMENT : id_syn_ele = %d", id_syn_ele);
   endfunction

endclass 