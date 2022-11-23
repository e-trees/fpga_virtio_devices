
`default_nettype none
`timescale 1 ns / 1 ps

	module packetgen_conv (
		input wire clk,
		input wire rstn,
    //In
    //MAC
        input wire [47:0] src_mac,
        input wire [47:0] dst_mac,
        input wire [31:0] src_ip,
        input wire [31:0] dst_ip,
        input wire [15:0] src_port,
        input wire [15:0] dst_port,
	//FIFO
		input wire [15:0] in_packet_payload_len,
		input wire [31:0] in_packet_payload,
		output wire in_packet_rden,
	//Packet Tirg
		input wire in_packet_trig,

    //Out
	//FIFO
		output wire [31:0] out_packet_len,
		output wire [31:0] out_packet_data,
		input wire out_packet_rden,
	//Packet Tirg
		output wire out_packet_trig
	);

    reg [31:0] out_packet_data_r;

    assign out_packet_len = in_packet_payload_len + 44;//header len
    assign out_packet_trig = in_packet_trig;
    assign in_packet_rden = (state == S_DATA && out_packet_rden);
    assign out_packet_data = {out_packet_data_r[7:0],out_packet_data_r[15:8],out_packet_data_r[23:16],out_packet_data_r[31:24]};

    reg [31:0] header [0:33];
    reg [7:0] state;
    localparam S_RST = 0;
    localparam S_IDLE = 1;
    localparam S_HEADER = 2;
    localparam S_DATA = 3;
    localparam S_FIN = 4;

    reg [15:0] tmpcnt;
    always @(posedge clk) begin
        if(rstn == 1'b0)
            tmpcnt <= 16'h0;
        else if(state == S_HEADER || state == S_DATA) begin
            if(out_packet_rden)
                tmpcnt <= tmpcnt + 16'h1;
        end else
            tmpcnt <= 16'h0;
    end
    wire [15:0] fwftcnt;
    assign fwftcnt = (out_packet_rden)?(tmpcnt + 16'h1):tmpcnt;

    //IPv4 Header Identification
    reg [15:0] identification;
    always @(posedge clk) begin
        if(rstn == 1'b0)
            identification <= 0;
        else if(state == S_FIN)
            identification <= identification + 16'h1;
    end

    reg [31:0] checksum_tmp;
    wire [15:0] checksum;
    assign checksum = (~(checksum_tmp[31:16] + checksum_tmp[15:0]));
    always @(posedge clk) begin
        if(rstn == 1'b0)
            checksum_tmp <= 0;
        else if(state == S_HEADER)
            //0x4500(ver, len, diffsrv) + 0x4000(flags, fragment offset) + 0x4011(TTL, protocol) + 0x1c(Len)
            checksum_tmp <= 32'hc52d
                + src_ip[31:16]  + src_ip[15:0]
                + dst_ip[31:16]  + dst_ip[15:0]
                + in_packet_payload_len +identification;
    end

    always @(posedge clk) begin
        if(rstn == 1'b0)
            out_packet_data_r <= 32'h0;
        else if(state == S_HEADER) 
            case(fwftcnt)
            //Ethernet Header
                16'h0: out_packet_data_r <= {16'h0, dst_mac[47:32]};
                16'h1: out_packet_data_r <= dst_mac[31:0];
                16'h2: out_packet_data_r <= src_mac[47:16];
                16'h3: out_packet_data_r <= {dst_mac[15:0], 16'h0800}; //ipv4
            //IPv4 Header
                16'h4: out_packet_data_r <= {4'h4,4'h5,8'h0,(16'd20 + 16'd8 + in_packet_payload_len)};//Version, Len, DiffServ, Len
                16'h5: out_packet_data_r <= {identification, 3'h2, 13'h0};//Identification, Flags(Don't fragment), Fragment Offset
                16'h6: out_packet_data_r <= {8'h40, 8'h11, checksum};//TTL, Protocol(UDP), Checksum
                16'h7: out_packet_data_r <= src_ip;
                16'h8: out_packet_data_r <= dst_ip;
            //UDP Header
                16'h9: out_packet_data_r <= {dst_port, src_port};
                16'ha: out_packet_data_r <= {16'd8 + in_packet_payload_len, 16'h0};//Len, Checksum
                default: out_packet_data_r <= 32'hdeadbeaf;
            endcase
        else if(state == S_DATA)
            out_packet_data_r <= {in_packet_payload[7:0],in_packet_payload[15:8],in_packet_payload[23:16],in_packet_payload[31:24]};
    end


    always @(posedge clk) begin
        if(rstn == 1'b0)
            state <= S_RST;
        else case (state)
            S_RST: state <= S_IDLE;
            S_IDLE:
                if(in_packet_trig)
                    state <= S_HEADER;
            S_HEADER:
                if(fwftcnt == 16'ha)
                    state <= S_DATA;
            S_DATA:
                if(fwftcnt == (16'ha + ((in_packet_payload_len + 32'h1) >> 2)))
                    state <= S_FIN;
            S_FIN:
                state <= S_IDLE;
            default: state <= S_IDLE;
        endcase
    end

    endmodule
`default_nettype wire