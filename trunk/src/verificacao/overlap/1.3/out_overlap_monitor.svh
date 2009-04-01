

  class out_overlap_monitor extends ovm_threaded_component;

    ovm_put_port #(overlap_output) out_overlap_to_checker;
    overlap_output tr_out_overlap;

    covergroup cm;
        
        coverpoint tr_out_overlap.pcmSample {
            bins p[] = { 0 };
            option.at_least = 1;
        }
        
    endgroup

    int fiber;

    function new(string name, ovm_component parent);
      super.new(name,parent);

      out_overlap_to_checker = new("out_overlap_to_checker", this);
      fiber = $sdi_create_fiber("Monitor", "TVM", "top");
      cm = new;
    endfunction

    task run();

      @(posedge clk);
      while(1) begin

        while(!(out_overlap_ready && out_overlap_valid)) @(posedge clk);
        tr_out_overlap = new();
        tr_out_overlap.rec_begin(fiber,"out_overlap");
        tr_out_overlap.pcmSample =   out_overlap_pcmSample ;
        cm.sample();
        out_overlap_to_checker.put(tr_out_overlap);
        @(posedge clk);
        tr_out_overlap.rec_end();

      end
    endtask

  endclass

