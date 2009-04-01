

module tb;

  `include "trans.svh"
  `include "source.svh"
  `include "refmod_overlap.svh"
  `include "refmod_overlap_mutant.svh"
  `include "checker.svh"
 
  source sou = new("sou", null);
  refmod_overlap rem1 = new("rem1", null);
  refmod_overlap_mutant rem2 = new("rem2", null);
  checker che = new("che", null);

   
  tlm_fifo #(overlap_input) in_overlap_source_refmod1 = new("in_overlap_source_refmod1", null, 3);
  tlm_fifo #(overlap_input) in_overlap_source_refmod2 = new("in_overlap_source_refmod2", null, 3);
  

   
  tlm_fifo #(overlap_output) out_overlap_refmod1_checker = new("out_overlap_refmod1_checker", null, 3);
  tlm_fifo #(overlap_output) out_overlap_refmod2_checker = new("out_overlap_refmod2_checker", null, 3);
  

  initial begin
   
    sou.in_overlap_to_refmod.connect(in_overlap_source_refmod1.put_export);
    sou.in_overlap_to_driver.connect(in_overlap_source_refmod2.put_export);
    rem1.in_overlap_stim.connect(in_overlap_source_refmod1.get_export);
    rem2.in_overlap_stim.connect(in_overlap_source_refmod2.get_export);
     
    rem1.out_overlap_stim.connect(out_overlap_refmod1_checker.put_export);
    rem2.out_overlap_stim.connect(out_overlap_refmod2_checker.put_export);
    che.out_overlap_from_refmod.connect(out_overlap_refmod1_checker.get_export);
    che.out_overlap_from_duv.connect(out_overlap_refmod2_checker.get_export);
  
    $shm_open("waves.shm");
    run_test();
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule

