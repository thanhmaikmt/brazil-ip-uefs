`include "ovm.svh"
//`include "sdi.svh"
`include "section_data.svh"
`include "scale_factor_data.svh"
`include "spectral_data.svh"
`include "ics_info.svh"

class individual_channel_stream extends ovm_object;
		 
	rand byte global_gain; //8 bits
	constraint global_gain_range {
     global_gain dist { [0:20] :/ 8 };
    }
	
	//if (!common_window)
	rand ics_info ics_info = new;
	
	rand section_data section_data = new;
	rand scale_factor_data scale_factor_data = new;
	
	rand bit pulse_data_present; //1 bit
	constraint pulse_data_present_range {
     pulse_data_present dist { 1'b0:/ 8 };
    }

	rand bit tns_data_present; //1 bit
	constraint tns_data_present_range {
     tns_data_present dist { 1'b0:/ 8 };
    }
	
	rand bit gain_control_data_present; //1 bit
	constraint gain_control_data_present_range {
     gain_control_data_present dist { 1'b0:/ 8 };
    }
	
	rand spectral_data spectral_data = new;

	function string psprint();
      psprint = $psprintf(" ##ICS : global_gain = %d \n%s \n%s \n%s \n%s" , global_gain, ics_info.psprint(), scale_factor_data.psprint(), section_data.psprint(), spectral_data.psprint() );
   endfunction
   
endclass 