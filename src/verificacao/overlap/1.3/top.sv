
module top;

  logic reset,clk;

   
   
  logic bit [1:0] in_overlap_clock;
  
  logic bit [1:0] in_overlap_reset;
  
  logic bit [1:0] in_overlap_carregar;
  
  logic bit [1:0] in_overlap_acionar;
  
  logic  [64:0] in_overlap_pcmSample;
  
  logic in_overlap_valid, in_overlap_ready;
  

   
   
  logic  [64:0] out_overlap_pcmSample;
  
  logic bit [1:0] out_overlap_armazenarDados;
  
  logic out_overlap_valid, out_overlap_ready;
  

  gene_clock gene_clock_i(.*);
  tb tb_i(.*);
  overlap overlap_i(.*);

  initial begin  
    $shm_open("waves.shm");
    $shm_probe(reset,clk,
               in_overlap_clock,
               in_overlap_reset,
               in_overlap_carregar,
               in_overlap_acionar,
               in_overlap_pcmSample,
               in_overlap_ready,
               in_overlap_valid,
               out_overlap_pcmSample,
               out_overlap_armazenarDados,
               out_overlap_ready,
               out_overlap_valid );
  end

  logic cov;
  initial cov = 0;
  always #100 cov = !cov;

endmodule
