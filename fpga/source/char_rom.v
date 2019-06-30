`default_nettype none

module char_rom(
    input  wire        clk,

    input  wire [11:0] rd_addr,
    output reg   [7:0] rd_data);

    reg [7:0] mem_r[0:4095];

    always @(posedge clk) begin
        rd_data <= mem_r[rd_addr];
    end

    initial begin
        `ifdef __ICARUS__
            $readmemh("../char_rom.mem", mem_r);
        `else
            $readmemh("source/char_rom.mem", mem_r);
        `endif
    end

endmodule
