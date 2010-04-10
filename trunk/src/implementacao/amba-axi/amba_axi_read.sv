/*------------------------------------------------------------------------
* Projeto Brazil-IP UEFS
* Decodificador MPEG-2 AAC                     Implementação da interface AMBA-AXI
* Descrição do arquivo: interface AMBA-AXI
------------------------------------------------------------------------ */

/*-------------------------------------------------------------------------------
*
*
*
------------------------------------------------------*/



module amba_axi_read(aclk, aresetn,
		aacaddr, aacaddrvalid,
		arready,
		rid, rdata, rresp, rlast, rvalid,
		
		aacdata, aacdatavalid,
		arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arvalid,
		rready);
	
	
	parameter IDLE = 2'b00;			//aguardando aac
	parameter REQUEST = 2'b01;		//enviando endereço
	parameter WAITING_AMBA = 2'b11;	//aguardando resposta do amba
	parameter RECEIVING = 2'b10;	//recebendo dado
	

	//IN
	
	input aclk, aresetn;
	
	//address from aac
	input [31:0] aacaddr;
	input aacaddrvalid;
	
	//read address ready
	input arready;
	
	//real id
	input [3:0] rid;
	
	//read data
	input [31:0] rdata;
	
	//read response
	input [1:0] rresp;
	
	//read last
	input rlast;
	
	//read valid
	input rvalid;
	
	
	//OUT
	
	//data to aac
	output [31:0] aacdata;
	output aacdatavalid;
	
	//read address id
	output [3:0] arid;
	//read address
	output [31:0] araddr;
	//burst length
	output [3:0] arlen;
	//burst size
	output [2:0] arsize;
	//burst type
	output [1:0] arburst;
	//lock type
	output [1:0] arlock;
	//cache type
	output [3:0] arcache;
	//protection type
	output [2:0] arprot;
	//write address valid
	output arvalid;
	
	output rready;

	//WIRES
	
	wire aclk, aresetn;
	
	wire [31:0] aacaddr;
	reg [31:0] aacdata;
	wire aacaddrvalid;
	reg aacdatavalid;
	
	wire arready;
	
	wire wready;
	
	wire [3:0] arid;
	reg [31:0] araddr;
	wire [3:0] arlen;
	wire [2:0] arsize;
	wire [1:0] arburst;
	wire [1:0] awlock;
	wire [3:0] awcache;
	wire [2:0] awprot;
	reg arvalid;
	
	wire [3:0] rid;
	wire [31:0] rdata;
	wire [3:0] rstrb;
	wire rlast;
	wire rvalid;
	
	reg rready;
	
	reg [1:0] statemachine;
	
	 

	assign arlock = 2'b00;
	assign arcache = 4'b0001;
	assign arprot = 3'b010;

	//definir melhor estes valores
	assign arid = 4'b0000;
	assign arsize = 2;
	assign arlen = 1;
	assign arburst= 2'b00;

	
	always @(posedge aclk or negedge aresetn)
	begin
		if(~aresetn)begin
			arvalid = 1'b0;
			araddr = 32'b0;
			rready = 1'b0;
			
			statemachine = IDLE;
		end
		else begin
			//debulha
			
			//aguardando
			if(statemachine == IDLE)begin
				if(aacaddrvalid)begin
					araddr = aacaddr;
					arvalid = 1'b1; //endereço válido
					
					statemachine = REQUEST;
					
					
					//verificar qd eh melhor resetar estes valores
					aacdata = 32'b0;
					aacdatavalid = 1'b0;
				end
			end
			
			//requisitando dados
			if(statemachine == REQUEST)begin
				if(arready)begin
					arvalid = 1'b0;
					
					rready = 1'b1;
					statemachine = WAITING_AMBA;
				end
			end
			
			
			//aguardando resposta do amba_axi
			if(statemachine == WAITING_AMBA)begin
				if(rvalid)begin
					statemachine = RECEIVING;
				end
			end
			
			
			
			/*recebendo*/
			if(statemachine == RECEIVING) begin
				aacdata = rdata;
				aacdatavalid = 1'b1;
				
				/*verificar qts ciclos ira manter o dado lido no barramento
				* caso seja maior que um acrescentar contador
				*/
				statemachine = IDLE;

				//reset
				arvalid = 1'b0;
				araddr = 32'b0;
				rready = 1'b0;
			end
		end
	end
	
endmodule
