
`default_nettype none
`timescale 1 ns / 1 ps

	module packetgensimple (
		input wire clk,
		input wire rstn,

		input wire [3:0] switch,

	//FIFO
		output wire [15:0] packet_len,
		output wire [31:0] packet_data,
		input wire packet_rden,
	//Packet Tirg
		output wire packet_trig,

	//Interface Config
		output wire [47:00] src_mac,
		output wire [47:00] dst_mac,
		output wire [31:00] src_ip,
		output wire [31:00] dst_ip,
		output wire [15:0] src_port,
		output wire [15:0] dst_port
	);

	reg [31:0] state;
	localparam S_RST = 0;
	localparam S_IDLE = 1;
	localparam S_PACKETGEN = 2;
	localparam S_PACKETWAIT = 3;

	assign src_mac = 48'hfffffffffffe;
	assign dst_mac = 48'haabbccddeeff;
	assign src_ip = {8'd192,8'd168,8'd0,8'd1};
	assign dst_ip = {8'd192,8'd168,8'd0,8'd2};
	assign src_port = 16'd12345;
	assign dst_port = 16'd12345;

	//1[s]
	localparam TIMER_TIME = 32'd100_000_000;

	reg [31:0] timer;
	reg [31:0] cnt;
	wire fifo_empty;
	reg [31:0] in_data;

	assign packet_trig = state == S_PACKETWAIT;

	always @(posedge clk) begin
		if(rstn == 1'b0)
			timer <= 32'h0;
		else if(timer >= TIMER_TIME)
			timer <= 32'h0;
		else
			timer <= timer + 32'h1;
	end

	always @(posedge clk) begin
		if(rstn == 1'b0)
			state <= S_RST;
		else
			case (state)
				S_RST:
					state <= S_IDLE;
				S_IDLE:
					if(timer == TIMER_TIME)
						state <= S_PACKETGEN;
					else
						state <= S_IDLE;
				S_PACKETGEN:
					if(cnt == ((packet_len + 16'h1) >> 2) - 16'h1)
						state <= S_PACKETWAIT;
					else
						state <= S_PACKETGEN;
				S_PACKETWAIT:
					if(fifo_empty == 1'b1)
						state <= S_IDLE;
				default: state <= S_RST;
			endcase
	end
 
	always @(posedge clk) begin
		if(rstn == 1'b0)
			cnt <= 32'h0;
		else if(state == S_PACKETGEN)
			cnt <= cnt + 32'h1;
		else
			cnt <= 32'h0;
	end

	fifo_generator_0 fifo_generator_0_inst(
		.clk(clk),
		.srst(~rstn),
		.full(),
		.din({in_data[7:0],in_data[15:8],in_data[23:16],in_data[31:24]}),//Convert dir 3210->0123
		.wr_en(state == S_PACKETGEN),
		.empty(fifo_empty),
		.dout(packet_data),
		.rd_en(packet_rden)
	);

	localparam PACKETLENGTH = 8;
	assign packet_len = PACKETLENGTH;

	always @ (*) begin
		case (cnt)
			32'd0:	in_data <= 32'h48656c6c;//Hell
			32'd1:	in_data <= {16'h6f21,8'h30 + switch, 8'h0a};//o!<sw>\n
		endcase
	end

	endmodule

`default_nettype wire