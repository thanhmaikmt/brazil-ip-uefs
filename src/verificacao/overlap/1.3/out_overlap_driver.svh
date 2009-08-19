
 
  class out_overlap_driver extends ovm_threaded_component;

    ovm_get_port #(overlap_output) out_overlap_from_duv;
    overlap_output p_out_overlap;
     
    int fiber_pcmSample;
    

    function new(string name, ovm_component parent);
      super.new(name,parent);

      out_overlap_from_duv = new("out_overlap_from_duv", this);
       
      fiber_pcmSample = $sdi_create_fiber("DriverDUV", "TVM", "top");
      
    endfunction

    task run();

      delay d = new;

      out_overlap_valid  <= 0;
      while(reset) @(posedge clk);
      while(1) begin
        out_overlap_from_duv.get(p_out_overlap);
        p_out_overlap.rec_begin(fiber_pcmSample,"out_overlap"); 
        out_overlap_pcmSample 
        out_overlap_armazenarDados  <= p_out_overlap.pcmSample;
        out_overlap_valid  <= 1;
        @(posedge clk);
        while(!out_overlap_ready) @(posedge clk);
      p_out_overlap.rec_end();
        out_overlap_valid  <= 0;
        assert(d.randomize());
        repeat(d.d) @(posedge clk);

     end
    endtask
  endclass

