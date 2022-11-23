
`timescale 1 ns / 1 ps

	module nicprocessor_recv #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Base address of targeted slave
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		// Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
		parameter integer C_M_AXI_BURST_LEN	= 16,
		// Thread ID Width
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		// Width of Address Bus
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of Data Bus
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		// Width of User Write Address Bus
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		// Width of User Read Address Bus
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		// Width of User Write Data Bus
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		// Width of User Read Data Bus
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		// Width of User Response Bus
		parameter integer C_M_AXI_BUSER_WIDTH	= 0,
		//VirtIO QueueSize
		parameter P_QueueNumMax 				= 32'h10
	)
	(
		// Users to add ports here
		output wire interrupt,
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal.
		input wire  M_AXI_ACLK,
		// Global Reset Singal. This Signal is Active Low
		input wire  M_AXI_ARESETN,
		// Master Interface Write Address ID
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
		// Master Interface Write Address
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_AWLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_AWSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_AWBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_AWLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_AWCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_AWPROT,
		// Quality of Service, QoS identifier sent for each write transaction.
		output wire [3 : 0] M_AXI_AWQOS,
		// Optional User-defined signal in the write address channel.
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid write address and control information.
		output wire  M_AXI_AWVALID,
		// Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_AWREADY,
		// Master Interface Write Data.
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		// Write strobes. This signal indicates which byte
    // lanes hold valid data. There is one write strobe
    // bit for each eight bits of the write data bus.
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		// Write last. This signal indicates the last transfer in a write burst.
		output wire  M_AXI_WLAST,
		// Optional User-defined signal in the write data channel.
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
		// Write valid. This signal indicates that valid write
    // data and strobes are available
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    // can accept the write data.
		input wire  M_AXI_WREADY,
		// Master Interface Write Response.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		// Write response. This signal indicates the status of the write transaction.
		input wire [1 : 0] M_AXI_BRESP,
		// Optional User-defined signal in the write response channel
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
		// Write response valid. This signal indicates that the
    // channel is signaling a valid write response.
		input wire  M_AXI_BVALID,
		// Response ready. This signal indicates that the master
    // can accept a write response.
		output wire  M_AXI_BREADY,
		// Master Interface Read Address.
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
		// Read address. This signal indicates the initial
    // address of a read burst transaction.
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_ARLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_ARSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_ARBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_ARLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_ARCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_ARPROT,
		// Quality of Service, QoS identifier sent for each read transaction
		output wire [3 : 0] M_AXI_ARQOS,
		// Optional User-defined signal in the read address channel.
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
		output wire  M_AXI_ARVALID,
		// Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_ARREADY,
		// Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		// Master Read Data
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer
		input wire [1 : 0] M_AXI_RRESP,
		// Read last. This signal indicates the last transfer in a read burst
		input wire  M_AXI_RLAST,
		// Optional User-defined signal in the read address channel.
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		// Read valid. This signal indicates that the channel
    // is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    // accept the read data and response information.
		output wire  M_AXI_RREADY,

        output wire [31:0] Queue_ReadAddr,
        input wire [31:0] VQ_READY,
        input wire [31:0] VQ_DescLow,
        input wire [31:0] VQ_DriverLow,
        input wire [31:0] VQ_DeviceLow,

		input wire [31:0] packet_len,
		input wire [31:0] packet_data,
		output wire packet_rden,
		input wire packet_trig
	);


	// function called clogb2 that returns an integer which has the
	//value of the ceiling of the log base 2

	  // function called clogb2 that returns an integer which has the 
	  // value of the ceiling of the log base 2.                      
	  function integer clogb2 (input integer bit_depth);              
	  begin                                                           
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	      bit_depth = bit_depth >> 1;                                 
	    end                                                           
	  endfunction                                                     

	// C_TRANSACTIONS_NUM is the width of the index counter for 
	// number of write or read transaction.
	 localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);

	// Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
	// Non-2^n lengths will eventually cause bursts across 4K address boundaries.
	 localparam integer C_MASTER_LENGTH	= 12;
	// total number of burst transfers is master length divided by burst length and burst size
	 localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);
	// Example State machine to initialize counter, initialize write transactions, 
	// initialize read transactions and comparison of read data with the 
	// written data words.
	parameter [1:0] IDLE = 2'b00, // This state initiates AXI4Lite transaction 
			// after the state machine changes state to INIT_WRITE 
			// when there is 0 to 1 transition on INIT_AXI_TXN
		INIT_WRITE   = 2'b01, // This state initializes write transaction,
			// once writes are done, the state machine 
			// changes state to INIT_READ 
		INIT_READ = 2'b10, // This state initializes read transaction
			// once reads are done, the state machine 
			// changes state to INIT_COMPARE 
		INIT_COMPARE = 2'b11; // This state issues the status of comparison 
			// of the written data with the read data	

	 reg [1:0] mst_exec_state;

	// AXI4LITE signals
	//AXI4 internal temp signals
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awvalid;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
	reg  	axi_wlast;
	reg  	axi_wvalid;
	reg  	axi_bready;
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arvalid;
	reg  	axi_rready;
	//write beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	write_index;
	//read beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	read_index;
	//size of C_M_AXI_BURST_LEN length burst in bytes
	wire [C_TRANSACTIONS_NUM+2 : 0] 	burst_size_bytes;
	//The burst counters are used to track the number of burst transfers of C_M_AXI_BURST_LEN burst length needed to transfer 2^C_MASTER_LENGTH bytes of data.
	reg [C_NO_BURSTS_REQ : 0] 	write_burst_counter;
	reg [C_NO_BURSTS_REQ : 0] 	read_burst_counter;
	reg  	start_single_burst_write;
	reg  	start_single_burst_read;
	reg  	writes_done;
	reg  	reads_done;
	reg  	error_reg;
	reg  	compare_done;
	reg  	read_mismatch;
	reg  	burst_write_active;
	reg  	burst_read_active;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	expected_rdata;
	//Interface response error flags
	wire  	write_resp_error;
	wire  	read_resp_error;
	wire  	wnext;
	wire  	rnext;
	reg  	init_txn_ff;
	reg  	init_txn_ff2;
	reg  	init_txn_edge;
	wire  	init_txn_pulse;


	// I/O Connections assignments

	//I/O Connections. Write Address (AW)
	assign M_AXI_AWID	= 'b0;
	//The AXI address is a concatenation of the target base address + active offset range
	//assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
	//Burst LENgth is number of transaction beats, minus 1
	//assign M_AXI_AWLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
	assign M_AXI_AWSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_AWBURST	= 2'b01;
	assign M_AXI_AWLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_AWCACHE	= 4'b1111;
	assign M_AXI_AWPROT	= 3'h0;
	assign M_AXI_AWQOS	= 4'h0;
	assign M_AXI_AWUSER	= 'b1;
	//assign M_AXI_AWVALID	= axi_awvalid;
	//Write Data(W)
	assign M_AXI_WDATA	= axi_wdata;
	//All bursts are complete and aligned in this example
	assign M_AXI_WSTRB	= {(C_M_AXI_DATA_WIDTH/8){1'b1}};
	//assign M_AXI_WLAST	= axi_wlast;
	assign M_AXI_WUSER	= 'b0;
	//assign M_AXI_WVALID	= axi_wvalid;
	//Write Response (B)
	assign M_AXI_BREADY	= 1'b1;//axi_bready;
	//Read Address (AR)
	assign M_AXI_ARID	= 'b0;
	//assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	//Burst LENgth is number of transaction beats, minus 1
	//assign M_AXI_ARLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
	assign M_AXI_ARSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_ARBURST	= 2'b01;
	assign M_AXI_ARLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_ARCACHE	= 4'b1111;
	assign M_AXI_ARPROT	= 3'h0;
	assign M_AXI_ARQOS	= 4'h0;
	assign M_AXI_ARUSER	= 'b1;
	//assign M_AXI_ARVALID	= axi_arvalid;
	//Read and Read Response (R)
	//assign M_AXI_RREADY	= axi_rready;

    localparam S_RST = 0;
    localparam S_IDLE = 1;
	localparam S_AVAIL_CHK = 2;
	localparam S_AVAIL_CHK_WAIT = 3;
	localparam S_AVAIL_CHK_DONE = 4;
	localparam S_AVAIL_READ = 5;
	localparam S_AVAIL_READ_WAIT = 6;
	localparam S_DESC_READ = 7;
	localparam S_DESC_READ_WAIT = 8;
	localparam S_HEADER_READ = 9;
	localparam S_HEADER_READ_WAIT = 10;
	localparam S_HEADER_REWRITE = 11;
	localparam S_HEADER_REWRITE_WAIT = 12;
	localparam S_PACKETWRITE = 13;
	localparam S_PACKETWRITE_WAIT = 14;
	localparam S_DESC_WRITE = 15;
	localparam S_DESC_WRITE_WAIT = 16;
	localparam S_USED_READ = 17;
	localparam S_USED_READ_WAIT = 18;
	localparam S_USED_IDX_UPDATE = 19;
	localparam S_USED_IDX_UPDATE_WAIT = 20;
	localparam S_USED_ENTITY_UPDATE = 21;
	localparam S_USED_ENTITY_UPDATE_WAIT = 22;
	localparam S_USEDUPDATE_DONE = 23;

    reg [31:0] state;
	reg [15:0] cnt_r;
	reg [15:0] cnt_w;

	reg [15:0] LAST_AVAIL_IDX = 16'h0;

	reg [31:0] Vring_header_avail;//[31:16]idx, [15:0]flags
	reg [31:0] Vring_header_used;//[31:16]idx, [15:0]flags
	wire [15:0] Vring_flags_avail;
	wire [15:0] Vring_idx_avail;
	wire [15:0] Vring_flags_used;
	wire [15:0] Vring_idx_used;
	assign Vring_flags_avail = Vring_header_avail[15:0];
	assign Vring_idx_avail = Vring_header_avail[31:16];
	assign Vring_flags_used = Vring_header_used[15:0];
	assign Vring_idx_used = Vring_header_used[31:16];

	reg [32:0] Vring_Driver_rings;
	wire [15:0] Vring_Driver_Index = (LAST_AVAIL_IDX[0] == 1'b0) ? Vring_Driver_rings[15:0] : Vring_Driver_rings[31:16];

	reg [15:0] Vring_Driver_Index_reg;

	reg [31:0] DescChain [3:0];
	/*	0: LowAddr		Header
		1: HighAddr
		2: Len
		3: flags,next
	*/

	reg [31:0] ReqHeader [3:0];
	wire [31:0] ReqHeader_wire_w;
	assign ReqHeader_wire_w = ReqHeader[cnt_w];
	/*
	typedef struct EtherPacketHeader {
        uint8_t flags;
        uint8_t gso_type;
        uint16_t hdr_len;
        uint16_t gso_size;
        uint16_t csum_start;
        uint16_t csum_offset;
        uint16_t num_buffers;
	}EtherPacketHeader;
	*/

	reg [31:0] DISK [0:127];

	reg InterruptBit;

    assign Queue_ReadAddr = 32'h0;
	assign interrupt = state == S_IDLE && InterruptBit == 1'b1;

    assign M_AXI_ARVALID = (state == S_AVAIL_CHK || state == S_AVAIL_READ || state == S_DESC_READ || state == S_HEADER_READ || state == S_USED_READ);
    assign M_AXI_RREADY = (state == S_AVAIL_CHK_WAIT || state == S_AVAIL_READ_WAIT || state === S_DESC_READ_WAIT || state == S_HEADER_READ_WAIT || state == S_USED_READ_WAIT);
    assign M_AXI_AWVALID = (state == S_HEADER_REWRITE || state == S_PACKETWRITE || state == S_DESC_WRITE || state == S_USED_IDX_UPDATE || state == S_USED_ENTITY_UPDATE);
    assign M_AXI_WVALID = (state == S_HEADER_REWRITE_WAIT || state == S_PACKETWRITE_WAIT || state == S_DESC_WRITE_WAIT || state == S_USED_IDX_UPDATE_WAIT || state == S_USED_ENTITY_UPDATE_WAIT);
	assign M_AXI_WLAST = (	(state == S_HEADER_REWRITE_WAIT && cnt_w == 16'd2)
						||  (state == S_PACKETWRITE_WAIT && cnt_w == (((packet_len + 32'h1) >> 2) - 1))
						||  (state == S_DESC_WRITE_WAIT && cnt_w == 16'd1)
						||	(state == S_USED_IDX_UPDATE_WAIT && cnt_w == 16'd0)
						||	(state == S_USED_ENTITY_UPDATE_WAIT && cnt_w == 16'd1)) ? 1'b1: 1'b0;

	wire AXI_AR_OK;
	wire AXI_AW_OK;
	wire AXI_R_OK;
	wire AXI_W_OK;
	wire AXI_R_END;
	wire AXI_W_END;
	assign AXI_AR_OK = (M_AXI_ARREADY == 1'b1 && M_AXI_ARVALID == 1'b1);
	assign AXI_AW_OK = (M_AXI_AWREADY == 1'b1 && M_AXI_AWVALID == 1'b1);
	assign AXI_R_OK = (M_AXI_RREADY == 1'b1 && M_AXI_RVALID == 1'b1);
	assign AXI_W_OK = (M_AXI_WREADY == 1'b1 && M_AXI_WVALID == 1'b1);
	assign AXI_R_END = (AXI_R_OK == 1'b1 && M_AXI_RLAST == 1'b1);
	assign AXI_W_END = (AXI_W_OK == 1'b1 && M_AXI_WLAST == 1'b1);



    assign M_AXI_ARADDR =	(state == S_AVAIL_CHK) ? VQ_DriverLow :
							(state == S_AVAIL_READ) ? VQ_DriverLow + ((1 + (LAST_AVAIL_IDX  % P_QueueNumMax)/2) << 2):
							(state == S_DESC_READ) ? VQ_DescLow + ((Vring_Driver_Index) % P_QueueNumMax) * 32'h10:
							(state == S_HEADER_READ) ? DescChain[0] :
							(state == S_USED_READ) ? VQ_DeviceLow : 32'h0;
    assign M_AXI_ARLEN =	(state == S_AVAIL_CHK) ? 8'd0 :
							(state == S_AVAIL_READ) ? 8'd0 :
							(state == S_DESC_READ) ? 8'd3 :
							(state == S_HEADER_READ) ? 8'd2 :
							(state == S_USED_READ) ?  8'd0 : 8'd0;

    assign M_AXI_AWADDR =	(state == S_HEADER_REWRITE) ? DescChain[0] ://32bit
							(state == S_PACKETWRITE) ? DescChain[0] + 32'd12://32bit 32'd12=EtherPacketHeader
							(state == S_DESC_WRITE) ? VQ_DescLow + ((Vring_Driver_Index) % P_QueueNumMax) * 32'h10 + 32'h8 :
							(state == S_USED_IDX_UPDATE) ? VQ_DeviceLow :
							(state == S_USED_ENTITY_UPDATE) ? VQ_DeviceLow + 4 + ((Vring_idx_used % P_QueueNumMax) * 8) : 32'h0;
    assign M_AXI_AWLEN =	(state == S_HEADER_REWRITE) ? 8'd2 :
							(state == S_PACKETWRITE) ? (((packet_len + 32'h1) >> 2) - 1) :
							(state == S_DESC_WRITE) ? 8'd1 :
							(state == S_USED_IDX_UPDATE) ? 8'd0 :
							(state == S_USED_ENTITY_UPDATE) ? 8'd1 : 8'd0;

    reg [1:0] DevReq_e;
	reg DevReq_reg;
    always @(posedge M_AXI_ACLK) begin
      DevReq_e <= {DevReq_e[0], packet_trig};
    end
	always @(posedge M_AXI_ACLK) begin
		DevReq_reg <= (state == S_AVAIL_CHK) ? 1'b0 : ((DevReq_e == 2'b01) | DevReq_reg);
	end

	always @(posedge M_AXI_ACLK) begin
		if(M_AXI_ARESETN == 1'b0)
			LAST_AVAIL_IDX <= 16'h0;
		else if(state == S_USEDUPDATE_DONE)
			LAST_AVAIL_IDX <= (LAST_AVAIL_IDX + 16'h1);
	end

	always @(posedge M_AXI_ACLK) begin
		if(M_AXI_ARESETN == 1'b0)
			InterruptBit <= 1'b0;
		else if(state == S_IDLE)
			InterruptBit <= 1'b0;
		else if(state == S_USEDUPDATE_DONE)
			InterruptBit <= 1'b1;
	end

	always @(posedge M_AXI_ACLK) begin
		if(M_AXI_ARESETN == 1'b0)
			cnt_r <= 16'h0;
		else if(state == S_AVAIL_CHK_WAIT
			||	state == S_AVAIL_READ_WAIT
			||	state == S_DESC_READ_WAIT
			||	state == S_HEADER_READ_WAIT
			||	state == S_USED_READ_WAIT) begin
                if(AXI_R_OK == 1'b1)
					if(M_AXI_RLAST == 1'b1)
						cnt_r <= 16'h0;
					else
						cnt_r <= cnt_r + 16'h1;
			end
		else
			cnt_r <= 16'h0;
	end
	always @(posedge M_AXI_ACLK) begin
		if(M_AXI_ARESETN == 1'b0)
			cnt_w <= 16'h0;
		else if(state == S_HEADER_REWRITE_WAIT
			||	state == S_PACKETWRITE_WAIT
			||	state == S_DESC_WRITE_WAIT
			||	state == S_USED_IDX_UPDATE_WAIT
			||	state == S_USED_ENTITY_UPDATE_WAIT) begin
                if(AXI_W_OK == 1'b1)
					if(M_AXI_WLAST == 1'b1)
						cnt_w <= 16'h0;
					else
						cnt_w <= cnt_w + 16'h1;
			end
		else
			cnt_w <= 16'h0;
	end
	wire [31:0] sector_num = ReqHeader[2];
	//localparam PACKETLENGTH = 16;
	always @ (*) begin
		case (state)
			S_HEADER_REWRITE_WAIT:
				case(cnt_w)
					16'd0: axi_wdata <= {16'h0, 8'h0, 8'h0};//hdr_len, gso_type, flags
					16'd1: axi_wdata <= {16'h0, 16'h0};//csum_start, gso_size
					16'd2: axi_wdata <= {16'h1, 16'h0};//num_buffers, csum_offset
					// 16'd2: axi_wdata <= {16'h1,ReqHeader_wire_w[15:0]};
					default: axi_wdata <= ReqHeader[cnt_w];
				endcase
			S_PACKETWRITE_WAIT:
				axi_wdata <= packet_data;
			S_DESC_WRITE_WAIT:
				case(cnt_w)
					16'd0: axi_wdata <= packet_len + 32'd12 - 32'd2;
					16'd1: axi_wdata <= 32'h2;
					default: ;
				endcase
			S_USED_IDX_UPDATE_WAIT:
				case(cnt_w)
					16'd0: axi_wdata <= {(Vring_idx_used + 16'h1), Vring_flags_used};
					default: ;
				endcase
			S_USED_ENTITY_UPDATE_WAIT:
				case(cnt_w)
					16'd0: axi_wdata <= {16'h0, Vring_Driver_Index_reg};//desc_idx
					16'd1: axi_wdata <= packet_len + 32'd12 - 32'd2;//packet_len + sizeof(header) + padding
					default: ;
				endcase
		default: ;
		endcase
	end

	assign packet_rden = state == S_PACKETWRITE_WAIT && AXI_W_OK;
    
	always @(posedge M_AXI_ACLK) begin
		if(AXI_R_OK == 1'b1)
			case (state)
				S_AVAIL_CHK_WAIT:
					Vring_header_avail <= M_AXI_RDATA;
				S_AVAIL_READ_WAIT:
					Vring_Driver_rings <= M_AXI_RDATA;
				S_DESC_READ_WAIT:
					DescChain[cnt_r] <= M_AXI_RDATA;
				S_USED_READ_WAIT:
					Vring_header_used <= M_AXI_RDATA;
				S_HEADER_READ_WAIT:
					ReqHeader[cnt_r] <= M_AXI_RDATA;
				default: ;
			endcase
	end

	always @(posedge M_AXI_ACLK) begin
		if(M_AXI_ARESETN == 1'b0)
			Vring_Driver_Index_reg <= 16'h0;
		else if(state == S_DESC_READ)
			Vring_Driver_Index_reg <= Vring_Driver_Index;
	end


    always @(posedge M_AXI_ACLK) begin
        if(M_AXI_ARESETN == 1'b0 || VQ_READY[0] == 1'b0)
            state <= S_RST;
        else case (state)
            S_RST: state <= S_IDLE;
            S_IDLE: begin
                if(packet_trig == 1'b1)
                    state <= S_AVAIL_CHK;
            end
            S_AVAIL_CHK:
                if(AXI_AR_OK)
                    state <= S_AVAIL_CHK_WAIT;
            S_AVAIL_CHK_WAIT:
                if(AXI_R_END == 1'b1)
					state <= S_AVAIL_CHK_DONE;
			S_AVAIL_CHK_DONE:
				if(Vring_idx_avail != LAST_AVAIL_IDX)
					state <= S_AVAIL_READ;
				else
					state<= S_IDLE;
			S_AVAIL_READ:
                if(AXI_AR_OK == 1'b1)
                    state <= S_AVAIL_READ_WAIT;
			S_AVAIL_READ_WAIT:
                if(AXI_R_END == 1'b1)
                    state <= S_DESC_READ;
            S_DESC_READ:
                if(AXI_AR_OK == 1'b1)
                    state <= S_DESC_READ_WAIT;
            S_DESC_READ_WAIT:
                if(AXI_R_END == 1'b1)
					state <= S_HEADER_READ;
			S_HEADER_READ:
                if(AXI_AR_OK == 1'b1)
                    state <= S_HEADER_READ_WAIT;
			S_HEADER_READ_WAIT:
                if(AXI_R_END == 1'b1)
					state <= S_HEADER_REWRITE;
			S_HEADER_REWRITE:
                if(AXI_AW_OK == 1'b1)
                    state <= S_HEADER_REWRITE_WAIT;
			S_HEADER_REWRITE_WAIT:
                if(AXI_W_END == 1'b1)
                    state <= S_PACKETWRITE;
			S_PACKETWRITE:
                if(AXI_AW_OK == 1'b1)
                    state <= S_PACKETWRITE_WAIT;
			S_PACKETWRITE_WAIT:
                if(AXI_W_END == 1'b1)
                    state <= S_DESC_WRITE;
			S_DESC_WRITE:
                if(AXI_AW_OK == 1'b1)
                    state <= S_DESC_WRITE_WAIT;
			S_DESC_WRITE_WAIT:
                if(AXI_W_END == 1'b1)
                    state <= S_USED_READ;
			S_USED_READ:
                if(AXI_AR_OK == 1'b1)
                    state <= S_USED_READ_WAIT;
            S_USED_READ_WAIT:
                if(AXI_R_END == 1'b1)
					state <= S_USED_IDX_UPDATE;
			S_USED_IDX_UPDATE:
                if(AXI_AW_OK == 1'b1)
                    state <= S_USED_IDX_UPDATE_WAIT;
			S_USED_IDX_UPDATE_WAIT:
                if(AXI_W_END == 1'b1)
                    state <= S_USED_ENTITY_UPDATE;
			S_USED_ENTITY_UPDATE:
                if(AXI_AW_OK == 1'b1)
					state <= S_USED_ENTITY_UPDATE_WAIT;
			S_USED_ENTITY_UPDATE_WAIT:
                if(AXI_W_END == 1'b1)
					state <= S_USEDUPDATE_DONE;
			S_USEDUPDATE_DONE:
				state <= S_IDLE;
            default: state <= S_RST;
        endcase
    end

	endmodule
