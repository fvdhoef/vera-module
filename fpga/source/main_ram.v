`default_nettype none

module main_ram(
    input  wire        clk,

    // Slave bus interface
    input  wire [14:0] bus_addr,
    input  wire [31:0] bus_wrdata,
    input  wire  [3:0] bus_wrbytesel,
    output reg  [31:0] bus_rddata,
    input  wire        bus_write);

    wire blk10_cs = !bus_addr[14];
    wire blk32_cs = bus_addr[14];
    wire [31:0] blk10_rddata;
    wire [31:0] blk32_rddata;

    reg bus_addr14;
    always @(posedge clk) bus_addr14 <= bus_addr[14];

    always @* bus_rddata = bus_addr14 ? blk32_rddata : blk10_rddata;

`ifdef __ICARUS__
    reg [31:0] blk10[0:16383];
    reg [31:0] blk32[0:16383];

    reg [31:0] blk10_rddata_r;
    reg [31:0] blk32_rddata_r;

    assign blk10_rddata = blk10_rddata_r;
    assign blk32_rddata = blk32_rddata_r;

    always @(posedge clk) begin
        if (bus_write && blk10_cs) begin
            if (bus_wrbytesel[0]) begin
                blk10[bus_addr][7:0] = bus_wrdata[7:0];
            end
            if (bus_wrbytesel[1]) begin
                blk10[bus_addr][15:8] = bus_wrdata[15:8];
            end
            if (bus_wrbytesel[2]) begin
                blk10[bus_addr][23:16] = bus_wrdata[23:16];
            end
            if (bus_wrbytesel[3]) begin
                blk10[bus_addr][31:24] = bus_wrdata[31:24];
            end
        end
        if (bus_write && blk32_cs) begin
            if (bus_wrbytesel[0]) begin
                blk32[bus_addr][7:0] = bus_wrdata[7:0];
            end
            if (bus_wrbytesel[1]) begin
                blk32[bus_addr][15:8] = bus_wrdata[15:8];
            end
            if (bus_wrbytesel[2]) begin
                blk32[bus_addr][23:16] = bus_wrdata[23:16];
            end
            if (bus_wrbytesel[3]) begin
                blk32[bus_addr][31:24] = bus_wrdata[31:24];
            end
        end

        blk10_rddata_r <= blk10[bus_addr[13:0]];
        blk32_rddata_r <= blk32[bus_addr[13:0]];
    end

    initial begin: INIT
        integer i;
        for (i=0; i<16384; i=i+1) begin
            blk10[i] = i;
            blk32[i] = i;
        end

        blk10[0] = 32'h43022101;
        // blk10[1] = 32'h02100011;
        // blk10[2] = 32'h56000011;
        // blk10[3] = 32'h03FFFCFF;
    end

`else

    SP256K blk0(
        .CK(clk),
        .AD(bus_addr[13:0]),
        .DI(bus_wrdata[15:0]),
        .DO(blk10_rddata[15:0]),
        .MASKWE({{2{bus_wrbytesel[1]}}, {2{bus_wrbytesel[0]}}}),
        .WE(bus_write && blk10_cs),
        .CS(1'b1),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1));

    SP256K blk1(
        .CK(clk),
        .AD(bus_addr[13:0]),
        .DI(bus_wrdata[31:16]),
        .DO(blk10_rddata[31:16]),
        .MASKWE({{2{bus_wrbytesel[3]}}, {2{bus_wrbytesel[2]}}}),
        .WE(bus_write && blk10_cs),
        .CS(1'b1),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1));

    SP256K blk2(
        .CK(clk),
        .AD(bus_addr[13:0]),
        .DI(bus_wrdata[15:0]),
        .DO(blk32_rddata[15:0]),
        .MASKWE({{2{bus_wrbytesel[1]}}, {2{bus_wrbytesel[0]}}}),
        .WE(bus_write && blk32_cs),
        .CS(1'b1),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1));

    SP256K blk3(
        .CK(clk),
        .AD(bus_addr[13:0]),
        .DI(bus_wrdata[31:16]),
        .DO(blk32_rddata[31:16]),
        .MASKWE({{2{bus_wrbytesel[3]}}, {2{bus_wrbytesel[2]}}}),
        .WE(bus_write && blk32_cs),
        .CS(1'b1),
        .STDBY(1'b0),
        .SLEEP(1'b0),
        .PWROFF_N(1'b1));
`endif

endmodule
