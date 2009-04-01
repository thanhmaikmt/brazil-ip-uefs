`include "ovm.svh"
//`include "sdi.svh"

class ics_info extends ovm_object;
	
	rand bit ics_reserved_bit; //1 bit
	rand bit[1:0] window_sequence; //2 bits
	rand bit window_shape; // 1 bit
		
	
	//if (window_sequence == EIGHT_SHORT_SEQUENCE) {
	rand bit[3:0] max_sfb_1; //4 bits
	rand bit[6:0] scale_factor_grouping; //7 bits
	//}
	//else {
	rand bit[5:0] max_sfb_2; //6 bits
	rand bit predictor_data_present; //1 bits
	//if (predictor_data_present) {
	rand bit predictor_reset; //1 bits
	//if (predictor_reset) {
	rand bit[4:0] predictor_reset_group_number; //5 bits
	//}
	//for (sfb = 0; sfb < min(max_sfb,PRED_SFB_MAX); sfb++) {
	rand bit[48:0] prediction_used; //1 bits
	//}
	//}
	//}

	function string psprint();
      psprint = $psprintf(" ##ICS_INFO : window_sequence = %d" , window_sequence );
   endfunction
   
endclass 