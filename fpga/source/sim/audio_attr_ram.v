// `default_nettype none
module audio_attr_ram(
    input  wire        wr_clk_i,
    input  wire        rd_clk_i,
    input  wire        wr_clk_en_i,
    input  wire        rd_en_i,
    input  wire        rd_clk_en_i,
    input  wire        wr_en_i,
    input  wire  [7:0] wr_data_i,
    input  wire  [5:0] wr_addr_i,
    input  wire  [3:0] rd_addr_i,
    output reg  [31:0] rd_data_o);

    reg [31:0] mem[0:15];

    always @(posedge wr_clk_i) begin
        if (wr_en_i) begin
            if (wr_addr_i[1:0] == 2'd0) mem[wr_addr_i[5:2]][7:0]   <= wr_data_i;
            if (wr_addr_i[1:0] == 2'd1) mem[wr_addr_i[5:2]][15:8]  <= wr_data_i;
            if (wr_addr_i[1:0] == 2'd2) mem[wr_addr_i[5:2]][23:16] <= wr_data_i;
            if (wr_addr_i[1:0] == 2'd3) mem[wr_addr_i[5:2]][31:24] <= wr_data_i;
        end
    end

    always @(posedge rd_clk_i) begin
        rd_data_o <= mem[rd_addr_i];
    end

    initial begin: INIT
        integer i;
        for (i=0; i<16; i=i+1) begin
            mem[i] = 0;
        end
    end

endmodule
