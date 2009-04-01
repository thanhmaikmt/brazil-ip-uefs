class refmod_decodificadorAAC extends ovm_component;

   ovm_get_port #(stream) entrada_stim;
   stream tr_in_entrada;
   
   ovm_put_port #(amostra) amostra_stim;
   amostra tr_out_amostra;
   
   covergroup crm;      
      coverpoint tr_out_amostra.amostra {
         bins tr[] = { 0 };
         option.at_least = 1;
      }
      
   endgroup

   function new(string name, ovm_component parent);
      super.new(name,parent);
      entrada_stim = new("entrada_stim", this);
      
      amostra_stim = new("amostra_stim", this);
      
      crm = new;
   endfunction

   task run();
      while(1) begin
        entrada_stim.get(tr_in_entrada);
        
        tr_out_amostra= new();
        
        //-----------------------------------------------------------------------
        // Here goes the code that executes the reference model's functionality.
        //-----------------------------------------------------------------------
		$display("\n###### STREAM RECEBIDA PELO REFMOD : \n%s", tr_in_entrada.psprint());	
		
		
		tr_out_amostra.amostra = 0;
        crm.sample();
	amostra_stim.put(tr_out_amostra);
        
      end
    endtask
endclass

