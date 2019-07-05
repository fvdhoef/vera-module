`default_nettype none

module video_vga(
    input  wire        rst,
    input  wire        clk,

    // Line buffer / palette interface
    output wire  [9:0] linebuf_idx,
    input  wire [11:0] linebuf_rgb_data,

    output wire        start_of_screen,
    output wire        start_of_line,

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

    assign start_of_screen = h_last && v_last;
    assign start_of_line   = h_last;

    assign linebuf_idx = x_counter;

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
            vga_hsync <= 0;
            vga_vsync <= 0;

        end else begin
            if (active_r[1]) begin
                vga_r <= linebuf_rgb_data[11:8];
                vga_g <= linebuf_rgb_data[7:4];
                vga_b <= linebuf_rgb_data[3:0];
            end else begin
                vga_r <= 4'd0;
                vga_g <= 4'd0;
                vga_b <= 4'd0;
            end

            vga_hsync <= hsync_r[1];
            vga_vsync <= vsync_r[1];
        end
    end

endmodule
