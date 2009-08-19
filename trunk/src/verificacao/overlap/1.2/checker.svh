
class checker extends ovm_threaded_component;

      
    ovm_get_port #(overlap_output) out_overlap_from_refmod;
    ovm_get_port #(overlap_output) out_overlap_from_duv;
    
    int fiber;
    function new(string name, ovm_component parent);
      super.new(name,parent);
        
      out_overlap_from_refmod = new("out_overlap_from_refmod", this);
      out_overlap_from_duv = new("out_overlap_from_duv", this);
      
      fiber = $sdi_create_fiber("checker", "TVM", "top");
    endfunction

    task run();
        
      overlap_output tr_duv_out_overlap,tr_modref_out_overlap;
      
      string msg;

      while(1) begin
          
        out_overlap_from_duv.get(tr_duv_out_overlap);
        out_overlap_from_refmod.get(tr_modref_out_overlap);
        if(!tr_duv_out_overlap.equal(tr_modref_out_overlap)) begin
          msg = $psprintf("received:  %s  expected  %s", 
             tr_duv_out_overlap.psprint(), tr_modref_out_overlap.psprint() );
          ovm_report_error("checker", msg);
          record_error(fiber, msg);
        end
        
      end
    endtask
endclass

