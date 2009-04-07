`include "ovm.svh"
`include "sdi.svh"
`include "raw_data_block.svh"

parameter N_RAW_DATA_BLOCK = 4;
/***********************************/
   function void record_set_stream(int reco , int adif_id, bit copyright_id_present, int copyright_id, bit original_copy, bit home, bit bitstream_type, int bitrate, int num_program_config_elements, int adif_buffer_fullness);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, adif_id);
      $sdi_set_attribute(reco, copyright_id_present);
      $sdi_set_attribute(reco, copyright_id);
      $sdi_set_attribute(reco, original_copy);
      $sdi_set_attribute(reco, home);
      $sdi_set_attribute(reco, bitstream_type);
      $sdi_set_attribute(reco, bitrate);
      $sdi_set_attribute(reco, num_program_config_elements);
      $sdi_set_attribute(reco, adif_buffer_fullness);
   endfunction

   /***********************************/

/***********************************/   
  
/***********************************/  
class stream extends ovm_object;
   int record;
 
// ### INICIO ADIF_HEADER 

   rand int adif_id; 
   constraint adif_id_range {
     adif_id dist { 32'h41444946 :/ 9};
   }
   
   rand bit copyright_id_present; 
   
   rand bit[71:0] copyright_id; 
   constraint copyright_id_range {
     copyright_id dist { [0:30] };
   }
   
   rand bit original_copy; 
   
   rand bit home; 
   
   rand bit bitstream_type; 
   constraint bitstream_type_range {
     bitstream_type dist { 0 :/ 8 }; //CONSTANTE = 0
   }
   
   rand bit[22:0] bitrate; 
   constraint bitrate_range {
     bitrate dist { [1:529200] :/ 9 };
   }
   
   rand bit[3:0] num_program_config_elements; 
   constraint num_program_config_elements_range {
     num_program_config_elements dist {  0 :/ 9 };
   }
   
   rand bit[19:0] adif_buffer_fullness; 
   constraint adif_buffer_fullness_range {
     adif_buffer_fullness dist { [0:12] };
   }
 
//PROGRAM CONFIG ELEMENTS - maximo de 15 PCE's
	rand program_config_element pce[2:0]; 
     
// ### FIM ADIF_HEADER


// ### INICIO RAW_DATA_STREAM
// Suficiente para 10s de audio
// 44.1k * 10s / 1024 amostras = 431
	rand raw_data_block raw_data_block[N_RAW_DATA_BLOCK-1:0];

// ### INICIO RAW_DATA_STREAM

	function new();
		for(int i=0; i<3;i++)begin
			pce[i] = new;
		end
		for(int i=0; i<N_RAW_DATA_BLOCK;i++)begin
			raw_data_block[i] = new;
		end
	endfunction


   function integer equal(stream tr);
      equal = (this.adif_id == tr.adif_id) && (this.copyright_id_present == tr.copyright_id_present) && (this.copyright_id == tr.copyright_id) && (this.original_copy == tr.original_copy) && (this.home == tr.home) && (this.bitstream_type == tr.bitstream_type) && (this.bitrate == tr.bitrate) && (this.num_program_config_elements == tr.num_program_config_elements) && (this.adif_buffer_fullness == tr.adif_buffer_fullness);
   endfunction

   function string psprint();
      psprint = $psprintf("adif_id= %x | copyright_id_present = %d | copyright_id= %d | original_copy = %d | home= %d | bitstream_type = %d | bitrate= %d | num_program_config_elements = %d | adif_buffer_fullness= %d \n%s \n%s", adif_id, copyright_id_present, copyright_id, original_copy , home, bitstream_type, bitrate, num_program_config_elements,adif_buffer_fullness, pce[0].psprint(), raw_data_block[0].psprint());
   endfunction


   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d %d %d %d %d %d %d %d", this.adif_id, this.copyright_id_present, this.copyright_id, this.original_copy, this.home, this.bitstream_type, this.bitrate, this.num_program_config_elements, this.adif_buffer_fullness);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_stream(record,adif_id,copyright_id_present,copyright_id,original_copy,home,bitstream_type,bitrate,num_program_config_elements,adif_buffer_fullness);
      record_end(record);
   endtask

endclass
/***********************************/

   function void record_set_amostra(int reco , int amostra);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, amostra);
   endfunction


class amostra extends ovm_object;
   int record;
    
   int amostra; 

   /*
   function integer equal(amostra tr);
      equal = (this.amostra == tr.amostra);
   endfunction

   function string psprint();
      psprint = $psprintf("(amostra= %d)", amostra);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d", this.amostra);
      else read = 0;    
   endfunction
*/
   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_amostra(record,amostra);
      record_end(record);
   endtask

endclass

/***********************************/

   function void record_set_erro(int reco ,  int erro);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
	  $sdi_set_attribute(reco, erro);
   endfunction


class erro extends ovm_object;
   int record;
    
   int erro = 0; 

   /*
   function integer equal(erro tr);
      equal = (this.erro == tr.erro);
   endfunction

   function string psprint();
      psprint = $psprintf("(erro= %d)", erro);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d", this.erro);
      else read = 0;    
   endfunction
*/
   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_erro(record,erro);
      record_end(record);
   endtask

endclass



   /***********************************/

   /***********************************/

class delay; // used for delay in signal handshake
   rand int d;
   constraint delay_range {
      d dist {0 :/ 8, [1:2] :/2, [3:10] :/1 };
   }
endclass

