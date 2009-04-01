`include "ovm.svh"
//`include "sdi.svh"
`include "section_data.svh"
`include "scale_factor_data.svh"
`include "spectral_data.svh"
`include "ics_info.svh"

class individual_channel_stream extends ovm_object;
		 
	rand byte global_gain; //8 bits
	constraint global_gain_range {
     global_gain dist { [0:255] };
    }
	
	//if (!common_window)
	rand ics_info ics_info = new;
	
	rand section_data section_data = new;
	rand scale_factor_data scale_factor_data = new;
	rand bit pulse_data_present; //1 bit
	//if (pulse_data_present) 
	//rand pulse_data pulse_data = new;

	rand bit tns_data_present; //1 bit
	//if (tns_data_present) 
	//rand tns_data tns_data = new;
	
	rand bit gain_control_data_present; //1 bit
	//if (gain_control_data_present) 
	//rand gain_control_data gain_control_data = new;
	
	rand spectral_data spectral_data = new;

	function string psprint();
      psprint = $psprintf(" ##ICS : global_gain = %d \n%s \n%s \n%s \n%s" , global_gain, ics_info.psprint(), scale_factor_data.psprint(), section_data.psprint(), spectral_data.psprint() );
   endfunction
   
endclass 