`default_nettype none

module layer_renderer(
    input  wire        rst,
    input  wire        clk,

    input  wire        start_of_screen,
    input  wire        start_of_line,

    // Register interface
    input  wire  [3:0] regs_addr,
    input  wire  [7:0] regs_wrdata,
    output reg   [7:0] regs_rddata,
    input  wire        regs_write,

    // Bus master interface
    output reg  [17:0] bus_addr,
    input  wire [31:0] bus_rddata,
    output wire        bus_strobe,
    input  wire        bus_ack,

    // Line buffer interface
    output reg   [9:0] linebuf_wridx,
    output reg   [7:0] linebuf_wrdata,
    output reg         linebuf_wren);

    //////////////////////////////////////////////////////////////////////////
    // Register interface
    //////////////////////////////////////////////////////////////////////////

    // CTRL0
    reg  [2:0] reg_mode_r;
    reg  [1:0] reg_vscale_r;
    reg  [1:0] reg_hscale_r;
    reg        reg_enable_r;

    // CTRL1
    reg        reg_tile_height_r;
    reg        reg_tile_width_r;
    reg  [1:0] reg_map_height_r;
    reg  [1:0] reg_map_width_r;

    // Other registers
    reg [15:0] reg_map_baseaddr_r;
    reg [15:0] reg_tile_baseaddr_r;
    reg [11:0] reg_hscroll_r;
    reg [11:0] reg_vscroll_r;

    // Register interface read data
    always @* begin
        case (regs_addr)
            4'h0: regs_rddata = {reg_mode_r, reg_vscale_r, reg_hscale_r, reg_enable_r};
            4'h1: regs_rddata = {2'b0, reg_tile_height_r, reg_tile_width_r, reg_map_height_r, reg_map_width_r};
            4'h2: regs_rddata = reg_map_baseaddr_r[7:0];
            4'h3: regs_rddata = reg_map_baseaddr_r[15:8];
            4'h4: regs_rddata = reg_tile_baseaddr_r[7:0];
            4'h5: regs_rddata = reg_tile_baseaddr_r[15:8];
            4'h6: regs_rddata = reg_hscroll_r[7:0];
            4'h7: regs_rddata = {4'b0, reg_hscroll_r[11:8]};
            4'h8: regs_rddata = reg_vscroll_r[7:0];
            4'h9: regs_rddata = {4'b0, reg_vscroll_r[11:8]};
            default: regs_rddata = 8'h00;
        endcase
    end

    // Register interface write data
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_mode_r          <= 3'd0;
            reg_vscale_r        <= 2'd0;
            reg_hscale_r        <= 2'd0;
            reg_enable_r        <= 0;

            reg_tile_height_r   <= 0;
            reg_tile_width_r    <= 0;
            reg_map_height_r    <= 0;
            reg_map_width_r     <= 0;

            reg_map_baseaddr_r  <= 16'h0000;
            reg_tile_baseaddr_r <= 16'h8000;
            reg_hscroll_r       <= 12'd0;
            reg_vscroll_r       <= 12'd0;

        end else begin
            if (regs_write) begin
                case (regs_addr[3:0])
                    4'h0: begin
                        reg_mode_r   <= regs_wrdata[7:5];
                        reg_vscale_r <= regs_wrdata[4:3];
                        reg_hscale_r <= regs_wrdata[2:1];
                        reg_enable_r <= regs_wrdata[0];
                    end

                    4'h1: begin
                        reg_tile_height_r <= regs_wrdata[5];
                        reg_tile_width_r  <= regs_wrdata[4];
                        reg_map_height_r  <= regs_wrdata[3:2];
                        reg_map_width_r   <= regs_wrdata[1:0];
                    end

                    4'h2: reg_map_baseaddr_r[7:0]   <= regs_wrdata;
                    4'h3: reg_map_baseaddr_r[15:8]  <= regs_wrdata;
                    4'h4: reg_tile_baseaddr_r[7:0]  <= regs_wrdata;
                    4'h5: reg_tile_baseaddr_r[15:8] <= regs_wrdata;
                    4'h6: reg_hscroll_r[7:0]        <= regs_wrdata;
                    4'h7: reg_hscroll_r[11:8]       <= regs_wrdata[3:0];
                    4'h8: reg_vscroll_r[7:0]        <= regs_wrdata;
                    4'h9: reg_vscroll_r[11:8]       <= regs_wrdata[3:0];
                endcase
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Line renderer
    //////////////////////////////////////////////////////////////////////////

    // Decode color depth from mode register
    reg [1:0] color_depth;
    always @* case (reg_mode_r)
        3'd0: color_depth = 2'd0;    // Tile mode 1bpp; 16 color fg/bg color
        3'd1: color_depth = 2'd0;    // Tile mode 1bpp; 256 color fg color, fixed bg color 0
        3'd2: color_depth = 2'd1;    // 2bpp tile mode
        3'd3: color_depth = 2'd2;    // 4bpp tile mode
        3'd4: color_depth = 2'd3;    // 8bpp tile mode
        3'd5: color_depth = 2'd1;    // 2bpp bitmap mode
        3'd6: color_depth = 2'd2;    // 4bpp bitmap mode
        3'd7: color_depth = 2'd3;    // 8bpp bitmap mode
    endcase

    // Decode pixels per word - 1 from mode register
    reg [3:0] pixels_per_word_minus1;
    always @* case (reg_mode_r)
        3'd0: pixels_per_word_minus1 = reg_tile_width_r ? 4'd15 : 4'd7;   // Tile mode 1bpp; 16 color fg/bg color
        3'd1: pixels_per_word_minus1 = reg_tile_width_r ? 4'd15 : 4'd7;   // Tile mode 1bpp; 256 color fg color, fixed bg color 0
        3'd2: pixels_per_word_minus1 = reg_tile_width_r ? 4'd15 : 4'd7;   // 2bpp tile mode
        3'd3: pixels_per_word_minus1 = 4'd7;                              // 4bpp tile mode
        3'd4: pixels_per_word_minus1 = 4'd3;                              // 8bpp tile mode
        3'd5: pixels_per_word_minus1 = 4'd15;                             // 2bpp bitmap mode
        3'd6: pixels_per_word_minus1 = 4'd7;                              // 4bpp bitmap mode
        3'd7: pixels_per_word_minus1 = 4'd3;                              // 8bpp bitmap mode
    endcase

    // Decode lines per word - 1 from mode register
    reg [1:0] lines_per_word_minus1;
    always @* case (reg_mode_r)
        3'd0: lines_per_word_minus1 = reg_tile_width_r ? 2'd1 : 2'd3;    // Tile mode 1bpp; 16 color fg/bg color
        3'd1: lines_per_word_minus1 = reg_tile_width_r ? 2'd1 : 2'd3;    // Tile mode 1bpp; 256 color fg color, fixed bg color 0
        3'd2: lines_per_word_minus1 = reg_tile_width_r ? 2'd0 : 2'd1;    // 2bpp tile mode
        3'd3: lines_per_word_minus1 = 2'd0;                              // 4bpp tile mode
        3'd4: lines_per_word_minus1 = 2'd0;                              // 8bpp tile mode
        3'd5: lines_per_word_minus1 = 2'd0;                              // 2bpp bitmap mode
        3'd6: lines_per_word_minus1 = 2'd0;                              // 4bpp bitmap mode
        3'd7: lines_per_word_minus1 = 2'd0;                              // 8bpp bitmap mode
    endcase

    // Decode words per tile line - 1 from mode register
    reg [1:0] words_per_line_minus1;
    always @* case (reg_mode_r)
        3'd0: words_per_line_minus1 = 2'd0;                              // Tile mode 1bpp; 16 color fg/bg color
        3'd1: words_per_line_minus1 = 2'd0;                              // Tile mode 1bpp; 256 color fg color, fixed bg color 0
        3'd2: words_per_line_minus1 = 2'd0;                              // 2bpp tile mode
        3'd3: words_per_line_minus1 = reg_tile_width_r ? 2'd1: 2'd0;     // 4bpp tile mode
        3'd4: words_per_line_minus1 = reg_tile_width_r ? 2'd3: 2'd1;     // 8bpp tile mode
        3'd5: words_per_line_minus1 = 2'd0;                              // 2bpp bitmap mode
        3'd6: words_per_line_minus1 = 2'd0;                              // 4bpp bitmap mode
        3'd7: words_per_line_minus1 = 2'd0;                              // 8bpp bitmap mode
    endcase

    reg [11:0] vcnt_r;  // Current line

    // Handle vertical scrolling
    wire [11:0] scrolled_line_idx = vcnt_r + reg_vscroll_r;
    wire [7:0] vmap_idx = reg_tile_height_r ? {scrolled_line_idx[11:4]} : scrolled_line_idx[10:3];

    reg [7:0] wrapped_vmap_idx;
    always @* case (reg_map_height_r)
        2'd0: wrapped_vmap_idx = {3'b0, vmap_idx[4:0]}; // 32
        2'd1: wrapped_vmap_idx = {2'b0, vmap_idx[5:0]}; // 64
        2'd2: wrapped_vmap_idx = {1'b0, vmap_idx[6:0]}; // 128
        2'd3: wrapped_vmap_idx = {      vmap_idx[7:0]}; // 256
    endcase

    // Handle horizontal scrolling
    reg [7:0] htile_cnt_r;
    reg [1:0] word_cnt_r;

    wire [7:0] scrolled_htile_cnt = htile_cnt_r + (reg_tile_width_r ? reg_hscroll_r[11:4] : {reg_hscroll_r[10:3]});

    reg [15:0] map_idx;
    always @* case (reg_map_width_r)
        2'd0: map_idx = {3'b0, wrapped_vmap_idx, scrolled_htile_cnt[4:0]}; // 32
        2'd1: map_idx = {2'b0, wrapped_vmap_idx, scrolled_htile_cnt[5:0]}; // 64
        2'd2: map_idx = {1'b0, wrapped_vmap_idx, scrolled_htile_cnt[6:0]}; // 128
        2'd3: map_idx = {      wrapped_vmap_idx, scrolled_htile_cnt[7:0]}; // 256
    endcase

    // Calculate map address
    wire [17:0] map_addr = {reg_map_baseaddr_r + {1'b0, map_idx[15:1]}, 2'b0};

    // Data as fetched from memory
    reg [31:0] map_data_r;

    // Select correct 16-bit map data from 32-bit bus data
    wire [15:0] cur_map_data = map_idx[0] ? map_data_r[31:16] : map_data_r[15:0];

    // Get tile index from map data (mode 0/1 only has 8-bit tile index, other tile modes have 10-bit tile index)
    wire  [9:0] cur_tile_idx = (reg_mode_r == 'd0 || reg_mode_r == 'd1) ? {2'b0, cur_map_data[7:0]} : cur_map_data[9:0];

    // Calculate tile address 1bpp
    wire [15:0] tile_addr_1bpp_x8    = {5'b0, cur_tile_idx, scrolled_line_idx[2]};
    wire [15:0] tile_addr_1bpp_x16   = {4'b0, cur_tile_idx, scrolled_line_idx[3:2]};
    wire [15:0] tile_addr_1bpp       = reg_tile_height_r ? tile_addr_1bpp_x16 : tile_addr_1bpp_x8;

    // Calculate tile address 2bpp
    wire [15:0] tile_addr_2bpp_x8    = {4'b0, cur_tile_idx, scrolled_line_idx[2:1]};
    wire [15:0] tile_addr_2bpp_x16   = {3'b0, cur_tile_idx, scrolled_line_idx[3:1]};
    wire [15:0] tile_addr_2bpp       = reg_tile_height_r ? tile_addr_2bpp_x16 : tile_addr_2bpp_x8;

    // Calculate tile address 4bpp
    wire [15:0] tile_addr_4bpp_8x8   = {3'b0, cur_tile_idx, scrolled_line_idx[2:0]};
    wire [15:0] tile_addr_4bpp_8x16  = {2'b0, cur_tile_idx, scrolled_line_idx[3:0]};
    wire [15:0] tile_addr_4bpp_16x8  = {2'b0, cur_tile_idx, scrolled_line_idx[2:0], word_cnt_r[0]};
    wire [15:0] tile_addr_4bpp_16x16 = {1'b0, cur_tile_idx, scrolled_line_idx[3:0], word_cnt_r[0]};
    reg  [15:0] tile_addr_4bpp;
    always @* case ({reg_tile_width_r, reg_tile_height_r})
        2'b00: tile_addr_4bpp = tile_addr_4bpp_8x8;
        2'b01: tile_addr_4bpp = tile_addr_4bpp_8x16;
        2'b10: tile_addr_4bpp = tile_addr_4bpp_16x8;
        2'b11: tile_addr_4bpp = tile_addr_4bpp_16x16;
    endcase

    // Calculate tile address 8bpp
    wire [15:0] tile_addr_8bpp_8x8   = {2'b0, cur_tile_idx, scrolled_line_idx[2:0], word_cnt_r[0]};
    wire [15:0] tile_addr_8bpp_8x16  = {1'b0, cur_tile_idx, scrolled_line_idx[3:0], word_cnt_r[0]};
    wire [15:0] tile_addr_8bpp_16x8  = {1'b0, cur_tile_idx, scrolled_line_idx[2:0], word_cnt_r[1:0]};
    wire [15:0] tile_addr_8bpp_16x16 = {      cur_tile_idx, scrolled_line_idx[3:0], word_cnt_r[1:0]};
    reg  [15:0] tile_addr_8bpp;
    always @* case ({reg_tile_width_r, reg_tile_height_r})
        2'b00: tile_addr_8bpp = tile_addr_8bpp_8x8;
        2'b01: tile_addr_8bpp = tile_addr_8bpp_8x16;
        2'b10: tile_addr_8bpp = tile_addr_8bpp_16x8;
        2'b11: tile_addr_8bpp = tile_addr_8bpp_16x16;
    endcase

    // Select tile address based on color depth
    reg  [15:0] tile_addr_xbpp;
    always @* case (color_depth)
        2'd0: tile_addr_xbpp = tile_addr_1bpp;
        2'd1: tile_addr_xbpp = tile_addr_2bpp;
        2'd2: tile_addr_xbpp = tile_addr_4bpp;
        2'd3: tile_addr_xbpp = tile_addr_8bpp;
    endcase

    // Calculate actual tile address
    wire [17:0] tile_addr = {reg_tile_baseaddr_r + tile_addr_xbpp, 2'b00};

    // Generate bus strobe
    reg bus_strobe_r;
    assign bus_strobe = bus_strobe_r && !bus_ack;

    // Line renderer state machine states
    reg [2:0] state_r;
    parameter
        WAIT_START      = 3'b000,
        FETCH_MAP       = 3'b001,
        WAIT_FETCH_MAP  = 3'b010,
        FETCH_TILE      = 3'b011,
        WAIT_FETCH_TILE = 3'b100,
        RENDER          = 3'b101;

    // Various registers used by state machine
    reg [31:0] tile_data_r, render_data_r;
    reg  [7:0] next_render_mapdata_r;
    reg  [7:0] render_mapdata_r;
    reg        render_start;
    wire       render_busy;
    wire       line_done;
    reg  [1:0] vscale_cnt_r;
    reg [11:0] vcnt_next_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r         <= WAIT_START;

            bus_addr        <= 0;
            bus_strobe_r    <= 0;

            vcnt_r          <= 0;
            vcnt_next_r     <= 0;

            vscale_cnt_r    <= 0;

            htile_cnt_r     <= 0;
            word_cnt_r      <= 0;

        end else begin
            render_start <= 0;

            case (state_r)
                WAIT_START: begin
                end

                FETCH_MAP: begin
                    bus_addr     <= map_addr;
                    bus_strobe_r <= 1;
                    state_r      <= WAIT_FETCH_MAP;
                end

                WAIT_FETCH_MAP: begin
                    if (bus_ack) begin
                        map_data_r   <= bus_rddata;
                        bus_strobe_r <= 0;
                        state_r      <= FETCH_TILE;
                    end
                end

                FETCH_TILE: begin
                    bus_addr     <= tile_addr;
                    bus_strobe_r <= 1;
                    state_r      <= WAIT_FETCH_TILE;
                end

                WAIT_FETCH_TILE: begin
                    if (bus_ack) begin
                        tile_data_r           <= bus_rddata;
                        bus_strobe_r          <= 0;
                        next_render_mapdata_r <= cur_map_data[15:8];
                        state_r               <= RENDER;
                    end
                end

                RENDER: begin
                    if (!render_busy) begin
                        case (lines_per_word_minus1)
                            2'd1: render_data_r <= {16'b0, scrolled_line_idx[0] ? tile_data_r[31:16] : tile_data_r[15:0]};
                            2'd3: case (scrolled_line_idx[1:0])
                                2'd0: render_data_r <= {24'b0, tile_data_r[7:0]};
                                2'd1: render_data_r <= {24'b0, tile_data_r[15:8]};
                                2'd2: render_data_r <= {24'b0, tile_data_r[23:16]};
                                2'd3: render_data_r <= {24'b0, tile_data_r[31:24]};
                            endcase

                            default: render_data_r <= tile_data_r;
                        endcase

                        render_mapdata_r <= next_render_mapdata_r;
                        render_start     <= 1;

                        if (word_cnt_r == words_per_line_minus1) begin
                            word_cnt_r <= 0;
                            htile_cnt_r <= htile_cnt_r + 1;

                            // Two map entries per word
                            state_r <= scrolled_htile_cnt[0] ? FETCH_MAP : FETCH_TILE;
                        end else begin
                            word_cnt_r <= word_cnt_r + 1;
                            state_r <= FETCH_TILE;
                        end
                    end

                    if (line_done) begin
                        state_r <= WAIT_START;
                    end
                end
            endcase

            if (start_of_line) begin
                state_r         <= FETCH_MAP;
                htile_cnt_r     <= 0;
                word_cnt_r      <= 0;
                vcnt_r          <= vcnt_next_r;

                if (vscale_cnt_r == reg_vscale_r) begin
                    vcnt_next_r     <= vcnt_next_r + 1;
                    vscale_cnt_r    <= 0;

                end else begin
                    vscale_cnt_r <= vscale_cnt_r + 1;
                end
            end

            if (start_of_screen) begin
                vcnt_r         <= 0;
                vcnt_next_r    <= (reg_vscale_r == 0) ? 1 : 0;
                vscale_cnt_r   <= 0;
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Pixel renderer
    //////////////////////////////////////////////////////////////////////////

    // Select current pixel for 1bpp modes
    reg cur_pixel_data_1bpp;
    always @* case (xcnt_r[3:0])
        // Byte 0
        4'd0:  cur_pixel_data_1bpp = render_data_r[7];
        4'd1:  cur_pixel_data_1bpp = render_data_r[6];
        4'd2:  cur_pixel_data_1bpp = render_data_r[5];
        4'd3:  cur_pixel_data_1bpp = render_data_r[4];
        4'd4:  cur_pixel_data_1bpp = render_data_r[3];
        4'd5:  cur_pixel_data_1bpp = render_data_r[2];
        4'd6:  cur_pixel_data_1bpp = render_data_r[1];
        4'd7:  cur_pixel_data_1bpp = render_data_r[0];

        // Byte 1
        4'd8:  cur_pixel_data_1bpp = render_data_r[15];
        4'd9:  cur_pixel_data_1bpp = render_data_r[14];
        4'd10: cur_pixel_data_1bpp = render_data_r[13];
        4'd11: cur_pixel_data_1bpp = render_data_r[12];
        4'd12: cur_pixel_data_1bpp = render_data_r[11];
        4'd13: cur_pixel_data_1bpp = render_data_r[10];
        4'd14: cur_pixel_data_1bpp = render_data_r[9];
        4'd15: cur_pixel_data_1bpp = render_data_r[8];
    endcase

    // Select current pixel for 2bpp modes
    reg [1:0] cur_pixel_data_2bpp;
    always @* case (xcnt_r[3:0])
        // Byte 0
        4'd0:  cur_pixel_data_2bpp = render_data_r[7:6];
        4'd1:  cur_pixel_data_2bpp = render_data_r[5:4];
        4'd2:  cur_pixel_data_2bpp = render_data_r[3:2];
        4'd3:  cur_pixel_data_2bpp = render_data_r[1:0];

        // Byte 1
        4'd4:  cur_pixel_data_2bpp = render_data_r[15:14];
        4'd5:  cur_pixel_data_2bpp = render_data_r[13:12];
        4'd6:  cur_pixel_data_2bpp = render_data_r[11:10];
        4'd7:  cur_pixel_data_2bpp = render_data_r[9:8];

        // Byte 2
        4'd8:  cur_pixel_data_2bpp = render_data_r[23:22];
        4'd9:  cur_pixel_data_2bpp = render_data_r[21:20];
        4'd10: cur_pixel_data_2bpp = render_data_r[19:18];
        4'd11: cur_pixel_data_2bpp = render_data_r[17:16];

        // Byte 3
        4'd12: cur_pixel_data_2bpp = render_data_r[31:30];
        4'd13: cur_pixel_data_2bpp = render_data_r[29:28];
        4'd14: cur_pixel_data_2bpp = render_data_r[27:26];
        4'd15: cur_pixel_data_2bpp = render_data_r[25:24];
    endcase

    // Select current pixel for 4bpp modes
    reg [3:0] cur_pixel_data_4bpp;
    always @* case (xcnt_r[2:0])
        // Byte 0
        3'd0: cur_pixel_data_4bpp = render_data_r[7:4];
        3'd1: cur_pixel_data_4bpp = render_data_r[3:0];

        // Byte 1
        3'd2: cur_pixel_data_4bpp = render_data_r[15:11];
        3'd3: cur_pixel_data_4bpp = render_data_r[10:8];

        // Byte 2
        3'd4: cur_pixel_data_4bpp = render_data_r[23:20];
        3'd5: cur_pixel_data_4bpp = render_data_r[19:16];

        // Byte 3
        3'd6: cur_pixel_data_4bpp = render_data_r[31:28];
        3'd7: cur_pixel_data_4bpp = render_data_r[27:24];
    endcase

    // Select current pixel for 8bpp modes
    reg [7:0] cur_pixel_data_8bpp;
    always @* case (xcnt_r[1:0])
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
    reg [7:0] tmp_pixel_color;
    always @* case (color_depth)
        // 1bpp
        2'd0: begin
            if (reg_mode_r == 0) begin
                // 16 color fg/bg mode
                tmp_pixel_color = cur_pixel_data_1bpp ? {4'b0, render_mapdata_r[3:0]} : {4'b0, render_mapdata_r[7:4]};
            end else begin
                // 256 color fg mode, fixed bg color 0
                tmp_pixel_color = cur_pixel_data_1bpp ? render_mapdata_r[7:0] : 8'd0;
            end
        end

        // 2bpp
        2'd1: tmp_pixel_color = {6'b0, cur_pixel_data_2bpp};

        // 4bpp
        2'd2: tmp_pixel_color = {4'b0, cur_pixel_data_4bpp};

        // 8bpp
        2'd3: tmp_pixel_color = cur_pixel_data_8bpp;
    endcase

    // Apply palette offset
    reg [7:0] cur_pixel_color;
    always @* begin
        cur_pixel_color[3:0] = tmp_pixel_color[3:0];
        if (color_depth != 0 && tmp_pixel_color[7:4] == 0 && tmp_pixel_color[3:0] != 0) begin
            cur_pixel_color[7:4] = render_mapdata_r[7:4];
        end else begin
            cur_pixel_color[7:4] = tmp_pixel_color[7:4];
        end
    end

    reg [9:0] lb_wridx_r;
    assign line_done = lb_wridx_r[9:7] == 3'b101;

    reg [1:0] hscale_cnt_r, hscale_cnt_next;

    reg [9:0] linebuf_wridx_next;
    reg [7:0] linebuf_wrdata_next;
    reg       linebuf_wren_next;

    reg [3:0] xcnt_r, xcnt_next;

    reg [9:0] lb_wridx_next;

    // -----------------------------------------------------------------------
    // The start position of the rendering in the line buffer depends on the
    // horizontal scroll position and the selected horizontal pixel scaling.
    wire [3:0] subtile_hscroll = reg_tile_width_r ? reg_hscroll_r[3:0] : reg_hscroll_r[2:0];

    reg [5:0] scaled_subtile_hscroll;
    always @* case (reg_hscale_r)
        2'd0: scaled_subtile_hscroll = {2'b0, subtile_hscroll};
        2'd1: scaled_subtile_hscroll = {1'b0, subtile_hscroll, 1'b0};
        2'd2: scaled_subtile_hscroll = {1'b0, subtile_hscroll, 1'b0} + {2'b0, subtile_hscroll};
        2'd3: scaled_subtile_hscroll = {subtile_hscroll, 2'b0};
    endcase

    wire [9:0] lb_wridx_start = 10'd0 - scaled_subtile_hscroll;
    // -----------------------------------------------------------------------


    reg render_busy_r, render_busy_next;
    assign render_busy = render_busy_next;

    always @* begin
        hscale_cnt_next     = hscale_cnt_r;
        xcnt_next           = xcnt_r;
        linebuf_wridx_next  = linebuf_wridx;
        linebuf_wrdata_next = linebuf_wrdata;
        linebuf_wren_next   = 0;
        lb_wridx_next       = lb_wridx_r;

        render_busy_next    = render_busy_r;

        if (!line_done && (render_busy_r || render_start)) begin
            if (hscale_cnt_r == reg_hscale_r) begin
                hscale_cnt_next = 0;

                if (xcnt_r == pixels_per_word_minus1) begin
                    render_busy_next = 0;
                    xcnt_next = 0;
                end else begin
                    xcnt_next = xcnt_r + 1;
                end

            end else begin
                hscale_cnt_next = hscale_cnt_r + 1;
            end

            if (render_start) begin
                xcnt_next = reg_hscale_r == 0 ? 'd1 : 0;
                render_busy_next = 1;
            end

            linebuf_wridx_next  = lb_wridx_r;
            linebuf_wrdata_next = cur_pixel_color;
            linebuf_wren_next   = 1;

            lb_wridx_next = lb_wridx_r + 1;
        end

        if (start_of_line) begin
            xcnt_next = 0;
            hscale_cnt_next = 0;
            render_busy_next = 0;

            // Handle sub-tile horizontal scrolling
            lb_wridx_next = lb_wridx_start;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            hscale_cnt_r    <= 0;
            xcnt_r          <= 0;
            linebuf_wridx   <= 0;
            linebuf_wrdata  <= 0;
            linebuf_wren    <= 0;
            lb_wridx_r      <= 0;
            render_busy_r   <= 0;

        end else begin
            hscale_cnt_r    <= hscale_cnt_next;
            xcnt_r          <= xcnt_next;
            linebuf_wridx   <= linebuf_wridx_next;
            linebuf_wrdata  <= linebuf_wrdata_next;
            linebuf_wren    <= linebuf_wren_next;
            lb_wridx_r      <= lb_wridx_next;
            render_busy_r   <= render_busy_next;
        end
    end

endmodule
