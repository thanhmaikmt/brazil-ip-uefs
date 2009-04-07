`include "ovm.svh"
//`include "sdi.svh"

class program_config_element extends syntatic_element;
		 
   rand bit[1:0] profile; //2 bits
   constraint profile_range {
     profile dist { 1 :/ 9 }; //perfil LC = 1
   }
   
   rand bit[3:0] sampling_frequency_index; //4 bits
   constraint sampling_frequency_index_range {
     sampling_frequency_index dist { 4 :/ 9 }; //44100
   }
   
   rand bit[3:0] num_front_channel_elements; //4 bits
   constraint num_front_channel_elements_range {
     num_front_channel_elements dist { [0:15] };
   }
   rand bit[3:0] num_side_channel_elements; //4 bits
   constraint num_side_channel_elements_range {
     num_side_channel_elements dist { [0:15] };
   }
   rand bit[3:0] num_back_channel_elements; //4 bits
   constraint num_back_channel_elements_range {
     num_back_channel_elements dist { [0:15] };
   }
   
   rand bit[1:0] num_lfe_channel_elements; //2 bits
   constraint num_lfe_channel_elements_range {
     num_lfe_channel_elements dist { [0:3] };
   }
   
   rand bit[2:0] num_assoc_data_elements; //3 bits
   constraint num_assoc_data_elements_range {
     num_assoc_data_elements dist { [0:7] };
   }
   
   rand bit[3:0] num_valid_cc_elements; //4 bits
   constraint num_valid_cc_elements_range {
     num_valid_cc_elements dist { [0:15] };
   }

	rand bit mono_mixdown_present; // 1 bit
	rand bit[3:0] mono_mixdown_element_number; //4 bits
	rand bit stereo_mixdown_present; //1 bits
	rand bit[3:0]  stereo_mixdown_element_number; //4 bits
	rand bit matrix_mixdown_idx_present; //1 bits
	rand bit[1:0] matrix_mixdown_idx ; //2 bits
    
	rand bit pseudo_surround_enable; // 1 bits

	//for (i = 0; i < num_front_channel_elements; i++)
	rand bit[14:0] front_element_is_cpe; //1 bit
	rand bit[14:0][3:0] front_element_tag_select; //4 bits	
	
	//for (i = 0; i < num_side_channel_elements; i++) {
	rand bit[14:0] side_element_is_cpe; //1 bslbf
	rand bit[14:0][3:0] side_element_tag_select; //4 uimsbf
	
	//for (i = 0; i < num_back_channel_elements; i++) {
	rand bit[14:0] back_element_is_cpe; //1 bslbf
	rand bit[14:0][3:0] back_element_tag_select; //4 uimsbf
	
	//for (i = 0; i < num_lfe_channel_elements; i++)
	rand bit[2:0][3:0] lfe_element_tag_select; //4 uimsbf
	
	//for (i = 0; i < num_assoc_data_elements; i++)
	rand bit[6:0][3:0] assoc_data_element_tag_select; //4 uimsbf
	
	//for (i = 0; i < num_valid_cc_elements; i++) {
	rand bit[14:0] cc_element_is_ind_sw; //1 uimsbf
	rand bit[14:0][3:0] valid_cc_element_tag_select; //4 uimsbf
	
	
	//byte_alignment();
	
	rand byte comment_field_bytes; //8 bits
	
	//for (i = 0; i < comment_field_bytes; i++)
	rand byte comment_field_data[0:254]; //8 bits
	
	
	function string psprint();
      psprint = $psprintf(" ##PCE: element_instance_tag = %d | profile = %d | sampling_frequency_index = %d | mono_mixdown_present = %d | mono_mixdown_element_number = %d | stereo_mixdown_present= %d | stereo_mixdown_element_number = %d ", element_instance_tag, profile, sampling_frequency_index, mono_mixdown_present , mono_mixdown_element_number, stereo_mixdown_present, stereo_mixdown_element_number);
   endfunction
   
endclass 