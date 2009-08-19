
class source extends ovm_component;

   
    ovm_put_port #(overlap_input) in_overlap_to_refmod;
    ovm_put_port #(overlap_input) in_overlap_to_driver;
 
    function new(string name, ovm_component parent);
      super.new(name,parent);
      
      in_overlap_to_refmod = new("in_overlap_to_refmod", this);
      in_overlap_to_driver = new("in_overlap_to_driver", this);
    
    endfunction
    task run();
        
        overlap_input tr_in_overlap;
      
        int file = $fopen("tr.sti", "r");
        while(1) begin 
            
            tr_in_overlap = new();
            if(!tr_in_overlap.read(file))
               assert(tr_in_overlap.randomize());
            in_overlap_to_driver.put(tr_in_overlap);
            in_overlap_to_refmod.put(tr_in_overlap);
          
            #1;
        end
    endtask
    
endclass

