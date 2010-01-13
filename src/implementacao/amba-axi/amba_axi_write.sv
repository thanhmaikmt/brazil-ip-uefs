/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação da interface AMBA-AXI
* Descrição do arquivo: interface AMBA-AXI
------------------------------------------------------------------------ */

/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;
*
* função utilizada na verificação
* function void overlap(int sequencePos,
* 						int pcm_in_1[(HALF_WINDOW_SIZE-1):0],
* 						int pcm_in_2[(HALF_WINDOW_SIZE-1):0],
*						ref int pcm_out[(HALF_WINDOW_SIZE-1):0]);
*
*
* pcm_in_1 - ultima metade da primeira seqüência
* pcm_in_2 - primeira metada da segunda seqüência
* pcm_out - saída
-------------------------------------------------------------------------------*/



module amba_axi_write(aclk, aresetn,
		awready,
		wready,
		bid, bresp, bvalid,
		
		awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid,
		wid, wdata, wstrb, wlast, wvalid,
		bready);
	
	parameter wordLength = 16;
	
	parameter busSize = 4 * wordLength;
	
	//IN
	
	input aclk, aresetn;
	
	//write address ready
	input awready;
	
	//write ready
	input wready;
	
	//response id
	input [3:0] bid;
	//response status
	input [1:0] bresp;
	//response valid
	input bvalid;
	
	//OUT
	
	//write address id
	output [3:0] awid;
	//write address
	output [31:0] awaddr;
	//burst length
	output [3:0] awlen;
	//burst size
	output [2:0] awsize;
	//burst type
	output [1:0] awburst;
	//lock type
	output [1:0] awlock;
	//cache type
	output [3:0] awcache;
	//protection type
	output [2:0] awprot;
	//write address valid
	output awvalid
	
	
	//write id
	output [3:0] wid;
	//write data
	output [31:0] wdata;
	//write strobes
	output [3:0] wstrb;
	//write last
	output wlast;
	//write valid
	output wvalid;
	
	//response valid
	output bready;
	
	
	//WIRES
	
	wire aclk, aresetn;
	
	wire awready;
	
	wire wready;
	
	wire [3:0] bid;
	wire [1:0] bresp;
	wire bvalid;
	
	wire [3:0] awid;
	wire [31:0] awaddr;
	wire [3:0] awlen;
	wire [2:0] awsize;
	wire [1:0] awburst;
	wire [1:0] awlock;
	wire [3:0] awcache;
	wire [2:0] awprot;
	wire awvalid
	
	wire [3:0] wid;
	wire [31:0] wdata;
	wire [3:0] wstrb;
	wire wlast;
	wire wvalid;
	
	wire bready;
	
	assign awlock = 2'b00;
	
	assign awcache = 4'b0001;

	assign awprot = 3'b010;
		


	
	always @(posedge clock or posedge reset)
	begin
		
		
	end
	
endmodule
