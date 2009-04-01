`include "ovm.svh"
//`include "sdi.svh"

class syntatic_element extends ovm_object;
 
   rand bit[3:0] element_instance_tag; 
   constraint element_instance_tag_range {
     element_instance_tag dist { [0:15] };
   }
   
   function string psprint();
      psprint = $psprintf(" ## SYNTATIC_ELEMENT : id_syn_ele = %d", id_syn_ele);
   endfunction

endclass 