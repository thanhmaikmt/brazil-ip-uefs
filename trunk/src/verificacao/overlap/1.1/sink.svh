class sink extends ovm_component;

    ovm_get_port #(overlap_output) out_overlap_from_refmod;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
      out_overlap_from_refmod = new("out_overlap_from_refmod", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
       overlap_output tr_out_overlap;
       
       while(1) begin
          out_overlap_from_refmod.get(tr_out_overlap);
          
       end
    endtask
endclass

