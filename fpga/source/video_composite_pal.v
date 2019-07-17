`default_nettype none

module video_composite(
    input  wire        rst,
    input  wire        clk,

    // Composite interface
    output reg   [3:0] luma,
    output reg         sync_n,
    output reg   [3:0] chroma);

    //
    // Video timing (PAL 50Hz)
    //
    parameter H_SYNC            = 118;
    parameter H_BACK_PORCH      = 140;
    parameter H_ACTIVE          = 1300;
    parameter H_FRONT_PORCH     = 42;
    parameter H_TOTAL           = H_SYNC + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH;

    parameter H_HALF                   = H_TOTAL / 2;
    parameter H_VSYNC_PULSE_LEN        = 682;
    parameter H_EQUALIZATION_PULSE_LEN = 59;
    
    parameter V_SYNC_LEN              = 5;
    parameter V_POST_EQUALIZATION_LEN = 5 + V_SYNC_LEN;
    parameter V_PREACTIVE_LEN         = 34 + V_POST_EQUALIZATION_LEN;
    parameter V_ACTIVE_LEN            = 576 + V_PREACTIVE_LEN;
    parameter V_PRE_EQUALIZATION_LEN  = 4 + V_ACTIVE_LEN;


    reg [10:0] hcnt = 0;

    wire h_hsync_pulse = (hcnt < H_SYNC);

    wire h_vsync_pulse =
        (hcnt >= 0      && hcnt < H_VSYNC_PULSE_LEN) ||
        (hcnt >= H_HALF && hcnt < H_HALF + H_VSYNC_PULSE_LEN);

    wire h_equalization_pulse =
        (hcnt >= 0      && hcnt < H_EQUALIZATION_PULSE_LEN) ||
        (hcnt >= H_HALF && hcnt < H_HALF + H_EQUALIZATION_PULSE_LEN);

    wire h_active         = (hcnt >= H_SYNC + H_BACK_PORCH && hcnt < H_SYNC + H_BACK_PORCH + H_ACTIVE);
    wire h_last           = (hcnt == H_TOTAL - 1);
    wire h_half_line_last = (hcnt == H_HALF - 1) || h_last;

    // Vertical video timing (PAL 50Hz):
    //
    // field1 (even):
    //      0-4 vsync
    //      5-9 equalization
    //    10-45 blank active
    //   46-619 active
    //  620-624 equalization
    //
    // field2 (odd):
    //   625-629 vsync
    //   630-634 equalization
    //   635-669 blank active
    //  670-1243 active
    //      1244 blank
    // 1245-1249 equalization

    reg [10:0] vcnt = 0;  // half-lines
    wire v_sync =
        (vcnt >=    0 && vcnt <=    4) ||
        (vcnt >=  625 && vcnt <=  629);

    wire v_equalization =
        (vcnt >=    5 && vcnt <=    9) ||
        (vcnt >=  620 && vcnt <=  624) ||
        (vcnt >=  630 && vcnt <=  634) ||
        (vcnt >= 1245 && vcnt <= 1249);
    
    wire v_active =
        (vcnt >=   46 && vcnt <=  619) ||
        (vcnt >=  670 && vcnt <= 1243);
    
    reg field; // 0: even, 1: odd

    wire v_last = (vcnt == 1249);
    wire v_even_field_last = (vcnt == 624);

    reg [8:0] field_line_cnt;
    wire [9:0] frame_line_cnt = {field_line_cnt, field};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            hcnt <= 0;
            vcnt <= 0;
            field <= 0;
            field_line_cnt <= 0;

        end else begin
            hcnt <= h_last ? 0 : hcnt + 1;
            if (h_half_line_last) begin
                vcnt <= v_last ? 0 : vcnt + 1;
            end

            if (h_half_line_last && v_last) begin
                field <= 0;
                field_line_cnt <= 0;
            end else if (h_half_line_last && v_even_field_last) begin
                field <= 1;
                field_line_cnt <= 0;
            end else if (h_last) begin
                field_line_cnt <= field_line_cnt + 1;
            end

        end
    end


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            luma   <= 4'd0;
            sync_n <= 1'd0;
            chroma <= 4'd0;

        end else begin
            luma   <= 0;
            chroma <= 0;

            if (v_active && h_active) begin
                luma <= hcnt[7:4] ^ frame_line_cnt[6:3];
            end

            if (v_sync) begin
                sync_n <= !h_vsync_pulse;

            end else if (v_equalization) begin
                sync_n <= !h_equalization_pulse;

            end else begin
                sync_n <= !h_hsync_pulse;
            end
        end
    end

    // PAL color
    //
    // Y' = 0.299 * R + 0.587 * G + 0.114 * B
    // U  = 0.492 * (B - Y')
    // V  = 0.877 * (R - Y')
    //
    // C = sin(2*pi*fc*t) * U + cos(2*pi*fc*t) * V
    // fc = 4.43361875MHz


endmodule
