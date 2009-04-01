


  class in_overlap_monitor extends ovm_component;

    ovm_put_port #(overlap_input) in_overlap_to_duv;
    overlap_input p_in_overlap;

    covergroup cmp;
        
        coverpoint p_in_overlap.pcmSample {
            bins p[] = { 0 };
            option.at_least = 1;
        }
        
        coverpoint p_in_overlap.firstSequence {
            bins p[] = { 0 };
            option.at_least = 1;
        }
        
    endgroup

    covergroup cmc;
        
        coverpoint p_in_overlap.pcmSample {
            bins p[] = { 0 };
            option.at_least = 1;
        }
        
        coverpoint p_in_overlap.firstSequence {
            bins p[] = { 0 };
            option.at_least = 1;
        }
        
    endgroup

     
    int fiber_pcmSample;
    
    bit fiber_firstSequence;
    

    function new(string name, ovm_component parent);
      super.new(name,parent);
      in_overlap_to_duv = new("in_overlap_to_duv", this);
       
      fiber_pcmSample = $sdi_create_fiber("MonitorDUV", "TVM", "top");
      
      fiber_firstSequence = $sdi_create_fiber("MonitorDUV", "TVM", "top");
      
      cmp = new;
      cmc = new;
    endfunction


    task run();


      @(posedge clk);
      while(1) begin

        while(!(in_overlap_ready && in_overlap_valid)) @(posedge clk);
        p_in_overlap = new();
        p_in_overlap.rec_begin(fiber_pcmSamplefirstSequence,"in_overlap");
        p_in_overlap.pcmSamplefirstSequence =   in_overlap_firstSequence  in_overlap_pcmSample ;
        cmp.sample();
        cmc.sample();
        in_overlap_to_duv.put(p_in_overlap);
        @(posedge clk);
        p_in_overlap.rec_end();

      end
    endtask

  endclass

