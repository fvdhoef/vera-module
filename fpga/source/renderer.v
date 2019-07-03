`default_nettype none

module renderer(
    input  wire        rst,
    input  wire        clk,

    // Registers
    input  wire [17:0] map_baseaddr,
    input  wire [17:0] tile_baseaddr,

    input  wire  [7:0] map_row_incr,

    // Bus master interface
    output reg  [17:0] bus_addr,
    input  wire [31:0] bus_data,
    input  wire        bus_ack,

    // Line buffer interface
    output reg  [10:0] linebuf_wridx,
    output reg   [7:0] linebuf_wrdata,
    output reg         linebuf_wren);


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


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            linebuf_wridx  <= 0;
            linebuf_wrdata <= 0;
            linebuf_wren   <= 0;

            // map_addr_r     <= 0;
            // tile_addr_r    <= 18'h20000;

            // state_r        <= FETCH_MAP;

        end else begin
            linebuf_wridx  <= linebuf_wridx + 1;
            linebuf_wrdata <= linebuf_wridx[7:0];
            linebuf_wren   <= 1;
        end
    end

endmodule
