`include "ovm.svh"
`include "sdi.svh"
 
   function void record_set_reescalador_input(int reco , int coeficiente, int scalefactor, bit signal);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, coeficiente);
      $sdi_set_attribute(reco, scalefactor);
      $sdi_set_attribute(reco, signal);
   endfunction

class reescalador_input extends ovm_object;
   int record;
    
   rand int coeficiente; 
   constraint coeficiente_range {
     coeficiente dist { [0:8388608] };
   }
   
   rand int scalefactor; 
   constraint scalefactor_range {
     scalefactor dist { [0:255] };
   }
   
   rand bit signal; 
   constraint signal_range {
     signal dist { [0:1] };
   }
   

   function integer equal(reescalador_input tr);
      equal = (this.coeficiente == tr.coeficiente) && (this.scalefactor == tr.scalefactor) && (this.signal == tr.signal);
   endfunction

   function string psprint();
      psprint = $psprintf("Coeficiente= %d, ScaleFactor=%d, Signal=%d",coeficiente, scalefactor,signal);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d %d ", this.coeficiente, this.scalefactor, this.signal);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_reescalador_input(record,coeficiente,scalefactor,signal);
      record_end(record);
   endtask

endclass

   function void record_set_reescalador_output(int reco , real coef_reescalado);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, coef_reescalado);
   endfunction

class reescalador_output extends ovm_object;
   int record;
    
//    rand real coef_reescalado; 
//    constraint coef_reescalado_range {
//      coef_reescalado dist { [0:1] };
//    }
   
   integer coef_reescalado;
   
   rand int coef_reescalado_cover;
    constraint coef_reescalado_cover_range{
      coef_reescalado_cover dist {[-10:9]};
    }
   
   function void randomize_real();
    if(coef_reescalado_cover==-10)
      coef_reescalado=-1;
    else
      coef_reescalado=randDouble(-0.999969482, 0.999969482);
    cover_real();
   endfunction
    
   function void cover_real();
    coef_reescalado_cover=10*coef_reescalado;
   endfunction 

   function integer equal(reescalador_output tr);
      equal = (this.coef_reescalado == tr.coef_reescalado);
   endfunction

   function string psprint();
      psprint = $psprintf("(coef_reescalado= %d)",coef_reescalado);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d ", this.coef_reescalado);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_reescalador_output(record,coef_reescalado);
      record_end(record);
   endtask

endclass


class delay; // used for delay in signal handshake
   rand int d;
   constraint delay_range {
      d dist {0 :/ 8, [1:2] :/2, [3:10] :/1 };
   }
endclass

