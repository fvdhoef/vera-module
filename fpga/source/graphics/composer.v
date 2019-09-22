`default_nettype none

module composer(
    input  wire        rst,
    input  wire        clk,

    output reg         line_irq,

    // Register interface
    input  wire  [4:0] regs_addr,
    input  wire  [7:0] regs_wrdata,
    output reg   [7:0] regs_rddata,
    input  wire        regs_sel,
    input  wire        regs_strobe,
    input  wire        regs_write,

    // Layer 0 interface
    output wire  [8:0] layer0_line_idx,
    output wire        layer0_line_render_start,
    input  wire        layer0_line_render_done,
    input  wire        layer0_enabled,
    output wire  [9:0] layer0_lb_rdidx,
    input  wire  [7:0] layer0_lb_rddata,

    // Layer 1 interface
    output wire  [8:0] layer1_line_idx,
    output wire        layer1_line_render_start,
    input  wire        layer1_line_render_done,
    input  wire        layer1_enabled,
    output wire  [9:0] layer1_lb_rdidx,
    input  wire  [7:0] layer1_lb_rddata,

    // Sprite interface
    output wire  [8:0] sprites_line_idx,
    output wire        sprites_line_render_start,
    input  wire        sprites_line_render_done,
    input  wire        sprites_enabled,

    output wire  [9:0] sprite_lb_rdidx,
    input  wire [15:0] sprite_lb_rddata,
    output wire        sprite_lb_erase_start,
    input  wire        sprite_lb_erase_busy,

    // Display interface
    input  wire        display_next_frame,
    input  wire        display_next_line,
    input  wire        display_next_pixel,
    input  wire        display_current_field,
    output reg   [7:0] display_data,
    
    // Video selection
    output wire  [1:0] display_mode,
    output wire        chroma_disable);

    // MODE:
    // 0 - disabled, no video
    // 1 - VGA
    // 2 - NTSC video
    // 3 - RGB interlaced, composite sync (via VGA connector)

    //////////////////////////////////////////////////////////////////////////
    // Register interface
    //////////////////////////////////////////////////////////////////////////

    wire regs_access = regs_sel && regs_strobe;

    // CTRL0
    reg  [1:0] reg_mode_r;
    reg        chroma_disable_r;
    reg  [7:0] frac_x_incr_r;
    reg  [7:0] frac_y_incr_r;
    reg  [7:0] border_color_r;

    reg  [9:0] active_hstart_r;
    reg  [9:0] active_hstop_r;
    reg  [8:0] active_vstart_r;
    reg  [8:0] active_vstop_r;
    reg  [8:0] irq_line_r;

    reg        current_field_r;

    // Register interface read data
    always @* begin
        case (regs_addr)
            5'h0: regs_rddata = {current_field_r, 4'b0, chroma_disable_r, reg_mode_r};
            5'h1: regs_rddata = frac_x_incr_r;
            5'h2: regs_rddata = frac_y_incr_r;
            5'h3: regs_rddata = border_color_r;
            5'h4: regs_rddata = active_hstart_r[7:0];
            5'h5: regs_rddata = active_hstop_r[7:0];
            5'h6: regs_rddata = active_vstart_r[7:0];
            5'h7: regs_rddata = active_vstop_r[7:0];
            5'h8: regs_rddata = {2'b00, active_vstop_r[8], active_vstart_r[8], active_hstop_r[9:8], active_hstart_r[9:8]};
            5'h9: regs_rddata = irq_line_r[7:0];
            5'hA: regs_rddata = {7'b0, irq_line_r[8]};

            default: regs_rddata = 8'h00;
        endcase
    end

    // Register interface write data
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_mode_r          <= 2'd0;
            chroma_disable_r    <= 0;
            frac_x_incr_r       <= 8'd128;
            frac_y_incr_r       <= 8'd128;
            border_color_r      <= 8'd0;
            active_hstart_r     <= 10'd0;
            active_hstop_r      <= 10'd640;
            active_vstart_r     <= 9'd0;
            active_vstop_r      <= 9'd480;
            irq_line_r          <= 0;

        end else begin
            if (regs_access && regs_write) begin
                case (regs_addr[3:0])
                    5'h0: begin
                        reg_mode_r             <= regs_wrdata[1:0];
                        chroma_disable_r       <= regs_wrdata[2];
                    end
                    5'h1: frac_x_incr_r        <= regs_wrdata;
                    5'h2: frac_y_incr_r        <= regs_wrdata;
                    5'h3: border_color_r       <= regs_wrdata;
                    5'h4: active_hstart_r[7:0] <= regs_wrdata;
                    5'h5: active_hstop_r[7:0]  <= regs_wrdata;
                    5'h6: active_vstart_r[7:0] <= regs_wrdata;
                    5'h7: active_vstop_r[7:0]  <= regs_wrdata;
                    5'h8: begin
                        active_hstart_r[9:8]   <= regs_wrdata[1:0];
                        active_hstop_r[9:8]    <= regs_wrdata[3:2];
                        active_vstart_r[8]     <= regs_wrdata[4];
                        active_vstop_r[8]      <= regs_wrdata[5];
                    end
                    5'h9: irq_line_r[7:0]      <= regs_wrdata;
                    5'hA: irq_line_r[8]        <= regs_wrdata[0];
                endcase
            end
        end
    end

    wire is_interlaced = reg_mode_r[1];

    // Interlaced modes have double the amount of horizontal clocks
    wire [7:0] frac_x_incr = is_interlaced ? {1'b0, frac_x_incr_r[7:1]} : frac_x_incr_r;

    assign display_mode = reg_mode_r;
    assign chroma_disable = chroma_disable_r;

    //////////////////////////////////////////////////////////////////////////
    // Composer
    //////////////////////////////////////////////////////////////////////////
    reg [16:0] scaled_x_counter_r;
    wire [9:0] scaled_x_counter = scaled_x_counter_r[16:7];

    reg [15:0] scaled_y_counter_r;
    wire [8:0] scaled_y_counter = scaled_y_counter_r[15:7];

    reg render_start_r;

    // Output control signals to other units
    assign layer0_line_idx           = scaled_y_counter;
    assign layer0_line_render_start  = render_start_r;
    assign layer1_line_idx           = scaled_y_counter;
    assign layer1_line_render_start  = render_start_r;
    assign sprites_line_idx          = scaled_y_counter;
    assign sprites_line_render_start = render_start_r;
    assign layer0_lb_rdidx           = scaled_x_counter;
    assign layer1_lb_rdidx           = scaled_x_counter;
    assign sprite_lb_rdidx           = scaled_x_counter;

    wire layer0_opaque = layer0_lb_rddata[7:0] != 8'h0;
    wire layer1_opaque = layer1_lb_rddata[7:0] != 8'h0;
    wire sprite_opaque = sprite_lb_rddata[7:0] != 8'h0;

    wire sprite_z1 = sprite_lb_rddata[9:8] == 2'd1;
    wire sprite_z2 = sprite_lb_rddata[9:8] == 2'd2;
    wire sprite_z3 = sprite_lb_rddata[9:8] == 2'd3;

    // Regular vertical counter
    reg  [8:0] y_counter_r, y_counter_rr;
    reg  next_line_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            y_counter_r     <= 0;
            y_counter_rr    <= 0;
            next_line_r     <= 0;
            current_field_r <= 0;
        end else begin
            next_line_r <= display_next_line;
            if (display_next_line) begin
                // Interlaced mode skips every other line
                y_counter_r  <= y_counter_r + (is_interlaced ? 'd2 : 'd1);

                y_counter_rr <= y_counter_r;
            end
            if (display_next_frame) begin
                current_field_r <= !display_current_field;

                // Interlaced mode starts at either the even or odd line
                y_counter_r <= (is_interlaced && !display_current_field) ? 'd1 : 'd0;
            end
        end
    end

    // Generate line irq
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            line_irq <= 0;

        end else begin
            line_irq <= display_next_line && (
                (!is_interlaced && y_counter_r == irq_line_r) ||
                ( is_interlaced && y_counter_r[8:1] == irq_line_r[8:1]));
        end
    end

    // Regular horizontal counter
    reg [10:0] x_counter_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x_counter_r <= 0;
        end else begin
            if (display_next_pixel) begin
                x_counter_r <= x_counter_r + (is_interlaced ? 'd1 : 'd2);
            end
            if (display_next_line) begin
                x_counter_r <= 0;
            end
        end
    end

    wire [9:0] x_counter = x_counter_r[10:1];
    wire [8:0] y_counter = y_counter_rr;

    // Generate start signal of sprite line buffer clearing
    assign sprite_lb_erase_start = (x_counter_r == {10'd639, is_interlaced});

    // Determine the active area of the screen where the border isn't shown
    wire hactive = (x_counter >= active_hstart_r) && (x_counter < active_hstop_r);
    wire vactive = (y_counter >= active_vstart_r) && (y_counter < active_vstop_r);
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
                if (!vactive_started_r && next_line_r && y_counter_r >= active_vstart_r) begin
                    vactive_started_r  <= 1;
                    render_start_r     <= 1;

                    // Start line is dependent of current field in interlaced mode
                    scaled_y_counter_r <= (is_interlaced && (current_field_r ^ active_vstart_r[0])) ? {8'b0, frac_y_incr_r} : 'd0;

                end else if (scaled_y_counter < 'd480 && vactive) begin
                    render_start_r     <= 1;

                    // In interlaced modes we increment with twice the amount
                    scaled_y_counter_r <= scaled_y_counter_r + (is_interlaced ? {7'b0, frac_y_incr_r, 1'b0} : {8'b0, frac_y_incr_r});
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
                    scaled_x_counter_r <= scaled_x_counter_r + frac_x_incr;
                end
            end
            
            if (display_next_line) begin
                scaled_x_counter_r <= 0;
            end
        end
    end

    // Compose the display
    always @* begin
        display_data = border_color_r;

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
