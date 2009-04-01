module tb;

  `include "trans.svh"
  `include "pre_source.svh"
  `include "refmod_decodificadorAAC.svh"
  `include "sink.svh"
 
  pre_source pre_source_i = new("pre_source_i", null);
  refmod_decodificadorAAC refmod_decodificadorAAC_i = new("refmod_decodificadorAAC_i", null);
  sink sink_i = new("sink_i", null);

  tlm_fifo #(stream) entrada_source_refmod = new("entrada_source_refmod", null, 3);
  
  tlm_fifo #(amostra) amostra_refmod_checker = new("amostra_refmod_checker", null, 3);
  

  initial begin
     
     pre_source_i.entrada_to_refmod.connect(entrada_source_refmod.put_export);
     refmod_decodificadorAAC_i.entrada_stim.connect(entrada_source_refmod.get_export);
     
     
     refmod_decodificadorAAC_i.amostra_stim.connect(amostra_refmod_checker.put_export);
     sink_i.amostra_from_refmod.connect(amostra_refmod_checker.get_export);
     
     $shm_open("waves.shm");
     run_test();
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule

