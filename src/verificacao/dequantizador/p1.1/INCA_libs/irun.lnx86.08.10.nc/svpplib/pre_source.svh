class pre_source extends ovm_component;

   ovm_put_port_dequantizador_input in_dequant_to_refmod;
   
   function new(string name, ovm_component parent);
      super.new(name,parent);
      in_dequant_to_refmod = new("in_dequant_to_refmod", this);
   endfunction

   task run();
      dequantizador_input tr_in_dequant;
      
      int file = $fopen("tr.sti", "r");
      while(1) begin 
         
	 tr_in_dequant = new();
         if(!tr_in_dequant.read(file))
            assert(tr_in_dequant.randomize());
         in_dequant_to_refmod.put(tr_in_dequant);
         
         #1;
       end
    endtask
    
endclass

