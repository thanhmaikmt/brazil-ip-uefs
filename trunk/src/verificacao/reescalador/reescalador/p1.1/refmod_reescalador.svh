import "DPI-C" function real reesc(byte idx, int coef);
import "DPI-C" function real randDouble(real low, real high);
class refmod_reescalador extends ovm_component;

   ovm_get_port #(reescalador_input) in_reescalador_stim;
   reescalador_input tr_in_in_reescalador;
   
   ovm_put_port #(reescalador_output) out_reescalador_stim;
   reescalador_output tr_out_out_reescalador;
   real result;
   //real gain;   
   covergroup crm;
      
      coverpoint tr_out_out_reescalador.coef_reescalado {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
   endgroup

   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_reescalador_stim = new("in_reescalador_stim", this);
      
      out_reescalador_stim = new("out_reescalador_stim", this);
      
      crm = new;
   endfunction

   task run();
      while(1) begin
        in_reescalador_stim.get(tr_in_in_reescalador);
        tr_out_out_reescalador= new();

	       
        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------

		//Tudo é calculado e printado em C	
		result=reesc(tr_in_in_reescalador.scalefactor, tr_in_in_reescalador.coeficiente);

		//$display("coef:%d",tr_in_in_reescalador.coeficiente);
		tr_out_out_reescalador.coef_reescalado=result;
		$display("out:=%f",tr_out_out_reescalador.coef_reescalado);
		tr_out_out_reescalador.cover_real();
        crm.sample();
		out_reescalador_stim.put(tr_out_out_reescalador);
        
      end
    endtask
endclass

