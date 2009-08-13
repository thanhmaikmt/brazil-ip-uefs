`timescale 1ns/1ns

module teste;


`include "overlap_aac.sv"

overlap_aac overlap_instance;


initial begin
  overlap_instance = new();
  
  overlap_instance.teste();
end




endmodule