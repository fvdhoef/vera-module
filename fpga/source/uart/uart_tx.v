`default_nettype none

module uart_tx(
    input  wire        clk,    // 12MHz system clock
    input  wire        rst,

    input  wire [15:0] baudrate_div,

    output reg         uart_txd,
    input  wire  [7:0] tx_data,
    input  wire        tx_valid,
    output wire        tx_busy);

    // Baudrate generator
    reg [15:0] tx_baudrate_cnt_r;
    reg next_bit;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_baudrate_cnt_r <= 0;
            next_bit <= 0;
        end else begin
            next_bit <= 0;
            if (tx_baudrate_cnt_r >= baudrate_div) begin
                tx_baudrate_cnt_r <= 0;
                next_bit <= 1;
            end else begin
                tx_baudrate_cnt_r <= tx_baudrate_cnt_r + 1;
            end
        end
    end

    // Shift out serial data
    reg [8:0] tx_shift_r;
    reg [3:0] bit_cnt_r;
    reg busy;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            uart_txd <= 1'b1;
            busy <= 1'b0;
            tx_shift_r <= 9'b0;
            bit_cnt_r <= 4'b0;

        end else begin
            if (!busy) begin
                if (tx_valid) begin
                    tx_shift_r <= { tx_data, 1'b0 };
                    busy <= 1'b1;
                    bit_cnt_r <= 4'd9;
                end

            end else if (next_bit) begin
                if (bit_cnt_r == 4'd0) begin
                    busy <= 1'b0;
                end else begin
                    bit_cnt_r <= bit_cnt_r - 4'd1;
                end

                uart_txd <= tx_shift_r[0];
                tx_shift_r <= { 1'b1, tx_shift_r[8:1] };
            end
        end
    end

    assign tx_busy = busy;

endmodule
