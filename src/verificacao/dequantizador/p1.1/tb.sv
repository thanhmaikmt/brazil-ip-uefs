module tb;

  `include "trans.svh"
  `include "pre_source.svh"
  `include "refmod_dequantizador.svh"
  `include "sink.svh"
 
  pre_source pre_source_i = new("pre_source_i", null);
  refmod_dequantizador refmod_dequantizador_i = new("refmod_dequantizador_i", null);
  sink sink_i = new("sink_i", null);

  tlm_fifo #(dequantizador_input) in_dequant_source_refmod = new("in_dequant_source_refmod", null, 3);
  
  tlm_fifo #(dequantizador_output) out_dequant_refmod_checker = new("out_dequant_refmod_checker", null, 3);
  

  initial begin
     
     pre_source_i.in_dequant_to_refmod.connect(in_dequant_source_refmod.put_export);
     refmod_dequantizador_i.in_dequant_stim.connect(in_dequant_source_refmod.get_export);
     
     
     refmod_dequantizador_i.out_dequant_stim.connect(out_dequant_refmod_checker.put_export);
     sink_i.out_dequant_from_refmod.connect(out_dequant_refmod_checker.get_export);
     
     $shm_open("waves.shm");
     run_test();
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule

