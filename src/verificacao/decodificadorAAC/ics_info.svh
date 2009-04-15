`include "ovm.svh"
//`include "sdi.svh"

class ics_info extends ovm_object;
	
	rand bit ics_reserved_bit; //1 bit
	rand bit[1:0] window_sequence; //2 bits
	rand bit window_shape; // 1 bit
		

	rand bit[3:0] max_sfb_short; //4 bits
	rand bit[6:0] scale_factor_grouping; //7 bits

	rand bit[5:0] max_sfb_long; //6 bits
	rand bit predictor_data_present; //1 bits

	rand bit predictor_reset; //1 bits

	rand bit predictor_reset_group_number[4:0]; //5 bits

	rand bit prediction_used[48:0]; //1 bits

	function int get_num_window_groups();
		int num_groups = 1;
		for(int i =6; i >= 0; i--)begin
			if(scale_factor_grouping[i] == 1'b0)
				num_groups++;
		end
		//$display("sf_grouping = %b | num_groups = %d",scale_factor_grouping, num_groups );
		return num_groups;
	endfunction
	
	function string psprint();
      psprint = $psprintf(" ##ICS_INFO : window_sequence = %d" , window_sequence );
   endfunction
   
endclass 