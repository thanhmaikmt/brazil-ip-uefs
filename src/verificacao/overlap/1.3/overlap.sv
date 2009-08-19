

module overlap(input reset, clk,   
  input bit [1:0] in_overlap_clock,
  input in_overlap_valid,
  output logic in_overlap_ready,
  input bit [1:0] in_overlap_reset,
  input in_overlap_valid,
  output logic in_overlap_ready,
  input bit [1:0] in_overlap_carregar,
  input in_overlap_valid,
  output logic in_overlap_ready,
  input bit [1:0] in_overlap_acionar,
  input in_overlap_valid,
  output logic in_overlap_ready,
  input  [64:0] in_overlap_pcmSample,
  input in_overlap_valid,
  output logic in_overlap_ready,  
  output logic  [64:0] out_overlap_pcmSample,
  output logic out_overlap_valid,
  input out_overlap_ready
  output logic bit [1:0] out_overlap_armazenarDados,
  output logic out_overlap_valid,
  input out_overlap_ready);


  `include "trans.svh"
  
  
  `include "in_overlap_actor.svh"
  `include "in_overlap_monitor.svh"
  
  `include "refmod_overlap.svh"

  
  `include "out_overlap_driver.svh"
  

  // input monitor(s)
  
  in_overlap_actor in_overlap_actor_i = new ("in_overlap_actor_i", null);
  in_overlap_monitor in_overlap_monitor_i = new ("in_overlap_monitor_i", null);
  tlm_fifo #(overlap_input) in_overlap_monitor_refmod = new("in_overlap_monitor_refmod");
  

  refmod_overlap refmod_overlap_i = new("duv.refmod_(module.name)_i", null);

  // output driver(s)
  
  tlm_fifo #(overlap_output) out_overlap_refmod_driver = new("out_overlap_refmod_driver");
  out_overlap_driver out_overlap_driver_i = new("out_overlap_driver_i", null);
  

  initial begin // connect the fifos
   
     
    in_overlap_monitor_i.in_overlap_to_duv.connect(in_overlap_monitor_refmod.put_export);
    refmod_overlap_i.in_overlap_stim.connect(in_overlap_monitor_refmod.get_export);
    

     
    refmod_overlap_i.out_overlap_stim.connect(out_overlap_refmod_driver.put_export);
    out_overlap_driver_i.out_overlap_from_duv.connect(out_overlap_refmod_driver.get_export);
    

    run_test(); 
  end


endmodule

