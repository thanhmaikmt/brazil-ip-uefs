

class in_overlap_actor extends ovm_component;

    function new(string name, ovm_component parent);
      super.new(name,parent);
    endfunction
    
    task run();
        
      delay d = new;
      
      in_overlap_ready <= 1; 
      @(posedge clk);
      while(reset) @(posedge clk);
      while(1) begin
          
          while(!in_overlap_valid) @(posedge clk);
          in_overlap_ready <= 0; 
          assert(d.randomize());
          repeat(d.d) @(posedge clk);
          in_overlap_ready <= 1; 
          @(posedge clk);
        
      end
    endtask
  endclass

AXI_cover in_overlap_cover(.clk(clk), .ready(in_overlap_ready), .valid(in_overlap_valid));
