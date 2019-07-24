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

    // Modes:
    // 0 - 16 color text mode (foreground / background color specified per character)
    // 1 - 256 color text mode (background color fixed at 0)
    // 2 - Bitmapped mode
    // 3 - Tile mode

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
    reg  [9:0] reg_scroll_x_r;
    reg  [9:0] reg_scroll_y_r;

    always @* begin
        case (regs_addr)
            4'h0: regs_rddata = {reg_mode_r, reg_vscale_r, reg_hscale_r, reg_enable_r};
            4'h1: regs_rddata = {2'b0, reg_tile_height_r, reg_tile_width_r, reg_map_height_r, reg_map_width_r};
            4'h2: regs_rddata = reg_map_baseaddr_r[7:0];
            4'h3: regs_rddata = reg_map_baseaddr_r[15:8];
            4'h4: regs_rddata = reg_tile_baseaddr_r[7:0];
            4'h5: regs_rddata = reg_tile_baseaddr_r[15:8];
            4'h6: regs_rddata = reg_scroll_x_r[7:0];
            4'h7: regs_rddata = {6'b0, reg_scroll_x_r[9:8]};
            4'h8: regs_rddata = reg_scroll_y_r[7:0];
            4'h9: regs_rddata = {6'b0, reg_scroll_y_r[9:8]};
            default: regs_rddata = 8'h00;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_mode_r          <= 2'b00;
            reg_vscale_r        <= 2'd3;
            reg_hscale_r        <= 2'd3;
            reg_enable_r        <= 0;

            reg_tile_height_r   <= 0;
            reg_tile_width_r    <= 0;
            reg_map_height_r    <= 0;
            reg_map_width_r     <= 0;

            reg_map_baseaddr_r  <= 16'h0000;
            reg_tile_baseaddr_r <= 16'h8000;
            reg_scroll_x_r      <= 10'd0;
            reg_scroll_y_r      <= 10'd0;

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
                    4'h6: reg_scroll_x_r[7:0]       <= regs_wrdata;
                    4'h7: reg_scroll_x_r[9:8]       <= regs_wrdata[1:0];
                    4'h8: reg_scroll_y_r[7:0]       <= regs_wrdata;
                    4'h9: reg_scroll_y_r[9:8]       <= regs_wrdata[1:0];
                endcase
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Line renderer
    //////////////////////////////////////////////////////////////////////////

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




    reg [2:0] state_r;
    parameter
        WAIT_START      = 3'b000,
        FETCH_MAP       = 3'b001,
        WAIT_FETCH_MAP  = 3'b010,
        FETCH_TILE      = 3'b011,
        WAIT_FETCH_TILE = 3'b100,
        RENDER          = 3'b101;

    // Address of start of current map row
    reg [15:0] map_row_addr_r;
    reg [15:0] map_addr_r;

    // Address of current map column (actually 2 columns per entry)
    reg [15:0] map_col_addr_r;

    // Current line within row (8 lines per row)
    reg  [2:0] row_line_r;

    // Data as fetched from memory
    reg [31:0] map_data_r;

    reg map_data_sel_r;


    reg [2:0] ycnt_r;
    reg [2:0] ycnt_next_r;


    wire [15:0] cur_map_data = map_data_sel_r ? map_data_r[31:16] : map_data_r[15:0];
    wire  [7:0] cur_tile_idx = cur_map_data[7:0];

    reg bus_strobe_r;
    assign bus_strobe = bus_strobe_r && !bus_ack;

    reg [31:0] tile_data_r, render_data_r;
    reg [7:0] next_render_mapdata_r;

    reg [7:0] render_mapdata_r;
    reg       render_start;
    wire      render_busy;

    wire  line_done;

    reg [1:0] vscale_cnt_r;

    // bus interface is 32-bit, so each word read contains 2 tile entries
    //
    // start of line = x_idx = scroll_x >> 3
    // bus-addr = ((line_idx + scroll_y) / 8) * 64 + (idx)


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r         <= WAIT_START;

            bus_addr        <= 0;
            bus_strobe_r    <= 0;

            ycnt_r          <= 0;
            ycnt_next_r     <= 0;

            map_addr_r      <= 0;

            map_data_sel_r  <= 0;

            vscale_cnt_r    <= 0;

        end else begin
            render_start <= 0;

            case (state_r)
                WAIT_START: begin
                end

                FETCH_MAP: begin
                    bus_addr     <= {map_addr_r, 2'b00};
                    bus_strobe_r <= 1;

                    map_addr_r   <= map_addr_r + 1;

                    state_r <= WAIT_FETCH_MAP;
                end

                WAIT_FETCH_MAP: begin
                    if (bus_ack) begin
                        map_data_r   <= bus_rddata;
                        bus_strobe_r <= 0;

                        state_r <= FETCH_TILE;
                    end
                end

                FETCH_TILE: begin
                    bus_addr     <= {reg_tile_baseaddr_r, 2'b00} + {cur_tile_idx, ycnt_r[2], 2'b0};
                    bus_strobe_r <= 1;

                    state_r <= WAIT_FETCH_TILE;
                end

                WAIT_FETCH_TILE: begin
                    if (bus_ack) begin
                        bus_strobe_r <= 0;
                        tile_data_r <= bus_rddata;

                        next_render_mapdata_r <= cur_map_data[15:8];

                        state_r <= RENDER;
                    end
                end

                RENDER: begin
                    if (!render_busy) begin

                        case (lines_per_word_minus1)
                            2'd1: render_data_r <= {16'b0, ycnt_r[0] ? tile_data_r[31:16] : tile_data_r[15:0]};
                            2'd3: case (ycnt_r[1:0])
                                2'd0: render_data_r <= {24'b0, tile_data_r[7:0]};
                                2'd1: render_data_r <= {24'b0, tile_data_r[15:8]};
                                2'd2: render_data_r <= {24'b0, tile_data_r[23:16]};
                                2'd3: render_data_r <= {24'b0, tile_data_r[31:24]};
                            endcase

                            default: render_data_r <= tile_data_r;
                        endcase

                        render_mapdata_r <= next_render_mapdata_r;
                        render_start     <= 1;

                        state_r <= map_data_sel_r ? FETCH_MAP : FETCH_TILE;
                        map_data_sel_r <= !map_data_sel_r;
                    end

                    if (line_done) begin
                        state_r <= WAIT_START;
                    end
                end
            endcase

            if (start_of_line) begin
                state_r         <= FETCH_MAP;
                ycnt_r          <= ycnt_next_r;
                map_data_sel_r  <= 0;
                map_addr_r      <= map_row_addr_r;

                if (vscale_cnt_r == reg_vscale_r) begin
                    ycnt_next_r     <= ycnt_next_r + 1;
                    vscale_cnt_r    <= 0;

                    if (ycnt_next_r == 7) begin
                        map_row_addr_r <= map_row_addr_r + 40;
                    end
                end else begin
                    vscale_cnt_r <= vscale_cnt_r + 1;
                end

            end

            if (start_of_screen) begin
                map_row_addr_r <= reg_map_baseaddr_r;
                map_addr_r     <= reg_map_baseaddr_r;
                ycnt_r         <= 0;
                
                ycnt_next_r    <= (reg_vscale_r == 0) ? 1 : 0;
                vscale_cnt_r   <= 0;
            end
        end
    end



    //////////////////////////////////////////////////////////////////////////
    // Pixel renderer
    //////////////////////////////////////////////////////////////////////////

    reg cur_pixel_data;
    always @* case (xcnt_r[2:0])
        3'd0: cur_pixel_data = render_data_r[7];
        3'd1: cur_pixel_data = render_data_r[6];
        3'd2: cur_pixel_data = render_data_r[5];
        3'd3: cur_pixel_data = render_data_r[4];
        3'd4: cur_pixel_data = render_data_r[3];
        3'd5: cur_pixel_data = render_data_r[2];
        3'd6: cur_pixel_data = render_data_r[1];
        3'd7: cur_pixel_data = render_data_r[0];
    endcase

    wire [7:0] cur_pixel_color = cur_pixel_data ? {4'b0, render_mapdata_r[3:0]} : {4'b0, render_mapdata_r[7:4]};

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
    wire [3:0] subtile_hscroll = reg_tile_width_r ? reg_scroll_x_r[3:0] : reg_scroll_x_r[2:0];

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
