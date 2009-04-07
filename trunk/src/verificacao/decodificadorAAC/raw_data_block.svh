`include "ovm.svh"
//`include "sdi.svh"
`include "single_channel_element.svh"
`include "channel_pair_element.svh"
`include "data_stream_element.svh"
`include "fill_element.svh"
`include "program_config_element.svh"

class raw_data_block extends ovm_object;
	rand bit[2:0] id_syn_ele[123:0];

	constraint id_syn_ele_range {foreach (id_syn_ele[i]) id_syn_ele[i] dist { 0 :/ 4, 1 :/ 3, [2:3] :/1 , [4:6] :/ 2, 7 :/ 3 };}
   //constraint id_syn_ele_range {
   //  id_syn_ele[123:0] dist { [0:1] :/2, [4:6] :/1, [2:3] :/1 , 7 :/ 6 };
   //}
   
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
	rand single_channel_element sce[1:0];
	rand channel_pair_element cpe[1:0];
	//rand data_stream_element dse[1:0];
	//rand fill_element fill[1:0];
	rand program_config_element pce[1:0];

	function new();
		for(int i=0; i<2;i++)begin
			sce[i] = new;
			cpe[i] = new;
			//dse[i] = new;
			//fill[i] = new;
			pce[i] = new;
		end

	endfunction
	
	//ordena os elementos sintaticos de maneira a garantir q em um raw_data_block exista 2 SCE ou 1 CPE
	task reorderSyntaticElements();
		int nSCE = 0;
		int nCPE = 0;
		int sceIndex = 0;
		for(int i=0; i<124;i++)begin
			if(id_syn_ele[i] == 7 && (nSCE<2 && nCPE < 1)) begin
				if(nSCE == 1) begin
					id_syn_ele[i] = 0; //ID_SCE
					nSCE++;
				end
				else begin
					id_syn_ele[i] = 1; //ID_CPE
					nCPE++;					
				end
				id_syn_ele[i+1] = 7; //ID_TERM
				break;
			end
			else if(id_syn_ele[i] == 0) begin
				if(nSCE == 2) begin
					id_syn_ele[i] = 7; //ID_TERM
					break;
				end
				else begin
					nSCE++;
					if(nSCE == 2) begin
						id_syn_ele[i + 1] = 7; //ID_TERM
						break;
					end
					else
						sceIndex = i;
				end	
				
			end
			else if(id_syn_ele[i] == 1) begin
				if(nCPE == 1) begin
					id_syn_ele[i] = 7; //ID_TERM
				end
				else begin
					nCPE++;
					id_syn_ele[i + 1] = 7; //ID_TERM
				end	
				if(nSCE != 0)
					id_syn_ele[sceIndex] = 4;
				break;
			end
			//$display("id_syn_ele[%d] = %d", i , id_syn_ele[i] );
		end

	endtask
	
	function string psprint();
      psprint = $psprintf(" ## RAW_DATA_BLOCK :  %s", sce[0].psprint());
   endfunction
   
endclass 