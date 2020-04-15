//`default_nettype none

module audio_fifo(
    input  wire       clk,
    input  wire       rst,

    input  wire [7:0] wrdata,
    input  wire       wr_en,

    output reg  [7:0] rddata,
    input  wire       rd_en,
    
    output wire       empty,
    output wire       almost_empty,
    output wire       full);

    reg [11:0] wridx_r = 0;
    reg [11:0] rdidx_r = 0;

    reg [7:0] mem_r [4095:0];

    wire [11:0] wridx_next = wridx_r + 12'd1;
    wire [11:0] rdidx_next = rdidx_r + 12'd1;
    wire [11:0] fifo_count = wridx_r - rdidx_r;

    assign empty        = (wridx_r == rdidx_r);
    assign full         = (wridx_next == rdidx_r);
    assign almost_empty = fifo_count < 12'd1024;

    always @(posedge clk) begin
        if (rst) begin
            wridx_r <= 0;
            rdidx_r <= 0;
            rddata <= 0;

        end else begin
            if (wr_en && !full) begin
                mem_r[wridx_r] <= wrdata;
                wridx_r <= wridx_next;
            end

            if (rd_en && !empty) begin
                rddata <= mem_r[rdidx_r];
                rdidx_r <= rdidx_next;
            end
        end
    end

endmodule
