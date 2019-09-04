`default_nettype none

module sprite_ram(
    input  wire        wr_clk_i,
    input  wire        rd_clk_i,
    input  wire        wr_clk_en_i,
    input  wire        rd_en_i,
    input  wire        rd_clk_en_i,
    input  wire        wr_en_i,
    input  wire  [3:0] ben_i,
    input  wire [31:0] wr_data_i,
    input  wire  [7:0] wr_addr_i,
    input  wire  [7:0] rd_addr_i,
    output reg  [31:0] rd_data_o);

    reg [31:0] mem[0:255];

    always @(posedge wr_clk_i) begin
        if (wr_en_i) begin
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

        mem[2][11:0]  = 'h100;   // addr
        mem[2][15]    = 1;       // mode
        mem[2][25:16] = 10'd60;  // x
        mem[3][9:0]   = 10'd3;   // y
        mem[3][16]    = 0;       // hflip
        mem[3][17]    = 0;       // vflip
        mem[3][19:18] = 3'd1;    // z
        mem[3][23:20] = 0;       // collision mask
        mem[3][27:24] = 0;       // palette offset
        mem[3][29:28] = 2'd2;    // width
        mem[3][31:30] = 2'd1;    // height

        // mem[10][9:0]   = 10'd200; // x
        // mem[10][10]    = 0;      // hflip
        // mem[10][11]    = 0;      // vflip
        // mem[10][15:12] = 0;      // palette_offset
        // mem[10][24:16] = 9'd5;   // y
        // mem[10][25]    = 1;      // mode
        // mem[10][27:26] = 3'd1;   // z
        // mem[10][43:32] = 'h100;  // addr
        // mem[10][45:44] = 4'd2;   // width
        // mem[10][47:46] = 4'd1;   // height

    end

endmodule
