`timescale 1ns/1ns

module teste;


`include "overlap_aac.sv"

refmod_overlap rfmd;


initial begin
  rfmd = new();
  rfmd.run();
end




endmodule