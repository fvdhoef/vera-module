`default_nettype none

module spictrl(
    input  wire       rst,
    input  wire       clk,
    
    // Slave bus interface
    input  wire       bus_addr,
    input  wire [7:0] bus_wrdata,
    output wire [7:0] bus_rddata,
    input  wire       bus_sel,
    input  wire       bus_strobe,
    input  wire       bus_write,
    
    // SPI interface
    output wire       spi_sck,
    output wire       spi_mosi,
    input  wire       spi_miso,
    output wire       spi_ssel_n_sd);

    reg [3:0] bitcnt_r;
    wire busy = (bitcnt_r != 'd0);

    wire bus_access = bus_sel && bus_strobe;

    reg bus_access_r;
    always @(posedge clk) bus_access_r <= bus_access;

    // Slave select
    reg ssel_r;
    assign spi_ssel_n_sd = !ssel_r;

    reg [7:0] tx_shift_r, rx_shift_r;

    assign spi_mosi = tx_shift_r[7];

    reg clk_r;
    assign spi_sck = clk_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ssel_r     <= 0;
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
                if (!bus_access_r && bus_access) begin
                    if (bus_write) begin
                        if (bus_addr) begin
                            ssel_r <= bus_wrdata[0];
                        end else begin
                            tx_shift_r <= bus_wrdata;
                            bitcnt_r <= 4'd8;
                        end
                    end
                end
            end
        end
    end

    assign bus_rddata = bus_addr ? {6'b0, busy, ssel_r} : rx_shift_r;

endmodule
