


  class in_overlap_driver extends ovm_threaded_component;

    ovm_get_port #(overlap_input) in_overlap_from_source;
    overlap_input p_in_overlap;
     
    int fiber_pcmSample;
    
    bit fiber_firstSequence;
    

    function new(string name, ovm_component parent);
      super.new(name,parent);

      in_overlap_from_source = new("in_overlap_from_source", this);
       
      fiber_pcmSample = $sdi_create_fiber("Driver", "TVM", "top");
      
      fiber_firstSequence = $sdi_create_fiber("Driver", "TVM", "top");
      
    endfunction

    task run();

      delay d = new;

      in_overlap_valid <= 0;
      @(posedge clk);
      while(reset) @(posedge clk);
      while(1) begin

        in_overlap_from_source.get(p_in_overlap);
        //p_in_overlap.rec_begin(fiber_pcmSamplefirstSequence,"in_overlap");  
        p_in_overlap.rec_begin(fiber_pcmSample, "in_overlap");  
        p_in_overlap.rec_begin(fiber_firstSequence,"in_overlap");  

	 //corrigindo o bug
          in_overlap_firstSequence  <= p_in_overlap.firstSequence;

          in_overlap_pcmSample  <= p_in_overlap.pcmSample;
          in_overlap_valid <= 1;
          @(posedge clk);
          while(!in_overlap_ready) @(posedge clk);
        p_in_overlap.rec_end();
          in_overlap_valid  <= 0;
          assert(d.randomize());
          repeat(d.d) @(posedge clk);
      end
    endtask
  endclass

