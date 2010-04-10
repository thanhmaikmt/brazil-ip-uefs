/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação da interface AMBA-AXI
* Descrição do arquivo: interface AMBA-AXI
------------------------------------------------------------------------ */

/*-------------------------------------------------------------------------------
*
*
*
-------------------------------------------------------------------------------*/



module amba_axi_write(aclk, aresetn,
		aacaddr, aacdata, aacaddrvalid, aacdatavalid,
		awready,
		wready,
		bid, bresp, bvalid,
		
		awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid,
		wid, wdata, wstrb, wlast, wvalid,
		bready);
	
	parameter IDLE = 2'b00; 		//aguardando aac
	parameter REQUEST = 2'b01;		//enviando endereço
	parameter SENDING = 2'b11;		//enviando dado
	parameter WAITING_AMBA = 2'b10; //aguardando resposta do amba
	
	
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
	output awvalid;
	
	
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
	reg awvalid;
	
	wire [3:0] wid;
	reg [31:0] wdata;
	wire [3:0] wstrb;
	wire wlast;
	reg wvalid;
	
	reg bready;
	
	reg [1:0] statemachine; 
	
	
	
	assign awlock = 2'b00;
	assign awcache = 4'b0001;
	assign awprot = 3'b010;
	
	//definir melhor estes valores
	assign awid = 4'b0000;
	assign awsize = 2;
	assign awlen = 1;
	assign awburst= 2'b00;
	assign wid = 4'b0001;
	assign wstrb = 0; //?
	
	assign wlast = 1;//alterado somente se awlen > 1
	
	always @(posedge aclk or negedge aresetn)
	begin
		if(~aresetn)begin
			awaddr = 32'b0;
			awvalid = 1'b0;
			wdata = 32'b0;

			wvalid = 1'b0;
			bready = 1'b0;
			
			statemachine = IDLE;
		end
		else begin
			//debulha
			
			//aguardando
			if(statemachine == IDLE)begin
				if(aacaddrvalid)begin
					awaddr = aacaddr;
					awvalid = 1'b1; //endereço válido
					
					statemachine = REQUEST;
				end
			end
			
			//requisitando envio de dados
			if(statemachine == REQUEST)begin
				if(awready)begin
					awvalid = 1'b0;
				end
				if(aacdatavalid && ~awvalid)begin
					wdata = aacdata;
					wvalid = 1'b1;
					
					statemachine = SENDING;
				end
			end
			
			//enviando dado
			if(statemachine == SENDING)begin
				if(wready)begin
					wvalid = 1'b0;
					bready = 1'b1;
					
					statemachine = WAITING_AMBA;
				end
			end
						
			if(statemachine == WAITING_AMBA)begin
				if(bvalid)begin
					wvalid = 1'b0;
					bready = 1'b0;
					
					statemachine = IDLE;
				end
			end
			
		end
	end
	
endmodule
