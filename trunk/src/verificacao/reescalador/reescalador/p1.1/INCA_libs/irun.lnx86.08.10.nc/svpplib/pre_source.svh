class pre_source extends ovm_component;

   ovm_put_port_reescalador_input in_reescalador_to_refmod;
   
   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_reescalador_to_refmod = new("in_reescalador_to_refmod", this);
   endfunction

   task run();
      reescalador_input tr_in_reescalador;
      
      int file = $fopen("tr.sti", "r");
      while(1) begin 
         
	 tr_in_reescalador = new();
         if(!tr_in_reescalador.read(file))
            assert(tr_in_reescalador.randomize());
         in_reescalador_to_refmod.put(tr_in_reescalador);
         
         #1;
       end
    endtask
    
endclass

