

module tb(input reset, clk,   
  output logic [1:0] in_overlap_firstSequence,
  output logic in_overlap_valid,
  input in_overlap_ready,
  output logic  [64:0] in_overlap_pcmSample,

  input  [64:0] out_overlap_pcmSample,
  input out_overlap_valid,
  output logic out_overlap_ready );

  `include "trans.svh"
  `include "source.svh"
  `include "refmod_overlap.svh"
  `include "checker.svh"
  
  `include "in_overlap_driver.svh"
  
  
  `include "out_overlap_actor.svh"
  `include "out_overlap_monitor.svh"
  

  // source, refmod, checker and fifos that connect them to one another
  source sou = new("sou", null);
  
  tlm_fifo #(overlap_input) in_overlap_source_refmod = new("in_overlap_source_refmod");
  
  refmod_overlap refmod_overlap_i = new("tb.refmod_overlap_i", null);
  
  tlm_fifo #(overlap_output) out_overlap_refmod_checker = new("out_overlap_refmod_checker");   
  
  checker che = new("che", null);

  // driver(s) and fifo(s) that connect to them
  
  tlm_fifo #(overlap_input) in_overlap_source_driver = new("in_overlap_source_driver");
  in_overlap_driver in_overlap_driver_i = new("in_overlap_driver_i", null);
  

  // monitor(s) and fifo(s) that conecto from them
  
  out_overlap_actor out_overlap_actor_i = new("out_overlap_actor_i", null);
  out_overlap_monitor out_overlap_monitor_i = new("out_overlap_monitor_i", null);
  tlm_fifo #(overlap_output) out_overlap_monitor_checker =new("out_overlap_monitor_checker");
  


  initial begin // connect the fifos
   
    // source to refmod
    
    sou.in_overlap_to_refmod.connect(in_overlap_source_refmod.put_export);
    refmod_overlap_i.in_overlap_stim.connect(in_overlap_source_refmod.get_export);
    

    // refmod to checker
    
    refmod_overlap_i.out_overlap_stim.connect(out_overlap_refmod_checker.put_export);
    che.out_overlap_from_refmod.connect(out_overlap_refmod_checker.get_export);
    

    // source to driver(s)
    
    sou.in_overlap_to_driver.connect(in_overlap_source_driver.put_export);
    in_overlap_driver_i.in_overlap_from_source.connect(in_overlap_source_driver.get_export);
    
  
    // monitor(s) to checker
    
    out_overlap_monitor_i.out_overlap_to_checker.connect(out_overlap_monitor_checker.put_export);
    che.out_overlap_from_duv.connect(out_overlap_monitor_checker.get_export);
    

    run_test();
  end

  



endmodule

