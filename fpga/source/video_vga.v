`default_nettype none

module video_vga(
    input  wire        rst,
    input  wire        clk,

    input  wire  [1:0] pixel_width,
    input  wire  [1:0] pixel_height,

    // Line buffer / palette interface
    output reg  [10:0] linebuf_idx,
    input  wire [11:0] linebuf_rgb_data,

    // VGA interface
    output reg   [3:0] vga_r,
    output reg   [3:0] vga_g,
    output reg   [3:0] vga_b,
    output reg         vga_hsync,
    output reg         vga_vsync);

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

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x_counter <= 10'd0;
            y_counter <= 10'd0;

        end else begin
            x_counter <= h_last ? 0 : (x_counter + 1);
            if (h_last)
                y_counter <= v_last ? 0 : (y_counter + 1);
        end
    end

    wire hsync    = (x_counter >= H_ACTIVE + H_FRONT_PORCH && x_counter < H_ACTIVE + H_FRONT_PORCH + H_SYNC);
    wire vsync    = (y_counter >= V_ACTIVE + V_FRONT_PORCH && y_counter < V_ACTIVE + V_FRONT_PORCH + V_SYNC);
    wire h_active = (x_counter < H_ACTIVE);
    wire v_active = (y_counter < V_ACTIVE);
    wire active   = h_active && v_active;

    // Line buffer logic
    reg [1:0] pixel_width_cnt_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            linebuf_idx <= 11'd0;
            pixel_width_cnt_r <= 0;

        end else begin
            if (pixel_width_cnt_r == 0) begin
                pixel_width_cnt_r <= pixel_width;

                linebuf_idx <= linebuf_idx + 1;
            end else begin
                pixel_width_cnt_r <= pixel_width_cnt_r - 1;
            end

            if (h_last) begin
                linebuf_idx <= 0;
                pixel_width_cnt_r <= pixel_width;
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            vga_r <= 4'd0;
            vga_g <= 4'd0;
            vga_b <= 4'd0;
            vga_hsync <= 0;
            vga_vsync <= 0;

        end else begin
            if (active) begin
                vga_r <= linebuf_rgb_data[11:8];
                vga_g <= linebuf_rgb_data[7:4];
                vga_b <= linebuf_rgb_data[3:0];
            end else begin
                vga_r <= 4'd0;
                vga_g <= 4'd0;
                vga_b <= 4'd0;
            end

            vga_hsync <= hsync;
            vga_vsync <= vsync;
        end
    end

endmodule
