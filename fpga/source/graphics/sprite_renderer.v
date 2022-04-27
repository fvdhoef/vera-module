//`default_nettype none

module sprite_renderer(
    input  wire        rst,
    input  wire        clk,

    // Register interface
    output wire  [3:0] collisions,
    output reg         sprcol_irq,

    // Composer interface
    input  wire  [8:0] line_idx,
    input  wire        line_render_start,
    input  wire        frame_done,

    // Bus master interface
    output wire [14:0] bus_addr,
    input  wire [31:0] bus_rddata,
    output wire        bus_strobe,
    input  wire        bus_ack,

    // Sprite attribute RAM interface
    output wire  [7:0] sprite_idx,
    input  wire [31:0] sprite_attr,

    // Line buffer interface
    output wire  [9:0] linebuf_rdidx,
    input  wire [15:0] linebuf_rddata,

    output wire  [9:0] linebuf_wridx,
    output wire [15:0] linebuf_wrdata,
    output wire        linebuf_wren);

    reg [3:0] cur_collision_mask_r,   cur_collision_mask_next;
    reg [3:0] frame_collision_mask_r, frame_collision_mask_next;

    assign collisions = frame_collision_mask_r;

    //////////////////////////////////////////////////////////////////////////
    // Render time limitation
    //////////////////////////////////////////////////////////////////////////
    reg  [9:0] render_time_r;
    wire       render_time_done = (render_time_r == 'd798);

    // Limit render time so that VGA and composite mode get the same amount of render time
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            render_time_r <= 0;
        end else begin
            if (line_render_start) begin
                render_time_r <= 0;
            end else begin
                if (!render_time_done) begin
                    render_time_r <= render_time_r + 10'd1;
                end
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Sprite searching
    //////////////////////////////////////////////////////////////////////////
    wire       render_busy;

    reg  [7:0] sprite_idx_r, sprite_idx_next;
    reg        sprite_attr_sel_next;

    assign sprite_idx = {sprite_idx_next[6:0], sprite_attr_sel_next};

    // Decode fields from sprite attributes

    // sprite_attr_sel_r=0
    wire [11:0] sprite_attr_addr           = sprite_attr[11:0];
    wire        sprite_attr_mode           = sprite_attr[15];
    wire  [9:0] sprite_attr_x              = sprite_attr[25:16];

    // sprite_attr_sel_r=1
    wire  [9:0] sprite_attr_y              = sprite_attr[9:0];
    wire        sprite_attr_hflip          = sprite_attr[16];
    wire        sprite_attr_vflip          = sprite_attr[17];
    wire  [1:0] sprite_attr_z              = sprite_attr[19:18];
    wire  [3:0] sprite_attr_collision_mask = sprite_attr[23:20];
    wire  [3:0] sprite_attr_palette_offset = sprite_attr[27:24];
    wire  [1:0] sprite_attr_width          = sprite_attr[29:28];
    wire  [1:0] sprite_attr_height         = sprite_attr[31:30];

    // Registers to hold attributes of sprite being rendered
    reg  [11:0] sprite_addr_r;
    reg         sprite_mode_r;
    reg   [9:0] sprite_x_r;

    reg   [5:0] sprite_line_r;
    reg         sprite_hflip_r;
    reg   [1:0] sprite_z_r;
    reg   [3:0] sprite_collision_mask_r;
    reg   [3:0] sprite_palette_offset_r;
    reg   [1:0] sprite_width_r;
    // reg   [1:0] sprite_height_r;

    // Decode sprite height
    reg [5:0] sprite_height_pixels;
    always @* case (sprite_attr_height)
        2'd0: sprite_height_pixels = 6'd7;
        2'd1: sprite_height_pixels = 6'd15;
        2'd2: sprite_height_pixels = 6'd31;
        2'd3: sprite_height_pixels = 6'd63;
    endcase

    // Determine if sprite is on current line
    wire [9:0] ydiff          = {1'b0, line_idx} - sprite_attr_y;
    wire       sprite_on_line = ydiff <= {3'b0, sprite_height_pixels};
    wire       sprite_enabled = sprite_attr_z != 2'd0;
    wire [5:0] sprite_line    = sprite_attr_vflip ? (sprite_height_pixels - ydiff[5:0]) : ydiff[5:0];

    // Sprite find state machine states
    parameter
        SF_FIND_SPRITE  = 2'b00,
        SF_START_RENDER = 2'b01,
        SF_DONE         = 2'b11;

    // Registers used by state machine
    reg  [1:0] sf_state_r, sf_state_next;
    reg        save_hi, save_lo;
    reg        start_render_r, start_render_next;


    wire [7:0] sprite_idx_incr = sprite_idx_r + 8'd1;

    // Render state machine
    always @* begin
        sprite_idx_next      = sprite_idx_r;
        sf_state_next        = sf_state_r;
        sprite_attr_sel_next = 1;
        save_hi              = 0;
        save_lo              = 0;
        start_render_next    = 0;

        case (sf_state_next)
            // Find a sprite to be rendered
            SF_FIND_SPRITE: begin
                if (sprite_idx_r[7]) begin
                    sf_state_next = SF_DONE;

                end else begin
                    if (sprite_enabled && sprite_on_line) begin
                        if (!render_busy) begin
                            sprite_attr_sel_next = 0;
                            save_hi              = 1;
                            sf_state_next        = SF_START_RENDER;
                        end

                    end else begin
                        sprite_idx_next = sprite_idx_incr;
                    end
                end
            end

            // Start the render
            SF_START_RENDER: begin
                save_lo           = 1;
                sf_state_next     = SF_FIND_SPRITE;
                start_render_next = 1;
                sprite_idx_next   = sprite_idx_incr;
            end

            // Wait for the next line
            SF_DONE: begin
            end
        endcase

        if (line_render_start) begin
            sf_state_next     = SF_FIND_SPRITE;
            sprite_idx_next   = 0;
            start_render_next = 0;
        end else begin
            if (render_time_done) begin
                sf_state_next = SF_DONE;
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sprite_idx_r            <= 0;
            sf_state_r              <= SF_FIND_SPRITE;
            start_render_r          <= 0;

            sprite_addr_r           <= 0;
            sprite_mode_r           <= 0;
            sprite_x_r              <= 0;
            sprite_line_r           <= 0;
            sprite_hflip_r          <= 0;
            sprite_z_r              <= 0;
            sprite_collision_mask_r <= 0;
            sprite_palette_offset_r <= 0;
            sprite_width_r          <= 0;
            // sprite_height_r         <= 0;

        end else begin
            sprite_idx_r   <= sprite_idx_next;
            sf_state_r     <= sf_state_next;
            start_render_r <= start_render_next;

            if (save_lo) begin
                sprite_addr_r           <= sprite_attr_addr;
                sprite_mode_r           <= sprite_attr_mode;
                sprite_x_r              <= sprite_attr_x;
            end
            if (save_hi) begin
                sprite_line_r           <= sprite_line;
                sprite_hflip_r          <= sprite_attr_hflip;
                sprite_z_r              <= sprite_attr_z;
                sprite_collision_mask_r <= sprite_attr_collision_mask;
                sprite_palette_offset_r <= sprite_attr_palette_offset;
                sprite_width_r          <= sprite_attr_width;
                // sprite_height_r         <= sprite_attr_height;
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Line renderer
    //////////////////////////////////////////////////////////////////////////

    // Decode sprite width
    reg [5:0] sprite_width_pixels;
    always @* case (sprite_width_r)
        2'd0: sprite_width_pixels = 6'd7;
        2'd1: sprite_width_pixels = 6'd15;
        2'd2: sprite_width_pixels = 6'd31;
        2'd3: sprite_width_pixels = 6'd63;
    endcase

    // Determine current sub-sprite x-position
    reg  [5:0] xcnt_r, xcnt_next;
    wire [5:0] hflipped_xcnt      = sprite_hflip_r ? ~xcnt_r    : xcnt_r;
    wire [5:0] hflipped_xcnt_next = sprite_hflip_r ? ~xcnt_next : xcnt_next;

    // Determine address of current sprite line
    reg [14:0] line_addr_tmp;
    always @* case (sprite_width_r)
        2'd0: line_addr_tmp = sprite_mode_r ? {8'b0, sprite_line_r, hflipped_xcnt_next[  2]} : {9'b0, sprite_line_r                         }; //  8 pixels
        2'd1: line_addr_tmp = sprite_mode_r ? {7'b0, sprite_line_r, hflipped_xcnt_next[3:2]} : {8'b0, sprite_line_r, hflipped_xcnt_next[  3]}; // 16 pixels
        2'd2: line_addr_tmp = sprite_mode_r ? {6'b0, sprite_line_r, hflipped_xcnt_next[4:2]} : {7'b0, sprite_line_r, hflipped_xcnt_next[4:3]}; // 32 pixels
        2'd3: line_addr_tmp = sprite_mode_r ? {5'b0, sprite_line_r, hflipped_xcnt_next[5:2]} : {6'b0, sprite_line_r, hflipped_xcnt_next[5:3]}; // 64 pixels
    endcase
    wire [14:0] line_addr = {sprite_addr_r, 3'b0} + line_addr_tmp;

    // State machine states
    parameter
        STATE_IDLE       = 2'b00,
        STATE_WAIT_FETCH = 2'b01,
        STATE_RENDER     = 2'b10,
        STATE_DONE       = 2'b11;

    // Registers used by state machine
    reg  [1:0] state_r,        state_next;
    reg [14:0] bus_addr_r,     bus_addr_next;
    reg        bus_strobe_r,   bus_strobe_next;
    reg [31:0] render_data_r,  render_data_next;
    reg  [9:0] linebuf_idx_r,  linebuf_idx_next;
    reg        /*linebuf_wren_r,*/ linebuf_wren_next;

    assign bus_addr      = bus_addr_r;
    assign bus_strobe    = bus_strobe_r && !bus_ack;
    assign linebuf_rdidx = linebuf_idx_next;
    assign linebuf_wridx = linebuf_idx_r;
    assign linebuf_wren  = linebuf_wren_next;

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
    wire [7:0] tmp_pixel_color = sprite_mode_r ? cur_pixel_data_8bpp : {4'b0, cur_pixel_data_4bpp};

    // Determine if pixel is transparent
    wire pixel_is_transparent = (tmp_pixel_color == 8'b0);

    // Apply palette offset
    wire [7:0] cur_pixel_color = {
        ((tmp_pixel_color[7:4] == 0 && tmp_pixel_color[3:0] != 0) ? sprite_palette_offset_r : tmp_pixel_color[7:4]),
        tmp_pixel_color[3:0]
    };

    // Compose data to be written to line buffer
    assign linebuf_wrdata = {linebuf_rddata[15:12] | sprite_collision_mask_r, 2'b0, sprite_z_r, cur_pixel_color};

    // Determine if current pixel should be rendered
    wire dest_pixel_is_transparent = (linebuf_rddata[7:0] == 8'b0);
	wire render_pixel = !pixel_is_transparent && ((sprite_z_r > linebuf_rddata[9:8]) || dest_pixel_is_transparent);

    // Determine collision for the current pixel
    wire [3:0] collision =
        linebuf_idx_r < 'd640 &&
        (!pixel_is_transparent && sprite_collision_mask_r != 4'b0) ? (linebuf_rddata[15:12] & ~sprite_collision_mask_r) : 4'b0;

    // Render state machine
    always @* begin
        state_next                = state_r;
        bus_addr_next             = bus_addr_r;
        bus_strobe_next           = bus_strobe_r;
        render_data_next          = render_data_r;
        linebuf_idx_next          = linebuf_idx_r;
        linebuf_wren_next         = 0;
        xcnt_next                 = xcnt_r;
        sprcol_irq                = 0;
        cur_collision_mask_next   = cur_collision_mask_r;
        frame_collision_mask_next = frame_collision_mask_r;

        case (state_r)
            // Find a sprite to be rendered
            STATE_IDLE: begin
                if (start_render_r) begin
                    linebuf_idx_next = sprite_x_r;
                    bus_addr_next    = line_addr;
                    bus_strobe_next  = 1;
                    state_next       = STATE_WAIT_FETCH;
                end
            end

            // Wait for bus data to arrive
            STATE_WAIT_FETCH: begin
                if (bus_ack) begin
                    bus_strobe_next  = 0;
                    render_data_next = bus_rddata;
                    state_next       = STATE_RENDER;
                end
            end

            // Render the fetched data to the line buffer
            STATE_RENDER: begin
                xcnt_next         = xcnt_r + 6'd1;
                linebuf_idx_next  = linebuf_idx_r + 10'd1;
                linebuf_wren_next = render_pixel;

                // Merge collision with current frame's collision mask
                cur_collision_mask_next = cur_collision_mask_r | collision;

                if ((sprite_mode_r && xcnt_r[1:0] == 3) || (!sprite_mode_r && xcnt_r[2:0] == 7)) begin
                    if (xcnt_r == sprite_width_pixels) begin
                        state_next      = STATE_IDLE;
                        xcnt_next       = 0;
                    end else begin
                        bus_addr_next   = line_addr;
                        bus_strobe_next = 1;
                        state_next      = STATE_WAIT_FETCH;
                    end
                end
            end

            // Wait for the next line
            STATE_DONE: begin
                bus_strobe_next = 0;
            end
        endcase

        if (line_render_start) begin
            state_next       = STATE_IDLE;
            xcnt_next        = 0;
            bus_strobe_next  = 0;
        end else begin
            if (render_time_done) begin
                state_next = STATE_DONE;
            end
        end

        if (frame_done) begin
            sprcol_irq                = (cur_collision_mask_r != 4'b0);
            frame_collision_mask_next = cur_collision_mask_r;
            cur_collision_mask_next   = 4'b0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r                <= STATE_IDLE;
            bus_addr_r             <= 0;
            bus_strobe_r           <= 0;
            render_data_r          <= 0;
            linebuf_idx_r          <= 0;
            // linebuf_wren_r         <= 0;
            xcnt_r                 <= 0;
            cur_collision_mask_r   <= 0;
            frame_collision_mask_r <= 0;

        end else begin
            state_r                <= state_next;
            bus_addr_r             <= bus_addr_next;
            bus_strobe_r           <= bus_strobe_next;
            render_data_r          <= render_data_next;
            linebuf_idx_r          <= linebuf_idx_next;
            // linebuf_wren_r         <= linebuf_wren_next;
            xcnt_r                 <= xcnt_next;
            cur_collision_mask_r   <= cur_collision_mask_next;
            frame_collision_mask_r <= frame_collision_mask_next;
        end
    end

    assign render_busy = start_render_r || (state_r != STATE_IDLE);

endmodule
