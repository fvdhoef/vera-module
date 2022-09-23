//`default_nettype none

module composer(
    input  wire        rst,
    input  wire        clk,

    // Register interface
    input  wire        interlaced,
    input  wire  [7:0] frac_x_incr,
    input  wire  [7:0] frac_y_incr,
    input  wire  [7:0] border_color,
    input  wire  [9:0] active_hstart,
    input  wire  [9:0] active_hstop,
    input  wire  [8:0] active_vstart,
    input  wire  [8:0] active_vstop,
    input  wire  [8:0] irqline,
    input  wire        layer0_enabled,
    input  wire        layer1_enabled,
    input  wire        sprites_enabled,

    output reg         current_field,
    output reg         line_irq,

    output wire [8:0]  scanline,

    // Render interface
    output wire  [8:0] line_idx,
    output wire        line_render_start,
    output wire  [9:0] lb_rdidx,
    input  wire  [7:0] layer0_lb_rddata,
    input  wire  [7:0] layer1_lb_rddata,
    input  wire [15:0] sprite_lb_rddata,
    output wire        sprite_lb_erase_start,

    // Display interface
    input  wire        display_next_frame,
    input  wire        display_next_line,
    input  wire        display_next_pixel,
    input  wire        display_current_field,
    output reg   [7:0] display_data);

    // Interlaced modes have double the amount of horizontal clocks
    wire [7:0] frac_x_incr_int = interlaced ? {1'b0, frac_x_incr[7:1]} : frac_x_incr;

    //////////////////////////////////////////////////////////////////////////
    // Composer
    //////////////////////////////////////////////////////////////////////////
    reg [16:0] scaled_x_counter_r;
    wire [9:0] scaled_x_counter = scaled_x_counter_r[16:7];

    reg [15:0] scaled_y_counter_r;
    wire [8:0] scaled_y_counter = scaled_y_counter_r[15:7];

    reg render_start_r;

    // Output control signals to other units
    assign line_idx          = scaled_y_counter;
    assign line_render_start = render_start_r;
    assign lb_rdidx          = scaled_x_counter;

    wire layer0_opaque = layer0_lb_rddata[7:0] != 8'h0;
    wire layer1_opaque = layer1_lb_rddata[7:0] != 8'h0;
    wire sprite_opaque = sprite_lb_rddata[7:0] != 8'h0;

    wire sprite_z1 = sprite_lb_rddata[9:8] == 2'd1;
    wire sprite_z2 = sprite_lb_rddata[9:8] == 2'd2;
    wire sprite_z3 = sprite_lb_rddata[9:8] == 2'd3;

    // Regular vertical counter
    reg  [9:0] y_counter_r, y_counter_rr;
    reg  next_line_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_counter_r   <= 0;
            y_counter_rr  <= 0;
            next_line_r   <= 0;
            current_field <= 0;
        end else begin
            next_line_r <= display_next_line;
            if (display_next_line) begin
                // Interlaced mode skips every other line
                y_counter_r  <= y_counter_r + (interlaced ? 9'd2 : 9'd1);

                y_counter_rr <= y_counter_r;
            end
            if (display_next_frame) begin
                current_field <= !display_current_field;

                // Interlaced mode starts at either the even or odd line
                y_counter_r <= (interlaced && !display_current_field) ? 9'd1 : 9'd0;
            end
        end
    end

    // Generate line irq
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            line_irq <= 0;

        end else begin
            line_irq <= display_next_line && (
                (!interlaced && y_counter_r == irqline) ||
                ( interlaced && y_counter_r[8:1] == irqline[8:1]));
        end
    end

    // Regular horizontal counter
    reg [10:0] x_counter_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x_counter_r <= 0;
        end else begin
            if (display_next_pixel) begin
                x_counter_r <= x_counter_r + (interlaced ? 11'd1 : 11'd2);
            end
            if (display_next_line) begin
                x_counter_r <= 0;
            end
        end
    end

    wire [9:0] x_counter = x_counter_r[10:1];
    wire [9:0] y_counter = y_counter_rr;

    // Peg scanline at 511 for lines 512-524
    assign scanline = y_counter[9] == 1 ? 9'b1_1111_1111 : y_counter_r[8:0];

    // Generate start signal of sprite line buffer clearing
    assign sprite_lb_erase_start = (x_counter_r == {10'd639, interlaced});

    // Determine the active area of the screen where the border isn't shown
    wire hactive = (x_counter >= active_hstart) && (x_counter < active_hstop);
    wire vactive = (y_counter >= active_vstart) && (y_counter < active_vstop);
    reg display_active;
    always @(posedge clk) display_active = hactive && vactive;

    // Scaled vertical counter
    reg vactive_started_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            scaled_y_counter_r <= 'd0;
            render_start_r     <= 0;
            vactive_started_r  <= 0;

        end else begin
            render_start_r <= 0;

            if (next_line_r) begin
                if (!vactive_started_r && next_line_r && y_counter_r >= active_vstart) begin
                    vactive_started_r  <= 1;
                    render_start_r     <= 1;

                    // Start line is dependent of current field in interlaced mode
                    scaled_y_counter_r <= (interlaced && (current_field ^ active_vstart[0])) ? {8'b0, frac_y_incr} : 16'd0;

                end else if (scaled_y_counter < 'd480 && vactive) begin
                    render_start_r     <= 1;

                    // In interlaced modes we increment with twice the amount
                    scaled_y_counter_r <= scaled_y_counter_r + (interlaced ? {7'b0, frac_y_incr, 1'b0} : {8'b0, frac_y_incr});
                end
            end

            if (display_next_frame) begin
                vactive_started_r <= 0;
            end
        end
    end

    // Scaled horizontal counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            scaled_x_counter_r <= 'd0;

        end else begin
            if (display_next_pixel && hactive) begin
                if (scaled_x_counter < 'd640) begin
                    scaled_x_counter_r <= scaled_x_counter_r + frac_x_incr_int;
                end
            end
            
            if (display_next_line) begin
                scaled_x_counter_r <= 0;
            end
        end
    end

    // Compose the display
    always @* begin
        display_data = border_color;

        if (display_active) begin
            display_data = 8'h00;
            if (sprites_enabled && sprite_opaque && sprite_z1) display_data = sprite_lb_rddata[7:0];
            if (layer0_enabled  && layer0_opaque)              display_data = layer0_lb_rddata;
            if (sprites_enabled && sprite_opaque && sprite_z2) display_data = sprite_lb_rddata[7:0];
            if (layer1_enabled  && layer1_opaque)              display_data = layer1_lb_rddata;
            if (sprites_enabled && sprite_opaque && sprite_z3) display_data = sprite_lb_rddata[7:0];
        end
    end

endmodule
