

class out_overlap_actor extends ovm_threaded_component;

    function new(string name, ovm_component parent);
      super.new(name,parent);
    endfunction
    
    task run();
        
      delay d = new;
      
      out_overlap_ready <= 1; 
      @(posedge clk);
      while(reset) @(posedge clk);
      while(1) begin
          
          while(!out_overlap_valid) @(posedge clk);
          out_overlap_ready <= 0; 
          assert(d.randomize());
          repeat(d.d) @(posedge clk);
          out_overlap_ready <= 1; 
          @(posedge clk);
        
      end
    endtask
  endclass

AXI_cover out_overlap_cover(.clk(clk), .ready(out_overlap_ready), .valid(out_overlap_valid)); // prestar atencao
