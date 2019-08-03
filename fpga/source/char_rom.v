`default_nettype none

module char_rom(
    input  wire        clk,

    input  wire  [9:0] rd_addr,
    output wire [31:0] rd_data);

    wire [8:0] mem_addr = {rd_addr[9], rd_addr[7:0]};

    reg [31:0] mem_r[0:511];

    reg invert_r;
    always @(posedge clk) invert_r <= rd_addr[8];

    reg [31:0] data_r;
    always @(posedge clk) data_r <= mem_r[mem_addr];

    assign rd_data = invert_r ? ~data_r : data_r;

    initial begin
        `ifdef __ICARUS__
            $readmemh("../char_rom.mem", mem_r);
        `else
            $readmemh("source/char_rom.mem", mem_r);
        `endif
    end

endmodule
