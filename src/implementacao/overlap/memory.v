module memory(clk, save, read, in0, in1, out);
	
	parameter halfWindowSize = 512;
	parameter wordLength = 16;
	
	input clk;
	input save;
	input read;
	
	input [wordLength - 1 : 0] in0 [1023 : 0];
	input [wordLength - 1 : 0] in1 [1023 : 0];
	
	output [wordLength - 1 : 0] out [3 : 0];
	
	reg [wordLength - 1 : 0] mem0 [1023 : 0];
	reg [wordLength - 1 : 0] mem1 [1023 : 0];
	
	
	
	always @(posedge clk )
	begin 
		
		if(save) begin
			mem0 <= in0;
			mem1 <= in1;
		end
	
	end
	
endmodule