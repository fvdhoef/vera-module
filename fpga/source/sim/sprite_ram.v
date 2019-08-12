`default_nettype none

module sprite_ram(
    input  wire        wr_clk_i,
    input  wire        rd_clk_i,
    input  wire        wr_clk_en_i,
    input  wire        rd_en_i,
    input  wire        rd_clk_en_i,
    input  wire        wr_en_i,
    input  wire  [5:0] ben_i,
    input  wire [47:0] wr_data_i,
    input  wire  [7:0] wr_addr_i,
    input  wire  [7:0] rd_addr_i,
    output reg  [47:0] rd_data_o);

    reg [47:0] mem[0:255];

    always @(posedge wr_clk_i) begin
        if (wr_en_i) begin
            if (ben_i[5]) mem[wr_addr_i][47:40] <= wr_data_i[47:40];
            if (ben_i[4]) mem[wr_addr_i][39:32] <= wr_data_i[39:32];
            if (ben_i[3]) mem[wr_addr_i][31:24] <= wr_data_i[31:24];
            if (ben_i[2]) mem[wr_addr_i][23:16] <= wr_data_i[23:16];
            if (ben_i[1]) mem[wr_addr_i][15:8]  <= wr_data_i[15:8];
            if (ben_i[0]) mem[wr_addr_i][7:0]   <= wr_data_i[7:0];
        end
    end

    always @(posedge rd_clk_i) begin
        rd_data_o <= mem[rd_addr_i];
    end

    initial begin: INIT
        integer i;
        for (i=0; i<256; i=i+1) begin
            mem[i] = 0;
        end

        mem[0][9:0]   = 10'd0; // x
        mem[0][10]    = 0;     // vflip
        mem[0][11]    = 0;     // hflip
        mem[0][15:12] = 0;     // palette_offset
        mem[0][24:16] = 9'd3;  // y
        mem[0][25]    = 0;     // mode

        mem[0][27:26] = 0;     // reserved

        mem[0][29:28] = 4'd3;  // height
        mem[0][31:30] = 4'd0;  // width
        mem[0][45:32] = 0;     // addr
        mem[0][47:46] = 3'd1;  // z

    end

endmodule
