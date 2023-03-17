//`default_nettype none

module video_vga(
    input  wire        rst,
    input  wire        clk,

    // Palette interface
    input  wire [11:0] palette_rgb_data,

    output wire        next_frame,
    output wire        next_line,
    output wire        next_pixel,
    output wire        vblank_pulse,

    // VGA interface
    output reg   [3:0] vga_r,
    output reg   [3:0] vga_g,
    output reg   [3:0] vga_b,
    output reg         vga_hsync,
    output reg         vga_vsync);

    assign next_pixel = 1'b1;

    //
    // Video timing (640x480@60Hz)
    //
    parameter H_ACTIVE      = 640;
    parameter H_FRONT_PORCH = 16;
    parameter H_SYNC        = 96;
    parameter H_BACK_PORCH  = 48;
    parameter H_TOTAL       = H_ACTIVE + H_FRONT_PORCH + H_SYNC + H_BACK_PORCH;

    parameter V_ACTIVE      = 480;
    parameter V_FRONT_PORCH = 10;
    parameter V_SYNC        = 2;
    parameter V_BACK_PORCH  = 33;
    parameter V_TOTAL       = V_ACTIVE + V_FRONT_PORCH + V_SYNC + V_BACK_PORCH;

    reg [9:0] x_counter = 0;
    reg [9:0] y_counter = 0;

    wire h_last = (x_counter == H_TOTAL - 1);
    wire v_last = (y_counter == V_TOTAL - 1);
    wire v_last2 = (y_counter == V_TOTAL - 2);  // Start rendering one line earlier

    always @(posedge clk or posedge rst) begin
        if (rst) begin
`ifdef __ICARUS__
            x_counter <= 10'd750;
            y_counter <= 10'd523;
`else
            x_counter <= 10'd0;
            y_counter <= 10'd0;
`endif

        end else begin
            x_counter <= h_last ? 10'd0 : (x_counter + 10'd1);
            if (h_last)
                y_counter <= v_last ? 10'd0 : (y_counter + 10'd1);
        end
    end

    wire hsync    = (x_counter >= H_ACTIVE + H_FRONT_PORCH && x_counter < H_ACTIVE + H_FRONT_PORCH + H_SYNC);
    wire vsync    = (y_counter >= V_ACTIVE + V_FRONT_PORCH && y_counter < V_ACTIVE + V_FRONT_PORCH + V_SYNC);
    wire h_active = (x_counter < H_ACTIVE);
    wire v_active = (y_counter < V_ACTIVE);
    wire active   = h_active && v_active;

    assign vblank_pulse = h_last && (y_counter == V_ACTIVE - 1);

    assign next_frame = h_last && v_last2;
    assign next_line = h_last;

    // Compensate pipeline delays
    reg [1:0] hsync_r, vsync_r, active_r;
    always @(posedge clk) hsync_r  <= {hsync_r[0], hsync};
    always @(posedge clk) vsync_r  <= {vsync_r[0], vsync};
    always @(posedge clk) active_r <= {active_r[0], active};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            vga_r <= 4'd0;
            vga_g <= 4'd0;
            vga_b <= 4'd0;
            vga_hsync <= 1;
            vga_vsync <= 1;

        end else begin
            if (active_r[1]) begin
                vga_r <= palette_rgb_data[11:8];
                vga_g <= palette_rgb_data[7:4];
                vga_b <= palette_rgb_data[3:0];
            end else begin
                vga_r <= 4'd0;
                vga_g <= 4'd0;
                vga_b <= 4'd0;
            end

            vga_hsync <= ~hsync_r[1];
            vga_vsync <= ~vsync_r[1];
        end
    end

endmodule
