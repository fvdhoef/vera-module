`default_nettype none

module spictrl(
    input  wire       rst,
    input  wire       clk,
    
    // Register interface
    input  wire [7:0] txdata,
    input  wire       txstart,
    output wire [7:0] rxdata,
    output wire       busy,
    
    // SPI interface
    output wire       spi_sck,
    output wire       spi_mosi,
    input  wire       spi_miso);

    reg [3:0] bitcnt_r;
    assign busy = (bitcnt_r != 'd0);

    reg [7:0] tx_shift_r, rx_shift_r;

    assign spi_mosi = tx_shift_r[7];
    assign rxdata = rx_shift_r;

    reg clk_r;
    assign spi_sck = clk_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_shift_r <= 0;
            rx_shift_r <= 0;
            bitcnt_r   <= 0;
            clk_r      <= 0;

        end else begin
            if (busy) begin
                clk_r <= !clk_r;
                if (clk_r) begin
                    tx_shift_r <= {tx_shift_r[6:0], 1'b0};
                    bitcnt_r <= bitcnt_r - 4'd1;
                end else begin
                    rx_shift_r <= {rx_shift_r[6:0], spi_miso};
                end

            end else begin
                if (txstart) begin
                    tx_shift_r <= txdata;
                    bitcnt_r <= 4'd8;
                end
            end
        end
    end

endmodule
