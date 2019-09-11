`default_nettype none

module uart_rx(
    input  wire        clk,
    input  wire        rst,

    input  wire [15:0] baudrate_div,

    input  wire        uart_rxd,
    output reg  [7:0]  rx_data,
    output reg         rx_valid);

    // Synchronize input signal
    reg [3:0] rxd_r;
    always @(posedge clk) rxd_r <= {rxd_r[2:0], uart_rxd};
    wire rx_in = rxd_r[2];
    wire start_condition = (rxd_r[3:2] == 'b10);


    // Receive logic
    reg [15:0] clk_cnt_r;
    reg  [3:0] bit_cnt_r;
    reg  [7:0] shift_r;
    reg started_r;

    wire middle_of_bit = (clk_cnt_r == baudrate_div);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            started_r <= 0;
            rx_valid  <= 0;
            shift_r   <= 0;
            rx_data   <= 0;
            clk_cnt_r <= 0;
            bit_cnt_r <= 0;

        end else begin
            rx_valid  <= 0;
            if (middle_of_bit) begin
                clk_cnt_r <= 0;
            end else begin
                clk_cnt_r <= clk_cnt_r + 'd1;
            end

            if (!started_r) begin
                clk_cnt_r <= {1'b0, baudrate_div[15:1]};
                bit_cnt_r <= 4'd0;

                // Wait for middle of start bit to synchronize
                if (start_condition) begin
                    started_r <= 1;
                end

            end else if (middle_of_bit) begin
                shift_r   <= {rx_in, shift_r[7:1]};
                bit_cnt_r <= bit_cnt_r + 1;

                if (bit_cnt_r == 4'd9) begin
                    started_r <= 0;

                    if (rx_in) begin
                        rx_data  <= shift_r;
                        rx_valid <= 1;
                    end
                end
            end
        end
    end

endmodule
