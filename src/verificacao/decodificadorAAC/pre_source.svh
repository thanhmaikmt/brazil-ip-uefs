class pre_source extends ovm_component;

   ovm_put_port #(stream) entrada_to_refmod;
   
   function new(string name, ovm_component parent);
      super.new(name,parent);
      entrada_to_refmod = new("entrada_to_refmod", this);
   endfunction

   task run();
      stream tr_entrada;
      
      int file = $fopen("tr.sti", "r");
      while(1) begin 
         
	 tr_entrada = new();
         if(!tr_entrada.read(file))
            assert(tr_entrada.randomize());
			
         entrada_to_refmod.put(tr_entrada);
         
         #1;
       end
    endtask
    
endclass

