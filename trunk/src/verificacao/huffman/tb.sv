module tb;

  `include "trans.svh"
  `include "pre_source.svh"
  `include "refmod_huffman.svh"
  `include "sink.svh"
 
  pre_source pre_source_i = new("pre_source_i", null);
  refmod_huffman refmod_huffman_i = new("refmod_huffman_i", null);
  sink sink_i = new("sink_i", null);

  tlm_fifo #(huffman_input) in_huffman_source_refmod = new("in_huffman_source_refmod", null, 3);
  
  tlm_fifo #(huffman_output) out_huffman_refmod_checker = new("out_huffman_refmod_checker", null, 3);
  

  initial begin
     
     pre_source_i.in_huffman_to_refmod.connect(in_huffman_source_refmod.put_export);
     refmod_huffman_i.in_huffman_stim.connect(in_huffman_source_refmod.get_export);
     
     
     refmod_huffman_i.out_huffman_stim.connect(out_huffman_refmod_checker.put_export);
     sink_i.out_huffman_from_refmod.connect(out_huffman_refmod_checker.get_export);
     
     $shm_open("waves.shm");
     run_test();
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule

