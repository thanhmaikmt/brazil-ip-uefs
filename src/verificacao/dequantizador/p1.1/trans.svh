`include "ovm.svh"
`include "sdi.svh"
 
   function void record_set_dequantizador_input(int reco , int coef_quant, bit signal);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, coef_quant);
      $sdi_set_attribute(reco, signal);
   endfunction

class dequantizador_input extends ovm_object;
   int record;
    
   rand int coef_quant; 
   constraint coef_quant_range {
     coef_quant dist { [0:8191] };
   }
   
   rand bit signal; 
   constraint signal_range {
     signal dist { [0:1] };
   }
   

   function integer equal(dequantizador_input tr);
      equal = (this.coef_quant == tr.coef_quant) && (this.signal == tr.signal);
   endfunction

   function string psprint();
      psprint = $psprintf("coef_quant= %d signal= %d",coef_quant,signal);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d %d ", this.coef_quant, this.signal);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_dequantizador_input(record,coef_quant,signal);
      record_end(record);
   endtask

endclass

   function void record_set_dequantizador_output(int reco , int coef_dequant);
      // optionaly use format specifier as 3rd argument of sdi_set_attribute 
      $sdi_set_attribute(reco, coef_dequant);
   endfunction

class dequantizador_output extends ovm_object;
   int record;
    
   rand int coef_dequant; 
   constraint coef_dequant_range {
     coef_dequant dist { [0:1] };
   }
   

   function integer equal(dequantizador_output tr);
      equal = (this.coef_dequant == tr.coef_dequant);
   endfunction

   function string psprint();
      psprint = $psprintf("(coef_dequant= %d)",coef_dequant);
   endfunction

   function bit read(int file);
      if (file && !$feof(file))
        read = 0 != $fscanf(file, "%d ", this.coef_dequant);
      else read = 0;    
   endfunction

   task rec_begin(int fiber, string label);
      record = record_begin(fiber, label);
   endtask

   task rec_end();
      record_set_dequantizador_output(record,coef_dequant);
      record_end(record);
   endtask

endclass


class delay; // used for delay in signal handshake
   rand int d;
   constraint delay_range {
      d dist {0 :/ 8, [1:2] :/2, [3:10] :/1 };
   }
endclass

