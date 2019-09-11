`default_nettype none

module uart_rx_fifo(
    input  wire       clk,
    input  wire       rst,

    input  wire [7:0] wrdata,
    input  wire       wr_en,

    output reg  [7:0] rddata,
    input  wire       rd_en,
    
    output wire       empty,
    output wire       full);

    reg [8:0] wridx = 0, rdidx = 0;

    reg [7:0] mem_r [511:0];

    wire [8:0] wridx_next = wridx + 9'd1;
    wire [8:0] rdidx_next = rdidx + 9'd1;

    assign empty = wridx == rdidx;
    assign full = wridx_next == rdidx;

    always @(posedge clk) begin
        if (wr_en && !full) begin
            mem_r[wridx] <= wrdata;
            wridx <= wridx_next;
        end

        rddata <= mem_r[rdidx];
        if (rd_en && !empty) begin
            rdidx <= rdidx_next;
        end
    end

endmodule
