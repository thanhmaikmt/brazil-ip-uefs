class sink extends ovm_component;

    ovm_get_port #(dequantizador_output) out_dequant_from_refmod;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
      out_dequant_from_refmod = new("out_dequant_from_refmod", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
       dequantizador_output tr_out_dequant;
       
       while(1) begin
          out_dequant_from_refmod.get(tr_out_dequant);
          
       end
    endtask
endclass

