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
    output wire [17:0] bus_addr,
    input  wire [31:0] bus_data,
    output wire        bus_strobe,
    input  wire        bus_ack,

    // Line buffer interface
    output reg   [9:0] linebuf_wridx,
    output reg   [7:0] linebuf_wrdata,
    output reg         linebuf_wren);

    assign bus_addr = 0;
    assign bus_strobe = 1'b0;

    // Modes:
    // 0 - 16 color text mode (foreground / background color specified per character)
    // 1 - 256 color text mode (background color fixed at 0)
    // 2 - Bitmapped mode
    // 3 - Tile mode

    //////////////////////////////////////////////////////////////////////////
    // Register interface
    //////////////////////////////////////////////////////////////////////////
    reg        reg_enable_r;
    reg  [2:0] reg_mode_r;
    reg [15:0] reg_map_baseaddr_r;
    reg [15:0] reg_tile_baseaddr_r;
    reg  [9:0] reg_scroll_x_r;
    reg  [9:0] reg_scroll_y_r;

    always @* begin
        case (regs_addr)
            4'h0: regs_rddata = {reg_mode_r, 4'b0, reg_enable_r};
            4'h1: regs_rddata = reg_map_baseaddr_r[7:0];
            4'h2: regs_rddata = reg_map_baseaddr_r[15:8];
            4'h3: regs_rddata = reg_tile_baseaddr_r[7:0];
            4'h4: regs_rddata = reg_tile_baseaddr_r[15:8];
            4'h5: regs_rddata = reg_scroll_x_r[7:0];
            4'h6: regs_rddata = {6'b0, reg_scroll_x_r[9:8]};
            4'h7: regs_rddata = reg_scroll_y_r[7:0];
            4'h9: regs_rddata = {6'b0, reg_scroll_y_r[9:8]};
            default: regs_rddata = 8'h00;
        endcase
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_enable_r        <= 0;
            reg_mode_r          <= 2'b00;
            reg_map_baseaddr_r  <= 16'h0;
            reg_tile_baseaddr_r <= 16'h0;
            reg_scroll_x_r      <= 10'd0;
            reg_scroll_y_r      <= 10'd0;

        end else begin
            if (regs_write) begin
                case (regs_addr[3:0])
                    4'h0: begin
                        reg_mode_r   <= regs_wrdata[7:5];
                        reg_enable_r <= regs_wrdata[0];
                    end

                    4'h1: reg_map_baseaddr_r[7:0]   <= regs_wrdata;
                    4'h2: reg_map_baseaddr_r[15:8]  <= regs_wrdata;
                    4'h3: reg_tile_baseaddr_r[7:0]  <= regs_wrdata;
                    4'h4: reg_tile_baseaddr_r[15:8] <= regs_wrdata;
                    4'h5: reg_scroll_x_r[7:0]       <= regs_wrdata;
                    4'h6: reg_scroll_x_r[9:8]       <= regs_wrdata[1:0];
                    4'h7: reg_scroll_y_r[7:0]       <= regs_wrdata;
                    4'h9: reg_scroll_y_r[9:8]       <= regs_wrdata[1:0];
                endcase
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Line renderer
    //////////////////////////////////////////////////////////////////////////






    // reg map_addr_r;
    // reg tile_addr_r;


    // // Map data format:
    // // - Text mode:
    // //    [7:0] character
    // //   [11:8] foreground color
    // //  [15:12] background color
    // // - Tile map mode:
    // //    [9:0] tile idx
    // //     [14] h-flip
    // //     [15] v-flip


    // //
    // // 1. Fetch map data (32-bit -> 2 tiles)
    // // 2. Fetch tile data (32-bit -> 4 pixels)
    // // 3. Render
    // //

    // parameter
    //     NEW_LINE     = 3'd0,
    //     FETCH_MAP    = 3'd1,
    //     FETCH_TILE   = 3'd2,
    //     FETCH_RENDER = 3'd3;

    // reg [2:0] state_r, state_next;
    // reg [17:0] map_addr_r, map_addr_next;

    // reg [17:0] bus_addr_next;

    // always @* begin
    //     state_next    = state_r;
    //     map_addr_next = map_addr_r;

    //     bus_addr_next = bus_addr;

    //     case (state_r)
    //         NEW_LINE: begin
    //             map_addr_next = map_baseaddr;
    //         end

    //         FETCH_MAP: 

    //     endcase

    // end

    // always @(posedge clk or posedge rst) begin
    //     if (rst) begin
    //         state_r <= FETCH_MAP;

    //     end else begin
    //         state_r <= state_next;
    //     end
    // end


    reg [9:0] linebuf_wridx_next;
    reg [7:0] linebuf_wrdata_next;
    reg       linebuf_wren_next;

    always @* begin
        linebuf_wridx_next  = linebuf_wridx;
        linebuf_wrdata_next = linebuf_wrdata;
        linebuf_wren_next   = linebuf_wren;

        if (start_of_line) begin
            linebuf_wridx_next = 0;
        end else begin
            linebuf_wridx_next = linebuf_wridx + 1;
        end

        linebuf_wrdata_next = linebuf_wridx_next[7:0];
        linebuf_wren_next   = 1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            linebuf_wridx  <= 0;
            linebuf_wrdata <= 0;
            linebuf_wren   <= 0;

        end else begin
            linebuf_wridx  <= linebuf_wridx_next;
            linebuf_wrdata <= linebuf_wrdata_next;
            linebuf_wren   <= linebuf_wren_next;
        end
    end

endmodule
