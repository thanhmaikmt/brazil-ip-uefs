module tb;

  `include "trans.svh"
  `include "pre_source.svh"
  `include "refmod_overlap.svh"
  `include "sink.svh"
 
  pre_source pre_source_i = new("pre_source_i", null);
  refmod_overlap refmod_overlap_i = new("refmod_overlap_i", null);
  sink sink_i = new("sink_i", null);

  tlm_fifo #(overlap_input) in_overlap_source_refmod = new("in_overlap_source_refmod", null, 3);
  
  tlm_fifo #(overlap_output) out_overlap_refmod_checker = new("out_overlap_refmod_checker", null, 3);
  

  initial begin
     
     pre_source_i.in_overlap_to_refmod.connect(in_overlap_source_refmod.put_export);
     refmod_overlap_i.in_overlap_stim.connect(in_overlap_source_refmod.get_export);
     
     
     refmod_overlap_i.out_overlap_stim.connect(out_overlap_refmod_checker.put_export);
     sink_i.out_overlap_from_refmod.connect(out_overlap_refmod_checker.get_export);
     
     $shm_open("waves.shm");
     run_test();
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule

