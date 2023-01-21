//`default_nettype none

module vram_if(
    input  wire        clk,

    // Interface 0 - 8-bit (highest priority)
    input  wire [16:0] if0_addr,
	input  wire  [1:0] if0_wrpattern,
    input  wire  [7:0] if0_wrdata,
    output wire  [7:0] if0_rddata,
    input  wire        if0_strobe,
    input  wire        if0_write,

    // Interface 1 - 32-bit read only
    input  wire [14:0] if1_addr,
    output wire [31:0] if1_rddata,
    input  wire        if1_strobe,
    output reg         if1_ack,

    // Interface 2 - 32-bit read only
    input  wire [14:0] if2_addr,
    output wire [31:0] if2_rddata,
    input  wire        if2_strobe,
    output reg         if2_ack,

    // Interface 3 - 32-bit read only
    input  wire [14:0] if3_addr,
    output wire [31:0] if3_rddata,
    input  wire        if3_strobe,
    output reg         if3_ack);

    //////////////////////////////////////////////////////////////////////////
    // Main RAM 128kB (32k x 32)
    //////////////////////////////////////////////////////////////////////////
    reg  [14:0] ram_addr;
    wire [31:0] ram_wrdata;
    reg   [3:0] ram_wrbytesel;
    wire [31:0] ram_rddata;
    wire        ram_write;

    main_ram main_ram(
        .clk(clk),
        .bus_addr(ram_addr),
        .bus_wrdata(ram_wrdata),
        .bus_wrbytesel(ram_wrbytesel),
        .bus_rddata(ram_rddata),
        .bus_write(ram_write));

    //////////////////////////////////////////////////////////////////////////
    // Priority memory access
    //////////////////////////////////////////////////////////////////////////
    reg if0_ack, if0_ack_next;
    reg if1_ack_next;
    reg if2_ack_next;
    reg if3_ack_next;

    assign ram_wrdata = {4{if0_wrdata}};
    assign ram_write  = if0_strobe && if0_write;

	/*
		Colums: address % 4
		Rows: 2-bit value representing a pattern (but dependent on addrss, so we can create all possible patterns)
	
		_   0    1    2    3
		00 0001 0010 0100 1000
		01 0011 0110 1100 1001
		10 0101 1010 0111 1110
		11 1111 1111 1101 1011

	*/

    always @* case (if0_wrpattern[1:0])
		2'b00: case (if0_addr[1:0])
			2'b00: ram_wrbytesel = 4'b0001;
			2'b01: ram_wrbytesel = 4'b0010;
			2'b10: ram_wrbytesel = 4'b0100;
			2'b11: ram_wrbytesel = 4'b1000;
		endcase
		2'b01: case (if0_addr[1:0])
			2'b00: ram_wrbytesel = 4'b0011;
			2'b01: ram_wrbytesel = 4'b0110;
			2'b10: ram_wrbytesel = 4'b1100;
			2'b11: ram_wrbytesel = 4'b1001;
		endcase
		2'b10: case (if0_addr[1:0])
			2'b00: ram_wrbytesel = 4'b0101;
			2'b01: ram_wrbytesel = 4'b1010;
			2'b10: ram_wrbytesel = 4'b0111;
			2'b11: ram_wrbytesel = 4'b1110;
		endcase
		2'b11: case (if0_addr[1:0])
			2'b00: ram_wrbytesel = 4'b1111; // blit
			2'b01: ram_wrbytesel = 4'b1111;
			2'b10: ram_wrbytesel = 4'b1101;
			2'b11: ram_wrbytesel = 4'b1011;
		endcase

    endcase

    always @* begin
        ram_addr     = 15'b0;
        if0_ack_next = 1'b0;
        if1_ack_next = 1'b0;
        if2_ack_next = 1'b0;
        if3_ack_next = 1'b0;

        if (if0_strobe) begin
            ram_addr     = if0_addr[16:2];
            if0_ack_next = 1'b1;

        end else if (if1_strobe) begin
            ram_addr     = if1_addr;
            if1_ack_next = 1'b1;

        end else if (if2_strobe) begin
            ram_addr     = if2_addr;
            if2_ack_next = 1'b1;

        end else if (if3_strobe) begin
            ram_addr     = if3_addr;
            if3_ack_next = 1'b1;
        end
    end

    always @(posedge clk) begin
        if0_ack <= if0_ack_next;
        if1_ack <= if1_ack_next;
        if2_ack <= if2_ack_next;
        if3_ack <= if3_ack_next;
    end

    reg [1:0] if0_addr_r;
    always @(posedge clk) if0_addr_r <= if0_addr[1:0];

    // Memory bus read data selection
    reg [7:0] if0_rddata8;
    reg [7:0] if0_rddata8_r;
    always @* case (if0_addr_r)
        2'b00: if0_rddata8 = ram_rddata[7:0];
        2'b01: if0_rddata8 = ram_rddata[15:8];
        2'b10: if0_rddata8 = ram_rddata[23:16];
        2'b11: if0_rddata8 = ram_rddata[31:24];
    endcase

    always @(posedge clk) begin
        if (if0_ack) begin
            if0_rddata8_r <= if0_rddata8;
        end
    end

    assign if0_rddata = if0_ack ? if0_rddata8 : if0_rddata8_r;
    assign if1_rddata = ram_rddata;
    assign if2_rddata = ram_rddata;
    assign if3_rddata = ram_rddata;

endmodule
