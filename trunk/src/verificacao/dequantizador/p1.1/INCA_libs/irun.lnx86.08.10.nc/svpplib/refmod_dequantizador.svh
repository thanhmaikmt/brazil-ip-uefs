
import "DPI-C" function real dequantiza(int idx);
class refmod_dequantizador extends ovm_component;

   ovm_get_port_dequantizador_input in_dequant_stim;
   dequantizador_input tr_in_in_dequant;
   
   ovm_put_port_dequantizador_output out_dequant_stim;
   dequantizador_output tr_out_out_dequant;
   
   covergroup crm;
      
      coverpoint tr_out_out_dequant.coef_dequant {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
   endgroup

   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_dequant_stim = new("in_dequant_stim", this);
      
      out_dequant_stim = new("out_dequant_stim", this);
      
      crm = new;
   endfunction

   task run();
      while(1) begin
        in_dequant_stim.get(tr_in_in_dequant);
        
        tr_out_out_dequant= new();
        
        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------
	
	//DEBULHAR ISSO AQUI DEPOIS tr_out_out_dequant.signal=tr_in_in_dequant.signal;
	tr_out_out_dequant.coef_dequant=dequantiza(tr_in_in_dequant.coef_quant);
	$display("Entrada:%d,  Saida%f",tr_in_in_dequant.coef_quant,tr_out_out_dequant.coef_dequant);

	//---
	//---
        crm.sample();
	out_dequant_stim.put(tr_out_out_dequant);
        
      end
    endtask
endclass

