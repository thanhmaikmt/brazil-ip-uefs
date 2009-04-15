`ifdef INCA
  `include "ovm.svh"
`else
  import ovm_pkg::*;
`endif

`include "sdi.svh"
 
   function void record_set_overlap_input(int reco , int pcmSample, bit firstSequence);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, pcmSample);
      $sdi_set_attribute(reco, firstSequence);
   endfunction

class overlap_input extends ovm_object;
   int record;
    
   rand int pcmSample; 
   constraint pcmSample_range {
     pcmSample dist { [0:65536] };
   }
   
   rand bit firstSequence; 
   constraint firstSequence_range {
     firstSequence dist { [0:1] };
   }
   

   function integer equal(overlap_input tr);
      equal = (this.pcmSample == tr.pcmSample) && (this.firstSequence == tr.firstSequence);
   endfunction

   function string psprint();
      psprint = $psprintf("(pcmSample= %d - firstSequence= %d))", pcmSample, firstSequence);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d ", this.pcmSample, this.firstSequence);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_overlap_input(record,pcmSample,firstSequence);
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
     pcmSample dist { [0:65536] };
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

