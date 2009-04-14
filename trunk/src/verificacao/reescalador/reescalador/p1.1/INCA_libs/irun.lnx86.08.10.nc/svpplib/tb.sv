module tb;

  `include "trans.svh"
  `include "pre_source.svh"
  `include "refmod_reescalador.svh"
  `include "sink.svh"
 
  pre_source pre_source_i = new("pre_source_i", null);
  refmod_reescalador refmod_reescalador_i = new("refmod_reescalador_i", null);
  sink sink_i = new("sink_i", null);

  tlm_fifo_reescalador_input in_reescalador_source_refmod = new("in_reescalador_source_refmod", null, 3);
  
  tlm_fifo_reescalador_output out_reescalador_refmod_checker = new("out_reescalador_refmod_checker", null, 3);
  

  initial begin
     
     pre_source_i.in_reescalador_to_refmod.connect(in_reescalador_source_refmod.put_export);
     refmod_reescalador_i.in_reescalador_stim.connect(in_reescalador_source_refmod.get_export);
     
     
     refmod_reescalador_i.out_reescalador_stim.connect(out_reescalador_refmod_checker.put_export);
     sink_i.out_reescalador_from_refmod.connect(out_reescalador_refmod_checker.get_export);
     
     $shm_open("waves.shm");
     run_test();
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule

