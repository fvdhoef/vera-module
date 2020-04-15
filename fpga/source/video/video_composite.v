//`default_nettype none

module video_composite(
    input  wire        rst,
    input  wire        clk,

    // Line buffer / palette interface
    input  wire [11:0] palette_rgb_data,

    output wire        next_frame,
    output wire        next_line,
    output wire        next_pixel,
    output wire        vblank_pulse,
    output wire        current_field,

    // Composite interface
    output wire  [5:0] luma,
    output wire  [5:0] chroma,
    
    // RGB interface
    output wire  [3:0] rgb_r,
    output wire  [3:0] rgb_g,
    output wire  [3:0] rgb_b,
    output wire        rgb_sync_n);

    //
    // Video timing (NTSC 60Hz)
    //
    parameter H_SYNC            = 118;
    parameter H_BACK_PORCH      = 152;
    parameter H_ACTIVE          = 1280;
    parameter H_FRONT_PORCH     = 38;
    parameter H_TOTAL           = H_SYNC + H_BACK_PORCH + H_ACTIVE + H_FRONT_PORCH;

    parameter H_HALF                   = H_TOTAL / 2;
    parameter H_VSYNC_PULSE_LEN        = 678;
    parameter H_EQUALIZATION_PULSE_LEN = 58;

    parameter H_COLOR_BURST_START      = 132;
    parameter H_COLOR_BURST_END        = 196;


    reg [10:0] hcnt = 0;

    wire h_hsync_pulse = (hcnt < H_SYNC);

    wire h_vsync_pulse =
        (hcnt >= 0      && hcnt < H_VSYNC_PULSE_LEN) ||
        (hcnt >= H_HALF && hcnt < H_HALF + H_VSYNC_PULSE_LEN);

    wire h_equalization_pulse =
        (hcnt >= 0      && hcnt < H_EQUALIZATION_PULSE_LEN) ||
        (hcnt >= H_HALF && hcnt < H_HALF + H_EQUALIZATION_PULSE_LEN);

    wire h_color_burst =
        (hcnt >= H_COLOR_BURST_START && hcnt < H_COLOR_BURST_END);

    wire h_active         = (hcnt >= H_SYNC + H_BACK_PORCH && hcnt < H_SYNC + H_BACK_PORCH + H_ACTIVE);
    wire h_last           = (hcnt == H_TOTAL - 1);
    wire h_half_line_last = (hcnt == H_HALF - 1) || h_last;

    // Vertical video timing (NTSC 60Hz):
    //
    // field1 (even):
    //      0-5 equalization
    //     6-11 vsync
    //    12-17 equalization
    //    18-37 blank active
    //   38-524 active     (243,5 lines)
    //
    // field2 (odd):
    //  525-530 equalization
    //  531-536 vsync
    //  537-542 equalization
    //  543-562 blank active
    // 563-1049 active     (243,5 lines)

    reg [10:0] vcnt = 0;  // half-lines
    wire v_sync =
        (vcnt >=   6 && vcnt <=  11) ||
        (vcnt >= 531 && vcnt <= 536);

    wire v_equalization =
        (vcnt >=   0 && vcnt <=   5) ||
        (vcnt >=  12 && vcnt <=  17) ||
        (vcnt >= 525 && vcnt <= 530) ||
        (vcnt >= 537 && vcnt <= 542);
    
    wire v_active =
        (vcnt >=   38+4 && vcnt <=  524-3) ||   // 240 lines
        (vcnt >=  563+5 && vcnt <= 1049-2);     // 240 lines
    
    reg field; // 0: even, 1: odd

    wire v_last2           = (vcnt == 38+3 || vcnt == 563+4);
    wire v_last            = (vcnt == 1049);
    wire v_even_field_last = (vcnt == 524);

    assign next_line     = (hcnt == H_SYNC + H_BACK_PORCH - 1);

    reg current_field_r;
    reg next_frame_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            next_frame_r    <= 0;
            current_field_r <= 0;
        end else begin
            if (h_last && v_last2) begin
                next_frame_r    <= 1;
                current_field_r <= field;

            end else if (next_line) begin
                next_frame_r    <= 0;
            end
        end
    end
    assign next_frame = next_frame_r && next_line;
    assign current_field = current_field_r;


    assign vblank_pulse  = h_last && (vcnt == 524 || vcnt == 1049);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            hcnt <= 0;
            vcnt <= 0;

        end else begin
            hcnt <= h_last ? 11'd0 : hcnt + 11'd1;
            if (h_half_line_last) begin
                vcnt <= v_last ? 11'd0 : vcnt + 11'd1;
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            field <= 0;

        end else begin
            if (h_half_line_last && v_last) begin
                field <= 1;
            end else if (h_half_line_last && v_even_field_last) begin
                field <= 0;
            end
        end
    end

    reg mod_sync_n;
    always @* begin
        if (v_sync) begin
            mod_sync_n = !h_vsync_pulse;
        end else if (v_equalization) begin
            mod_sync_n = !h_equalization_pulse;
        end else begin
            mod_sync_n = !h_hsync_pulse;
        end
    end


    assign next_pixel = h_active;

    wire [3:0] r = palette_rgb_data[11:8];
    wire [3:0] g = palette_rgb_data[7:4];
    wire [3:0] b = palette_rgb_data[3:0];

    video_modulator modulator(
        .clk(clk),

        .r(r),
        .g(g),
        .b(b),
        .color_burst(v_active && h_color_burst),
        .active(v_active && h_active),
        .sync_n_in(mod_sync_n),

        .luma(luma),
        .chroma(chroma));

    assign rgb_r = r;
    assign rgb_g = g;
    assign rgb_b = b;
    assign rgb_sync_n = mod_sync_n;

endmodule
