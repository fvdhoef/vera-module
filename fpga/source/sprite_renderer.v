`default_nettype none

module sprite_renderer(
    input  wire        rst,
    input  wire        clk,

    // Composer interface
    input  wire  [8:0] line_idx,
    input  wire        line_render_start,
    output wire        line_render_done,
    output wire        sprites_enabled,

    // Register interface
    input  wire  [3:0] regs_addr,
    input  wire  [7:0] regs_wrdata,
    output reg   [7:0] regs_rddata,
    input  wire        regs_write,

    // Bus master interface
    output wire [15:0] bus_addr,
    input  wire [31:0] bus_rddata,
    output wire        bus_strobe,
    input  wire        bus_ack,

    // Sprite attribute RAM interface
    output wire  [7:0] sprite_idx,
    input  wire [47:0] sprite_attr,

    // Line buffer interface
    output wire  [9:0] linebuf_rdidx,
    input  wire [15:0] linebuf_rddata,

    output wire  [9:0] linebuf_wridx,
    output wire [15:0] linebuf_wrdata,
    output wire        linebuf_wren);

    //////////////////////////////////////////////////////////////////////////
    // Register interface
    //////////////////////////////////////////////////////////////////////////

    // CTRL0
    reg        reg_enable_r;

    assign sprites_enabled = reg_enable_r;

    // Register interface read data
    always @* begin
        case (regs_addr)
            4'h0: regs_rddata = {7'b0, reg_enable_r};
            default: regs_rddata = 8'h00;
        endcase
    end

    // Register interface write data
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_enable_r        <= 0;

        end else begin
            if (regs_write) begin
                case (regs_addr[3:0])
                    4'h0: begin
                        reg_enable_r <= regs_wrdata[0];
                    end
                endcase
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Line renderer
    //////////////////////////////////////////////////////////////////////////

    reg  [9:0] render_time_r, render_time_next;
    reg  [8:0] sprite_idx_r, sprite_idx_next;
    wire [8:0] sprite_idx_incr = sprite_idx_r + 'd1;

    assign sprite_idx = sprite_idx_next[7:0];

    // Decode fields from sprite attributes
    wire  [9:0] sprite_x              = sprite_attr[9:0];
    wire        sprite_vflip          = sprite_attr[10];
    wire        sprite_hflip          = sprite_attr[11];
    wire  [3:0] sprite_palette_offset = sprite_attr[15:12];
    wire  [8:0] sprite_y              = sprite_attr[24:16];
    wire        sprite_mode           = sprite_attr[25];
    wire  [1:0] sprite_z              = sprite_attr[27:26];
    wire  [1:0] sprite_height         = sprite_attr[29:28];
    wire  [1:0] sprite_width          = sprite_attr[31:30];
    wire [15:0] sprite_addr           = sprite_attr[47:32];

    // Decode sprite height
    reg [5:0] sprite_height_pixels;
    always @* case (sprite_height)
        2'd0: sprite_height_pixels = 6'd7;
        2'd1: sprite_height_pixels = 6'd15;
        2'd2: sprite_height_pixels = 6'd31;
        2'd3: sprite_height_pixels = 6'd63;
    endcase

    // Decode sprite width
    reg [5:0] sprite_width_pixels;
    always @* case (sprite_width)
        2'd0: sprite_width_pixels = 6'd7;
        2'd1: sprite_width_pixels = 6'd15;
        2'd2: sprite_width_pixels = 6'd31;
        2'd3: sprite_width_pixels = 6'd63;
    endcase

    // Determine if sprite is on current line
    wire [8:0] ydiff          = line_idx - sprite_y;
    wire       sprite_on_line = ydiff <= {3'b0, sprite_height_pixels};
    wire       sprite_enabled = sprite_z != 2'd0;
    wire [5:0] sprite_line    = sprite_vflip ? (sprite_height_pixels - ydiff[5:0]) : ydiff[5:0];

    reg [15:0] line_addr_tmp;
    always @* case (sprite_width)
        2'd0: line_addr_tmp = sprite_mode ? {9'b0, sprite_line, 1'b0} : {10'b0, sprite_line      };   //  8 pixels
        2'd1: line_addr_tmp = sprite_mode ? {8'b0, sprite_line, 2'b0} : { 9'b0, sprite_line, 1'b0};   // 16 pixels
        2'd2: line_addr_tmp = sprite_mode ? {7'b0, sprite_line, 3'b0} : { 8'b0, sprite_line, 2'b0};   // 32 pixels
        2'd3: line_addr_tmp = sprite_mode ? {6'b0, sprite_line, 4'b0} : { 7'b0, sprite_line, 3'b0};   // 64 pixels
    endcase
    wire [15:0] line_addr = sprite_addr + line_addr_tmp;


    parameter
        STATE_FIND_SPRITE   = 2'b00,
        STATE_WAIT_FETCH    = 2'b01,
        STATE_RENDER        = 2'b10,
        STATE_DONE          = 2'b11;

    reg  [1:0] state_r,         state_next;
    reg [15:0] bus_addr_r,      bus_addr_next;
    reg        bus_strobe_r,    bus_strobe_next;
    reg [31:0] render_data_r,   render_data_next;
    reg  [9:0] linebuf_idx_r,   linebuf_idx_next;
    reg        linebuf_wren_r,  linebuf_wren_next;
    reg  [5:0] xcnt_r,          xcnt_next;

    assign bus_addr      = bus_addr_r;
    assign bus_strobe    = bus_strobe_r && !bus_ack;
    assign linebuf_rdidx = linebuf_idx_next;
    assign linebuf_wridx = linebuf_idx_r;
    assign linebuf_wren  = linebuf_wren_next;

    wire [5:0] hflipped_xcnt = sprite_hflip ? ~xcnt_r : xcnt_r;

    // Select current pixel for 4bpp mode
    reg [3:0] cur_pixel_data_4bpp;
    always @* case (hflipped_xcnt[2:0])
        // Byte 0
        3'd0: cur_pixel_data_4bpp = render_data_r[7:4];
        3'd1: cur_pixel_data_4bpp = render_data_r[3:0];

        // Byte 1
        3'd2: cur_pixel_data_4bpp = render_data_r[15:12];
        3'd3: cur_pixel_data_4bpp = render_data_r[11:8];

        // Byte 2
        3'd4: cur_pixel_data_4bpp = render_data_r[23:20];
        3'd5: cur_pixel_data_4bpp = render_data_r[19:16];

        // Byte 3
        3'd6: cur_pixel_data_4bpp = render_data_r[31:28];
        3'd7: cur_pixel_data_4bpp = render_data_r[27:24];
    endcase

    // Select current pixel for 8bpp mode
    reg [7:0] cur_pixel_data_8bpp;
    always @* case (hflipped_xcnt[1:0])
        // Byte 0
        3'd0: cur_pixel_data_8bpp = render_data_r[7:0];

        // Byte 1
        3'd1: cur_pixel_data_8bpp = render_data_r[15:8];

        // Byte 2
        3'd2: cur_pixel_data_8bpp = render_data_r[23:16];

        // Byte 3
        3'd3: cur_pixel_data_8bpp = render_data_r[31:24];
    endcase

    // Select current pixel based on current color depth
    wire [7:0] tmp_pixel_color = sprite_mode ? cur_pixel_data_8bpp : {4'b0, cur_pixel_data_4bpp};

    // Apply palette offset
    wire [7:0] cur_pixel_color = {
        ((tmp_pixel_color[7:4] == 0 && tmp_pixel_color[3:0] != 0) ? sprite_palette_offset : tmp_pixel_color[7:4]),
        tmp_pixel_color[3:0]
    };

    assign linebuf_wrdata = {6'b0, sprite_z, cur_pixel_color};

    wire render_pixel = (sprite_z >= linebuf_rddata[9:8]) && (tmp_pixel_color != 0);

    always @* begin
        render_time_next  = render_time_r;
        sprite_idx_next   = sprite_idx_r;
        state_next        = state_r;
        bus_addr_next     = bus_addr_r;
        bus_strobe_next   = bus_strobe_r;
        render_data_next  = render_data_r;
        linebuf_idx_next  = linebuf_idx_r;
        linebuf_wren_next = 0;
        xcnt_next         = xcnt_r;

        case (state_r)
            STATE_FIND_SPRITE: begin
                if (sprite_idx_r[8]) begin
                    state_next = STATE_DONE;
                end else begin
                    if (sprite_enabled && sprite_on_line) begin
                        linebuf_idx_next = sprite_x;
                        bus_addr_next    = line_addr;
                        bus_strobe_next  = 1;
                        state_next       = STATE_WAIT_FETCH;
                        xcnt_next        = 0;
                    end else begin
                        sprite_idx_next = sprite_idx_incr;
                    end
                end
            end

            STATE_WAIT_FETCH: begin
                if (bus_ack) begin
                    bus_strobe_next  = 0;
                    bus_addr_next    = bus_addr_r + 1;

                    render_data_next = bus_rddata;
                    state_next       = STATE_RENDER;
                end
            end

            STATE_RENDER: begin
                xcnt_next         = xcnt_r + 1;
                linebuf_idx_next  = linebuf_idx_r + 1;
                linebuf_wren_next = render_pixel;

                if ((sprite_mode && xcnt_r[1:0] == 3) || (!sprite_mode && xcnt_r[2:0] == 7)) begin
                    if (xcnt_r == sprite_width_pixels) begin
                        sprite_idx_next = sprite_idx_incr;
                        state_next      = STATE_FIND_SPRITE;
                    end else begin
                        bus_strobe_next = 1;
                        state_next      = STATE_WAIT_FETCH;
                    end
                end
            end

            STATE_DONE: begin
                bus_strobe_next = 0;
            end

        endcase

        if (line_render_start) begin
            sprite_idx_next = 0;
            state_next      = STATE_FIND_SPRITE;
            bus_strobe_next = 0;

            render_time_next = 0;
        end else begin
            if (state_r != STATE_DONE) begin
                if (render_time_r == 'd798) begin
                    state_next = STATE_DONE;
                end else begin
                    render_time_next = render_time_r + 1;
                end
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            render_time_r  <= 0;
            sprite_idx_r   <= 0;
            state_r        <= STATE_FIND_SPRITE;
            bus_addr_r     <= 0;
            bus_strobe_r   <= 0;
            render_data_r  <= 0;
            linebuf_idx_r  <= 0;
            linebuf_wren_r <= 0;
            xcnt_r         <= 0;

        end else begin
            render_time_r  <= render_time_next;
            sprite_idx_r   <= sprite_idx_next;
            state_r        <= state_next;
            bus_addr_r     <= bus_addr_next;
            bus_strobe_r   <= bus_strobe_next;
            render_data_r  <= render_data_next;
            linebuf_idx_r  <= linebuf_idx_next;
            linebuf_wren_r <= linebuf_wren_next;
            xcnt_r         <= xcnt_next;
        end
    end

endmodule
