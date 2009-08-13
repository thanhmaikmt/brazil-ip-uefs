`include "ovm.svh"
`include "sdi.svh"
 
   function void record_set_overlap_input(int reco , int pcmSample1, int pcmSample2);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, pcmSample1);
      $sdi_set_attribute(reco, pcmSample2);
   endfunction

class overlap_input extends ovm_object;
   int record;
    
   rand int pcmSample1; 
   constraint pcmSample1_range {
     pcmSample1 dist { [0:1] };
   }
   
   rand int pcmSample2; 
   constraint pcmSample2_range {
     pcmSample2 dist { [0:1] };
   }
   

   function integer equal(overlap_input tr);
      equal = (this.pcmSample1 == tr.pcmSample1) && (this.pcmSample2 == tr.pcmSample2);
   endfunction

   function string psprint();
      psprint = $psprintf("(pcmSample1= %d, pcmSample2= %d)",pcmSample2);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d ", this.pcmSample1, this.pcmSample2);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_overlap_input(record,pcmSample1,pcmSample2);
      record_end(record);
   endtask

endclass

   function void record_set_overlap_output(int reco , int pcmSample);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, pcmSample);
   endfunction

class overlap_output extends ovm_object;
   int record;
    
   rand int pcmSample; 
   constraint pcmSample_range {
     pcmSample dist { [0:1] };
   }
   

   function integer equal(overlap_output tr);
      equal = (this.pcmSample == tr.pcmSample);
   endfunction

   function string psprint();
      psprint = $psprintf("(pcmSample= %d)",pcmSample);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d ", this.pcmSample);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_overlap_output(record,pcmSample);
      record_end(record);
   endtask

endclass


class delay; // used for delay in signal handshake
   rand int d;
   constraint delay_range {
      d dist {0 :/ 8, [1:2] :/2, [3:10] :/1 };
   }
endclass

