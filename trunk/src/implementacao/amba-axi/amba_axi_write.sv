/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementa��o da interface AMBA-AXI
* Descri��o do arquivo: interface AMBA-AXI
------------------------------------------------------------------------ */

/*-------------------------------------------------------------------------------
* parameter int HALF_WINDOW_SIZE = 512;
*
* fun��o utilizada na verifica��o
* function void overlap(int sequencePos,
* 						int pcm_in_1[(HALF_WINDOW_SIZE-1):0],
* 						int pcm_in_2[(HALF_WINDOW_SIZE-1):0],
*						ref int pcm_out[(HALF_WINDOW_SIZE-1):0]);
*
*
* pcm_in_1 - ultima metade da primeira seq��ncia
* pcm_in_2 - primeira metada da segunda seq��ncia
* pcm_out - sa�da
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
	
	//data and address from aac
	input [31:0] aacaddr;
	input [31:0] aacdata;
	input aacaddrvalid;
	input aacdatavalid;
	
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
	
	wire [31:0] aacaddr;
	wire [31:0] aacdata;
	wire aacaddrvalid;
	wire aacdatavalid;
	
	wire awready;
	
	wire wready;
	
	wire [3:0] bid;
	wire [1:0] bresp;
	wire bvalid;
	
	wire [3:0] awid;
	reg [31:0] awaddr;
	wire [3:0] awlen;
	wire [2:0] awsize;
	wire [1:0] awburst;
	wire [1:0] awlock;
	wire [3:0] awcache;
	wire [2:0] awprot;
	reg awvalid
	
	wire [3:0] wid;
	reg [31:0] wdata;
	wire [3:0] wstrb;
	wire wlast;
	reg wvalid;
	
	reg bready;
	
	assign awlock = 2'b00;
	
	assign awcache = 4'b0001;

	assign awprot = 3'b010;

	
	always @(posedge aclk or posedge aresetn)
	begin
		if(~aresetn)begin
			awid = 4'b0000;
			awaddr = 32'b0;
			awlen = ;//ver melhor
			awsize;
			awburst;
			awvalid = 1'b0;
			wid;
			wdata = 32'b0;
			wstrb;
			wlast;
			wvalid = 1'b0;
			bready = 1'b0;
		
		end
		else begin
			//debulha

			if(/*aguardando dados*/)begin
				if(aacaddrvalid)begin
					awaddr = aacaddr;
				end

				if(aacdatavalid)begin
					wdata = aacdata;
				end
			
			end
			
			if(/*enviando*/)begin
				
			end
		end
	end
	
endmodule