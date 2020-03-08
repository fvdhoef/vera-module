`default_nettype none

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

    reg [12:0] wridx = 0;
    reg [12:0] rdidx = 0;

    reg [7:0] mem_r [8191:0];

    wire [12:0] wridx_next = wridx + 13'd1;
    wire [12:0] rdidx_next = rdidx + 13'd1;
    wire [12:0] fifo_count = wridx - rdidx;

    assign empty = (wridx == rdidx);
    assign full  = (wridx_next == rdidx);
    assign almost_empty = fifo_count < 13'd512;

    always @(posedge clk) begin
        if (rst) begin
            wridx <= 0;
            rdidx <= 0;
            rddata <= 0;

        end else begin
            if (wr_en && !full) begin
                mem_r[wridx] <= wrdata;
                wridx <= wridx_next;
            end

            rddata <= mem_r[rdidx];
            if (rd_en && !empty) begin
                rdidx <= rdidx_next;
            end
        end
    end

endmodule
