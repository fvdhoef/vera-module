`default_nettype none

module uart(
    input  wire       rst,
    input  wire       clk,

    output wire       irq,
    
    // Slave bus interface
    input  wire [1:0] bus_addr,
    input  wire [7:0] bus_wrdata,
    output reg  [7:0] bus_rddata,
    input  wire       bus_sel,
    input  wire       bus_strobe,
    input  wire       bus_write,

    // UART interface
    input  wire       uart_rxd,
    output wire       uart_txd);

    wire bus_access = bus_sel && bus_strobe;

    wire tx_valid = bus_access && bus_write && bus_addr == 2'd0;
    wire tx_busy;

    wire rx_read = bus_access && !bus_write && bus_addr == 2'd0;

    wire [7:0] rx_fifo_data;
    wire rx_fifo_empty;

    reg [15:0] baudrate_div_r;
    always @* case (bus_addr)
        2'b00: bus_rddata = rx_fifo_data;
        2'b01: bus_rddata = {6'b0, tx_busy, !rx_fifo_empty};
        2'b10: bus_rddata = baudrate_div_r[7:0];
        2'b11: bus_rddata = baudrate_div_r[15:8];
    endcase

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            baudrate_div_r <= 16'd24;
        end else begin
            if (bus_access && bus_write && bus_addr == 2'd2) baudrate_div_r[7:0]  <= bus_wrdata;
            if (bus_access && bus_write && bus_addr == 2'd3) baudrate_div_r[15:8] <= bus_wrdata;
        end
    end

    assign irq = !rx_fifo_empty;

    uart_tx uart_tx(
        .clk(clk),
        .rst(rst),
        .baudrate_div(baudrate_div_r),
        .uart_txd(uart_txd),
        .tx_data(bus_wrdata),
        .tx_valid(tx_valid),
        .tx_busy(tx_busy));

    wire [7:0] rx_data;
    wire rx_valid;

    uart_rx uart_rx(
        .clk(clk),
        .rst(rst),
        .baudrate_div(baudrate_div_r),
        .uart_rxd(uart_rxd),
        .rx_data(rx_data),
        .rx_valid(rx_valid));

    uart_rx_fifo uart_rx_fifo(
        .clk(clk),
        .rst(rst),

        .wrdata(rx_data),
        .wr_en(rx_valid),

        .rddata(rx_fifo_data),
        .rd_en(rx_read),

        .empty(rx_fifo_empty));

endmodule
