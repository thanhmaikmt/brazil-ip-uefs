class sink extends ovm_component;

    ovm_get_port_reescalador_output out_reescalador_from_refmod;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
      out_reescalador_from_refmod = new("out_reescalador_from_refmod", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
       reescalador_output tr_out_reescalador;
       
       while(1) begin
          out_reescalador_from_refmod.get(tr_out_reescalador);
          
       end
    endtask
endclass

