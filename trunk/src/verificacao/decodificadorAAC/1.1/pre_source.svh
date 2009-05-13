
class pre_source extends ovm_component;

   ovm_put_port #(stream) entrada_to_refmod;
   
   function new(string name, ovm_component parent);
      super.new(name,parent);
      entrada_to_refmod = new("entrada_to_refmod", this);
   endfunction

   raw_data_block raw;
   
   task run();
      stream tr_entrada;
      
      int file = $fopen("tr.sti", "r");
      while(1) begin 
         
	 tr_entrada = new();
	 //organiza os raw_data_block

         if(!tr_entrada.read(file))
            assert(tr_entrada.randomize());
		
		for(int i=0; i< N_RAW_DATA_BLOCK ; i++) begin	
			raw = tr_entrada.raw_data_block[i];
			raw.reorderSyntaticElements();
		end
         entrada_to_refmod.put(tr_entrada);
         
         #1;
       end
    endtask
    
endclass

