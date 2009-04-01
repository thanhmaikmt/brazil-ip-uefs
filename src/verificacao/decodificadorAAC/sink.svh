class sink extends ovm_component;

    ovm_get_port #(amostra) amostra_from_refmod;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
      amostra_from_refmod = new("amostra_from_refmod", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
       amostra tr_amostra;
       
       while(1) begin
          amostra_from_refmod.get(tr_amostra);
		  $display("Amostra recebida do RefMod = %d" , tr_amostra.amostra);
          
       end
    endtask
endclass

