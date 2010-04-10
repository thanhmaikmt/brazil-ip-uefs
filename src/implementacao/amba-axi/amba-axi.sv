module amba_axi(aclk, aresetn,
		arready,
		rid, rdata, rresp, rlast, rvalid,
		
		
		awready,
		wready,
		bid, bresp, bvalid,
		
		
		
		arid, araddr, arlen, arsize, arburst, arlock, arcache, arprot, arvalid,
		rready,
		
		awid, awaddr, awlen, awsize, awburst, awlock, awcache, awprot, awvalid,
		wid, wdata, wstrb, wlast, wvalid,
		bready);
	

	//IN
	
	input aclk, aresetn;
		
	//read address ready
	output arready;
	
	//real id
	output [3:0] rid;
	
	//read data
	output [31:0] rdata;
	
	//read response
	output [1:0] rresp;
	
	//read last
	output rlast;
	
	//read valid
	output rvalid;
	
	
	//OUT

	//read address id
	input [3:0] arid;
	//read address
	input [31:0] araddr;
	//burst length
	input [3:0] arlen;
	//burst size
	input [2:0] arsize;
	//burst type
	input [1:0] arburst;
	//lock type
	input [1:0] arlock;
	//cache type
	input [3:0] arcache;
	//protection type
	input [2:0] arprot;
	//write address valid
	input arvalid;
	
	input rready;


	
	
	//write address ready
	output awready;
	
	//write ready
	output wready;
	
	//response id
	output [3:0] bid;
	//response status
	output [1:0] bresp;
	//response valid
	output bvalid;
	
	//OUT
	
	//write address id
	input [3:0] awid;
	//write address
	input [31:0] awaddr;
	//burst length
	input [3:0] awlen;
	//burst size
	input [2:0] awsize;
	//burst type
	input [1:0] awburst;
	//lock type
	input [1:0] awlock;
	//cache type
	input [3:0] awcache;
	//protection type
	input [2:0] awprot;
	//write address valid
	input awvalid;
	
	
	//write id
	input [3:0] wid;
	//write data
	input [31:0] wdata;
	//write strobes
	input [3:0] wstrb;
	//write last
	input wlast;
	//write valid
	input wvalid;
	
	//response valid
	input bready;
	
	
	
	
	
	//WIRES

	wire [3:0] arid;
	reg [31:0] araddr;
	wire [3:0] arlen;
	wire [2:0] arsize;
	wire [1:0] arburst;
	wire [1:0] arlock;
	wire [3:0] arcache;
	wire [2:0] arprot;
	reg arvalid;
	
	wire [3:0] rid;
	wire [31:0] rdata;
	wire [3:0] rstrb;
	wire rlast;
	wire rvalid;
	
	reg rready;
	
	
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
	
	 


	always @(posedge aclk or negedge aresetn)
	begin
		if(~aresetn)begin
		
		end
	end
	
endmodule
