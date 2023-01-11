
`timescale 1 ns / 1 ps
`default_nettype none
	module mmiodev_top #
	(
		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_ID_WIDTH	= 1,
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 12,
		parameter integer C_S_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_S_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_S_AXI_WUSER_WIDTH	= 0,
		parameter integer C_S_AXI_RUSER_WIDTH	= 0,
		parameter integer C_S_AXI_BUSER_WIDTH	= 0,

		parameter  C_M_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M_AXI_BURST_LEN	= 16,
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		(* X_INTERFACE_PARAMETER = "SENSITIVITY EDGE_RISING, PortWidth 1" *)
		(* X_INTERFACE_INFO = "xilinx.com:signal:interrupt:1.0 interrupt INTERRUPT" *)
	    output wire interrupt,
	
		// Ports of Axi Slave Bus Interface S_AXI
		input wire  axi_aclk,
		input wire  axi_aresetn,
		input wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_AWID,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		input wire [7 : 0] S_AXI_AWLEN,
		input wire [2 : 0] S_AXI_AWSIZE,
		input wire [1 : 0] S_AXI_AWBURST,
		input wire  S_AXI_AWLOCK,
		input wire [3 : 0] S_AXI_AWCACHE,
		input wire [2 : 0] S_AXI_AWPROT,
		input wire [3 : 0] S_AXI_AWQOS,
		input wire [3 : 0] S_AXI_AWREGION,
		input wire [C_S_AXI_AWUSER_WIDTH-1 : 0] S_AXI_AWUSER,
		input wire  S_AXI_AWVALID,
		output wire  S_AXI_AWREADY,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		input wire  S_AXI_WLAST,
		input wire [C_S_AXI_WUSER_WIDTH-1 : 0] S_AXI_WUSER,
		input wire  S_AXI_WVALID,
		output wire  S_AXI_WREADY,
		output wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_BID,
		output wire [1 : 0] S_AXI_BRESP,
		output wire [C_S_AXI_BUSER_WIDTH-1 : 0] S_AXI_BUSER,
		output wire  S_AXI_BVALID,
		input wire  S_AXI_BREADY,
		input wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_ARID,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		input wire [7 : 0] S_AXI_ARLEN,
		input wire [2 : 0] S_AXI_ARSIZE,
		input wire [1 : 0] S_AXI_ARBURST,
		input wire  S_AXI_ARLOCK,
		input wire [3 : 0] S_AXI_ARCACHE,
		input wire [2 : 0] S_AXI_ARPROT,
		input wire [3 : 0] S_AXI_ARQOS,
		input wire [3 : 0] S_AXI_ARREGION,
		input wire [C_S_AXI_ARUSER_WIDTH-1 : 0] S_AXI_ARUSER,
		input wire  S_AXI_ARVALID,
		output wire  S_AXI_ARREADY,
		output wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_RID,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		output wire [1 : 0] S_AXI_RRESP,
		output wire  S_AXI_RLAST,
		output wire [C_S_AXI_RUSER_WIDTH-1 : 0] S_AXI_RUSER,
		output wire  S_AXI_RVALID,
		input wire  S_AXI_RREADY,


		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		output wire [7 : 0] M_AXI_AWLEN,
		output wire [2 : 0] M_AXI_AWSIZE,
		output wire [1 : 0] M_AXI_AWBURST,
		output wire  M_AXI_AWLOCK,
		output wire [3 : 0] M_AXI_AWCACHE,
		output wire [2 : 0] M_AXI_AWPROT,
		output wire [3 : 0] M_AXI_AWQOS,
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
		output wire  M_AXI_AWVALID,
		input wire  M_AXI_AWREADY,
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		output wire  M_AXI_WLAST,
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
		output wire  M_AXI_WVALID,
		input wire  M_AXI_WREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		input wire [1 : 0] M_AXI_BRESP,
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
		input wire  M_AXI_BVALID,
		output wire  M_AXI_BREADY,
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		output wire [7 : 0] M_AXI_ARLEN,
		output wire [2 : 0] M_AXI_ARSIZE,
		output wire [1 : 0] M_AXI_ARBURST,
		output wire  M_AXI_ARLOCK,
		output wire [3 : 0] M_AXI_ARCACHE,
		output wire [2 : 0] M_AXI_ARPROT,
		output wire [3 : 0] M_AXI_ARQOS,
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
		output wire  M_AXI_ARVALID,
		input wire  M_AXI_ARREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		input wire [1 : 0] M_AXI_RRESP,
		input wire  M_AXI_RLAST,
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		input wire  M_AXI_RVALID,
		output wire  M_AXI_RREADY
	);



	wire [31:0] Queue_ReadAddr;
	wire [31:0] VQ_READY;
	wire [31:0] VQ_DescLow;
	wire [31:0] VQ_DriverLow;
	wire [31:0] VQ_DeviceLow;
	wire DevReq;

	blkporcessor # ( 
		.C_M_TARGET_SLAVE_BASE_ADDR(C_M_AXI_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_BURST_LEN(C_M_AXI_BURST_LEN),
		.C_M_AXI_ID_WIDTH(C_M_AXI_ID_WIDTH),
		.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
		.C_M_AXI_AWUSER_WIDTH(C_M_AXI_AWUSER_WIDTH),
		.C_M_AXI_ARUSER_WIDTH(C_M_AXI_ARUSER_WIDTH),
		.C_M_AXI_WUSER_WIDTH(C_M_AXI_WUSER_WIDTH),
		.C_M_AXI_RUSER_WIDTH(C_M_AXI_RUSER_WIDTH),
		.C_M_AXI_BUSER_WIDTH(C_M_AXI_BUSER_WIDTH),
		.P_QueueNumMax(P_QueueNumMax)
	) blkprocesser_inst (
	    .interrupt(interrupt),
		.M_AXI_ACLK(axi_aclk),
		.M_AXI_ARESETN(axi_aresetn),
		.M_AXI_AWID(M_AXI_AWID),
		.M_AXI_AWADDR(M_AXI_AWADDR),
		.M_AXI_AWLEN(M_AXI_AWLEN),
		.M_AXI_AWSIZE(M_AXI_AWSIZE),
		.M_AXI_AWBURST(M_AXI_AWBURST),
		.M_AXI_AWLOCK(M_AXI_AWLOCK),
		.M_AXI_AWCACHE(M_AXI_AWCACHE),
		.M_AXI_AWPROT(M_AXI_AWPROT),
		.M_AXI_AWQOS(M_AXI_AWQOS),
		.M_AXI_AWUSER(M_AXI_AWUSER),
		.M_AXI_AWVALID(M_AXI_AWVALID),
		.M_AXI_AWREADY(M_AXI_AWREADY),
		.M_AXI_WDATA(M_AXI_WDATA),
		.M_AXI_WSTRB(M_AXI_WSTRB),
		.M_AXI_WLAST(M_AXI_WLAST),
		.M_AXI_WUSER(M_AXI_WUSER),
		.M_AXI_WVALID(M_AXI_WVALID),
		.M_AXI_WREADY(M_AXI_WREADY),
		.M_AXI_BID(M_AXI_BID),
		.M_AXI_BRESP(M_AXI_BRESP),
		.M_AXI_BUSER(M_AXI_BUSER),
		.M_AXI_BVALID(M_AXI_BVALID),
		.M_AXI_BREADY(M_AXI_BREADY),
		.M_AXI_ARID(M_AXI_ARID),
		.M_AXI_ARADDR(M_AXI_ARADDR),
		.M_AXI_ARLEN(M_AXI_ARLEN),
		.M_AXI_ARSIZE(M_AXI_ARSIZE),
		.M_AXI_ARBURST(M_AXI_ARBURST),
		.M_AXI_ARLOCK(M_AXI_ARLOCK),
		.M_AXI_ARCACHE(M_AXI_ARCACHE),
		.M_AXI_ARPROT(M_AXI_ARPROT),
		.M_AXI_ARQOS(M_AXI_ARQOS),
		.M_AXI_ARUSER(M_AXI_ARUSER),
		.M_AXI_ARVALID(M_AXI_ARVALID),
		.M_AXI_ARREADY(M_AXI_ARREADY),
		.M_AXI_RID(M_AXI_RID),
		.M_AXI_RDATA(M_AXI_RDATA),
		.M_AXI_RRESP(M_AXI_RRESP),
		.M_AXI_RLAST(M_AXI_RLAST),
		.M_AXI_RUSER(M_AXI_RUSER),
		.M_AXI_RVALID(M_AXI_RVALID),
		.M_AXI_RREADY(M_AXI_RREADY),

		.Queue_ReadAddr(Queue_ReadAddr),
		.VQ_READY(VQ_READY),
		.VQ_DescLow(VQ_DescLow),
		.VQ_DriverLow(VQ_DriverLow),
		.VQ_DeviceLow(VQ_DeviceLow),
		.DevReq(DevReq)
	);

	// AXI4FULL signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg [C_S_AXI_BUSER_WIDTH-1 : 0] 	axi_buser;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rlast;
	reg [C_S_AXI_RUSER_WIDTH-1 : 0] 	axi_ruser;
	reg  	axi_rvalid;
	// aw_wrap_en determines wrap boundary and enables wrapping
	wire aw_wrap_en;
	// ar_wrap_en determines wrap boundary and enables wrapping
	wire ar_wrap_en;
	// aw_wrap_size is the size of the write transfer, the
	// write address wraps to a lower address if upper address
	// limit is reached
	wire [31:0]  aw_wrap_size ; 
	// ar_wrap_size is the size of the read transfer, the
	// read address wraps to a lower address if upper address
	// limit is reached
	wire [31:0]  ar_wrap_size ; 
	// The axi_awv_awr_flag flag marks the presence of write address valid
	reg axi_awv_awr_flag;
	//The axi_arv_arr_flag flag marks the presence of read address valid
	reg axi_arv_arr_flag; 
	// The axi_awlen_cntr internal write address counter to keep track of beats in a burst transaction
	reg [7:0] axi_awlen_cntr;
	//The axi_arlen_cntr internal read address counter to keep track of beats in a burst transaction
	reg [7:0] axi_arlen_cntr;
	reg [1:0] axi_arburst;
	reg [1:0] axi_awburst;
	reg [7:0] axi_arlen;
	reg [7:0] axi_awlen;
	//local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	//ADDR_LSB is used for addressing 32/64 bit registers/memories
	//ADDR_LSB = 2 for 32 bits (n downto 2) 
	//ADDR_LSB = 3 for 42 bits (n downto 3)

	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32)+ 1;
	localparam integer OPT_MEM_ADDR_BITS = 3;
	localparam integer USER_NUM_MEM = 1;
	//----------------------------------------------
	//-- Signals for user logic memory space example
	//------------------------------------------------
	wire [OPT_MEM_ADDR_BITS:0] mem_address;
	wire [USER_NUM_MEM-1:0] mem_select;
	reg [C_S_AXI_DATA_WIDTH-1:0] mem_data_out[0 : USER_NUM_MEM-1];

	genvar i;
	genvar j;
	genvar mem_byte_index;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BUSER	= axi_buser;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RLAST	= axi_rlast;
	assign S_AXI_RUSER	= axi_ruser;
	assign S_AXI_RVALID	= axi_rvalid;
	assign S_AXI_BID = S_AXI_AWID;
	assign S_AXI_RID = S_AXI_ARID;
	assign  aw_wrap_size = (C_S_AXI_DATA_WIDTH/8 * (axi_awlen)); 
	assign  ar_wrap_size = (C_S_AXI_DATA_WIDTH/8 * (axi_arlen)); 
	assign  aw_wrap_en = ((axi_awaddr & aw_wrap_size) == aw_wrap_size)? 1'b1: 1'b0;
	assign  ar_wrap_en = ((axi_araddr & ar_wrap_size) == ar_wrap_size)? 1'b1: 1'b0;

	// Implement axi_awready generation

	// axi_awready is asserted for one axi_aclk clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      axi_awv_awr_flag <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && ~axi_awv_awr_flag && ~axi_arv_arr_flag)
	        begin
	          // slave is ready to accept an address and
	          // associated control signals
	          axi_awready <= 1'b1;
	          axi_awv_awr_flag  <= 1'b1; 
	          // used for generation of bresp() and bvalid
	        end
	      else if (S_AXI_WLAST && axi_wready)          
	      // preparing to accept next address after current write burst tx completion
	        begin
	          axi_awv_awr_flag  <= 1'b0;
	        end
	      else        
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       
	// Implement axi_awaddr latching

	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	      axi_awlen_cntr <= 0;
	      axi_awburst <= 0;
	      axi_awlen <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && ~axi_awv_awr_flag)
	        begin
	          // address latching 
	          axi_awaddr <= S_AXI_AWADDR[C_S_AXI_ADDR_WIDTH - 1:0];  
	           axi_awburst <= S_AXI_AWBURST; 
	           axi_awlen <= S_AXI_AWLEN;     
	          // start address of transfer
	          axi_awlen_cntr <= 0;
	        end   
	      else if((axi_awlen_cntr <= axi_awlen) && axi_wready && S_AXI_WVALID)        
	        begin

	          axi_awlen_cntr <= axi_awlen_cntr + 1;

	          case (axi_awburst)
	            2'b00: // fixed burst
	            // The write address for all the beats in the transaction are fixed
	              begin
	                axi_awaddr <= axi_awaddr;          
	                //for awsize = 4 bytes (010)
	              end   
	            2'b01: //incremental burst
	            // The write address for all the beats in the transaction are increments by awsize
	              begin
	                axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1;
	                //awaddr aligned to 4 byte boundary
	                axi_awaddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};   
	                //for awsize = 4 bytes (010)
	              end   
	            2'b10: //Wrapping burst
	            // The write address wraps when the address reaches wrap boundary 
	              if (aw_wrap_en)
	                begin
	                  axi_awaddr <= (axi_awaddr - aw_wrap_size); 
	                end
	              else 
	                begin
	                  axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1;
	                  axi_awaddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}}; 
	                end                      
	            default: //reserved (incremental burst for example)
	              begin
	                axi_awaddr <= axi_awaddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1;
	                //for awsize = 4 bytes (010)
	              end
	          endcase              
	        end
	    end 
	end       
	// Implement axi_wready generation

	// axi_wready is asserted for one axi_aclk clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if ( ~axi_wready && S_AXI_WVALID && axi_awv_awr_flag)
	        begin
	          // slave can accept the write data
	          axi_wready <= 1'b1;
	        end
	      //else if (~axi_awv_awr_flag)
	      else if (S_AXI_WLAST && axi_wready)
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       
	// Implement write response logic generation

	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_bvalid <= 0;
	      axi_bresp <= 2'b0;
	      axi_buser <= 0;
	    end 
	  else
	    begin    
	      if (axi_awv_awr_flag && axi_wready && S_AXI_WVALID && ~axi_bvalid && S_AXI_WLAST )
	        begin
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; 
	          // 'OKAY' response 
	        end                   
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	          //check if bready is asserted while bvalid is high) 
	          //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	 end   
	// Implement axi_arready generation

	// axi_arready is asserted for one axi_aclk clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_arv_arr_flag <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID && ~axi_awv_awr_flag && ~axi_arv_arr_flag)
	        begin
	          axi_arready <= 1'b1;
	          axi_arv_arr_flag <= 1'b1;
	        end
	      else if (axi_rvalid && S_AXI_RREADY && axi_arlen_cntr == axi_arlen)
	      // preparing to accept next address after current read completion
	        begin
	          axi_arv_arr_flag  <= 1'b0;
	        end
	      else        
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       
	// Implement axi_araddr latching

	//This process is used to latch the address when both 
	//S_AXI_ARVALID and S_AXI_RVALID are valid. 
	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_araddr <= 0;
	      axi_arlen_cntr <= 0;
	      axi_arburst <= 0;
	      axi_arlen <= 0;
	      axi_rlast <= 1'b0;
	      axi_ruser <= 0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID && ~axi_arv_arr_flag)
	        begin
	          // address latching 
	          axi_araddr <= S_AXI_ARADDR[C_S_AXI_ADDR_WIDTH - 1:0]; 
	          axi_arburst <= S_AXI_ARBURST; 
	          axi_arlen <= S_AXI_ARLEN;     
	          // start address of transfer
	          axi_arlen_cntr <= 0;
	          axi_rlast <= 1'b0;
	        end   
	      else if((axi_arlen_cntr <= axi_arlen) && axi_rvalid && S_AXI_RREADY)        
	        begin
	         
	          axi_arlen_cntr <= axi_arlen_cntr + 1;
	          axi_rlast <= 1'b0;
	        
	          case (axi_arburst)
	            2'b00: // fixed burst
	             // The read address for all the beats in the transaction are fixed
	              begin
	                axi_araddr       <= axi_araddr;        
	                //for arsize = 4 bytes (010)
	              end   
	            2'b01: //incremental burst
	            // The read address for all the beats in the transaction are increments by awsize
	              begin
	                axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1; 
	                //araddr aligned to 4 byte boundary
	                axi_araddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};   
	                //for awsize = 4 bytes (010)
	              end   
	            2'b10: //Wrapping burst
	            // The read address wraps when the address reaches wrap boundary 
	              if (ar_wrap_en) 
	                begin
	                  axi_araddr <= (axi_araddr - ar_wrap_size); 
	                end
	              else 
	                begin
	                axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] <= axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB] + 1; 
	                //araddr aligned to 4 byte boundary
	                axi_araddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};   
	                end                      
	            default: //reserved (incremental burst for example)
	              begin
	                axi_araddr <= axi_araddr[C_S_AXI_ADDR_WIDTH - 1:ADDR_LSB]+1;
	                //for arsize = 4 bytes (010)
	              end
	          endcase              
	        end
	      else if((axi_arlen_cntr == axi_arlen) && ~axi_rlast && axi_arv_arr_flag )   
	        begin
	          axi_rlast <= 1'b1;
	        end          
	      else if (S_AXI_RREADY)   
	        begin
	          axi_rlast <= 1'b0;
	        end          
	    end 
	end       
	// Implement axi_arvalid generation

	// axi_rvalid is asserted for one axi_aclk clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  

	always @( posedge axi_aclk )
	begin
	  if ( axi_aresetn == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arv_arr_flag && ~axi_rvalid)
	        begin
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; 
	          // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          axi_rvalid <= 1'b0;
	        end            
	    end
	end    

	wire mem_wren;
	assign mem_wren = axi_wready && S_AXI_WVALID ;

	localparam P_MagicValue = 32'h74726976;
	localparam P_Version = 32'h2;
	localparam P_DeviceID = 32'h2;//BlockDevice
	localparam P_VendorID = 32'hff001af4;//Anything is fine

	localparam P_VirtQueueNum = 32'h1;//Blkdev:1 Networdev:2
	localparam P_QueueNumMax = 32'h10;//Virtuqueue Num

	localparam P_SECTORNUM = 64'h4;//x512byte

	localparam B_DEVSATUS_ACK		= 0;
	localparam B_DEVSATUS_DRIVER	= 1;
	localparam B_DEVSATUS_DRIVEROK	= 2;
	localparam B_DEVSATUS_FEATURESOK= 3;
	localparam B_DEVSATUS_DEVNEEDRST= 6;
	localparam B_DEVSATUS_FAILED	= 7;

	localparam S_RST = 2'd0;
	localparam S_SETUP_BASE = 2'd1;
	localparam S_SETUP_DRIVER = 2'd2;
	localparam S_IDLE = 2'd3;
	
	reg [1:0] state;

	reg [63:0] DeviceFeatures = (1 << 32) | (1 << 33);	//VIRTIO_F_ACCESS_PLATFORM(33), VIRTIO_F_VERSION_1 (32), VIRTIO_BLK_F_RO (5)
	reg [31:0] DeviceFeaturesSel = 0;
	reg [63:0] DriverFeatures = 0;
	reg [31:0] DriverFeaturesSel = 0;
	reg [31:0] QueueSel = 0;
	reg [31:0] QueueNum = 0;
	reg [31:0] InterruptAck = 0;
	reg [31:0] DeviceStatus = 0;
	/* 	[0] ACK					Device->OS
		[1] Driver 				O->D
		[2] DRIVER_OK			O->D
		[3] FEATURES_OK			D->O
		[6] DEVICE_NEEDS_RESET	a
		[7] FAILED				
	*/

	reg [31:0] QueueNotify = 0;
	reg [31:0] InterruptStatus = 0;

	reg [31:0] DeviceStatus_tmp;
	reg DeviceStatus_tmp_en;

	reg  [31:0] Queue[0:(P_VirtQueueNum * 7) -1];
	/*	0 : Ready
		1 : Descriptor Low
		2 : Descriptor High
		3 : Driver(Avail) Low
		4 : Driver(Avail) High
		5 : Device(Used) Low
		6 : Device(Used) High
	*/
	assign VQ_READY = Queue[Queue_ReadAddr*7];
	assign VQ_DescLow = Queue[Queue_ReadAddr*7 + 1];
	assign VQ_DriverLow = Queue[Queue_ReadAddr*7 + 3];
	assign VQ_DeviceLow = Queue[Queue_ReadAddr*7 + 5];

	reg [1:0] DevReq_r;
	assign DevReq = DevReq_r == 2'b01;
	always @(posedge axi_aclk)
	begin
		DevReq_r <= {DevReq_r[0], InterruptStatus[0]};
	end

	integer init_i;
	initial begin
        for(init_i=0;init_i<P_VirtQueueNum * 7;init_i=init_i+1) Queue[init_i] = 0;
    end
	// https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-1460002
	always @( posedge axi_aclk )
	begin
		if (mem_wren)
		begin
			case (axi_awaddr)
				32'h14	: DeviceFeaturesSel	<= S_AXI_WDATA;
				32'h20	:
					if(state == S_SETUP_BASE)
					begin
						if(DriverFeaturesSel == 0)
							DriverFeatures[31:0] <= S_AXI_WDATA;
						else
							DriverFeatures[63:32] <= S_AXI_WDATA;
					end
				32'h24	: DriverFeaturesSel <= S_AXI_WDATA;
				32'h30	: QueueSel			<= S_AXI_WDATA;
				32'h38	: QueueNum			<= S_AXI_WDATA;
				32'h44	: Queue[QueueSel*7]	<= S_AXI_WDATA;//Ready
				32'h50	: begin
					InterruptStatus <= InterruptStatus | 1;
				end
				32'h64	: begin
					InterruptStatus <= InterruptStatus & ~S_AXI_WDATA;//Bit0 = 0
				end
				32'h70	: DeviceStatus_tmp	<= S_AXI_WDATA;
				32'h80	: Queue[QueueSel*7+1]	<= S_AXI_WDATA;
				32'h84	: Queue[QueueSel*7+2]	<= S_AXI_WDATA;
				32'h90	: Queue[QueueSel*7+3]	<= S_AXI_WDATA;
				32'h94	: Queue[QueueSel*7+4]	<= S_AXI_WDATA;
				32'ha0	: Queue[QueueSel*7+5]	<= S_AXI_WDATA;
				32'ha4	: Queue[QueueSel*7+6]	<= S_AXI_WDATA;
				default : ;
			endcase
		end
	end   

	always @(axi_rvalid)
	begin
		if(axi_rvalid)
		begin
			case (S_AXI_ARADDR)
				32'h0   : axi_rdata <= P_MagicValue;
				32'h4   : axi_rdata <= P_Version;
				32'h8   : axi_rdata <= P_DeviceID;
				32'hc   : axi_rdata <= P_VendorID;
				32'h10  : axi_rdata <= (DeviceFeaturesSel == 0)? DeviceFeatures[31:0]: DeviceFeatures[63:32];
				32'h34  : axi_rdata <= P_QueueNumMax;
				32'h44  : axi_rdata <= Queue[QueueSel*7];
				32'h60  : axi_rdata <= InterruptStatus;
				32'h70  : axi_rdata <= DeviceStatus;
				32'hfc  : axi_rdata <= 32'h0;//ConfigGeneration;
				32'h100 : axi_rdata <= P_SECTORNUM[31:0];
				32'h104 : axi_rdata <= P_SECTORNUM[63:32];
				default : axi_rdata <= 0;
			endcase
		end
	end

	always @(posedge axi_aclk)
	begin
		if(axi_aresetn == 1'b0)
			DeviceStatus_tmp_en <= 1'b0;
		else if(mem_wren && axi_awaddr == 32'h70)
			DeviceStatus_tmp_en <= 1'b1;
		else
			DeviceStatus_tmp_en <= 1'b0;
	end

	always @(posedge axi_aclk)
	begin
		if(DeviceStatus_tmp_en == 1'b1)
		begin
			if(DeviceStatus_tmp == 32'h0)
				DeviceStatus <= 32'b1;//B_DEVSATUS_ACK
			else if(state == S_RST && DeviceStatus_tmp[B_DEVSATUS_DRIVER] == 1'b1)
				DeviceStatus[B_DEVSATUS_DRIVER] <= 1'b1;
			else if(state == S_SETUP_BASE && DeviceStatus_tmp[B_DEVSATUS_FEATURESOK] == 1'b1)
				DeviceStatus[B_DEVSATUS_FEATURESOK] <= 1'b1;
			else if(state == S_SETUP_DRIVER && DeviceStatus_tmp[B_DEVSATUS_DRIVEROK] == 1'b1)
				DeviceStatus[B_DEVSATUS_DRIVEROK] <= 1'b1;
		end
	end

	always @(posedge axi_aclk)
	begin
		if ( axi_aresetn == 1'b0 || (DeviceStatus_tmp_en == 1'b1 && DeviceStatus_tmp == 32'h0))
			state <= S_RST;
		else
			case (state)
				S_RST :
					if(DeviceStatus[B_DEVSATUS_DRIVER] == 1'b1)
						state <= S_SETUP_BASE;
				S_SETUP_BASE :
					if(DeviceStatus[B_DEVSATUS_FEATURESOK] == 1'b1)
						state <= S_SETUP_DRIVER;
				S_SETUP_DRIVER :
					if(DeviceStatus[B_DEVSATUS_DRIVEROK] == 1'b1)
						state <= S_IDLE;
				S_IDLE :
					state <= S_IDLE;
				default : state <= S_IDLE;
			endcase
	end

	endmodule
`default_nettype wire
