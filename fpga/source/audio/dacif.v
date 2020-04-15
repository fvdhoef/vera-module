//`default_nettype none

module dacif(
    input  wire        rst,
    input  wire        clk,

    // Sample input
    output wire        next_sample,
    input  wire [23:0] left_data,       // 2's complement signed left data
    input  wire [23:0] right_data,      // 2's complement signed right data

    // I2S audio output
    output reg         i2s_lrck,
    output wire        i2s_bck,
    output wire        i2s_data);

    // Generate LRCK
    reg  [7:0] div_r;
    wire [7:0] div_max = 8'd255;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            div_r    <= 'd0;
            i2s_lrck <= 0;
        end else begin
            if (div_r == div_max) begin
                i2s_lrck <= !i2s_lrck;
                div_r    <= 0;
            end else begin
                div_r <= div_r + 8'd1;
            end
        end
    end

    reg lrck_r;
    always @(posedge clk) lrck_r <= i2s_lrck;

    // Generate BCK
    reg bck_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bck_r <= 0;
        end else begin
            bck_r <= !bck_r;
        end
    end

    assign i2s_bck = bck_r;

    // Generate start signals
    wire start_left  = lrck_r  && !i2s_lrck;
    wire start_right = !lrck_r && i2s_lrck;
    assign next_sample = start_left;

    // Shift register and sample buffer
    reg [23:0] right_sample_r;
    reg [24:0] shiftreg_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shiftreg_r     <= 0;
            right_sample_r <= 0;
        end else begin
            if (bck_r) begin
                shiftreg_r <= {shiftreg_r[23:0], 1'b0};
            end

            if (start_left) begin
                shiftreg_r     <= {1'b0, left_data};
                right_sample_r <= right_data;
            end
            if (start_right) begin
                shiftreg_r     <= {1'b0, right_sample_r};
            end
        end
    end

    assign i2s_data  = shiftreg_r[24];

endmodule
