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
    output reg  [15:0] bus_addr,
    input  wire [31:0] bus_rddata,
    output wire        bus_strobe,
    input  wire        bus_ack,

    // Sprite attribute RAM interface
    output wire  [7:0] sprite_idx,
    input  wire [47:0] sprite_attr,

    // Line buffer interface
    output reg   [9:0] linebuf_rdidx,
    input  wire [15:0] linebuf_rddata,

    output reg   [9:0] linebuf_wridx,
    output reg  [15:0] linebuf_wrdata,
    output reg         linebuf_wren);

    //////////////////////////////////////////////////////////////////////////
    // Register interface
    //////////////////////////////////////////////////////////////////////////

    // CTRL0
    reg  [1:0] reg_vscale_r;
    reg  [1:0] reg_hscale_r;
    reg        reg_enable_r;

    assign sprites_enabled = reg_enable_r;

    // Register interface read data
    always @* begin
        case (regs_addr)
            4'h0: regs_rddata = {3'b0, reg_vscale_r, reg_hscale_r, reg_enable_r};
            default: regs_rddata = 8'h00;
        endcase
    end

    // Register interface write data
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_vscale_r        <= 2'd0;
            reg_hscale_r        <= 2'd0;
            reg_enable_r        <= 0;

        end else begin
            if (regs_write) begin
                case (regs_addr[3:0])
                    4'h0: begin
                        reg_vscale_r <= regs_wrdata[4:3];
                        reg_hscale_r <= regs_wrdata[2:1];
                        reg_enable_r <= regs_wrdata[0];
                    end
                endcase
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Line renderer
    //////////////////////////////////////////////////////////////////////////

    reg [8:0] sprite_idx_r, sprite_idx_next;

    assign sprite_idx = sprite_idx_r[7:0];


    // Decode fields from sprite attributes
    wire  [9:0] sprite_x              = sprite_attr[9:0];
    wire        sprite_vflip          = sprite_attr[10];
    wire        sprite_hflip          = sprite_attr[11];
    wire  [3:0] sprite_palette_offset = sprite_attr[15:12];
    wire  [8:0] sprite_y              = sprite_attr[24:16];
    wire        sprite_mode           = sprite_attr[25];
    wire  [1:0] sprite_height         = sprite_attr[29:28];
    wire  [1:0] sprite_width          = sprite_attr[31:30];
    wire [11:0] sprite_addr           = sprite_attr[43:32];
    wire  [1:0] sprite_z              = sprite_attr[47:46];

    // Decode sprite height
    reg [5:0] sprite_height_pixels;
    always @* case (sprite_height)
        2'd0: sprite_height_pixels = 6'd7;
        2'd1: sprite_height_pixels = 6'd15;
        2'd2: sprite_height_pixels = 6'd31;
        2'd3: sprite_height_pixels = 6'd63;
    endcase

    // Determine if sprite is on current line
    wire [8:0] ydiff          = line_idx - sprite_y;
    wire       sprite_on_line = ydiff <= {3'b0, sprite_height_pixels};
    wire       sprite_enabled = sprite_z != 2'd0;
    wire [5:0] sprite_line    = sprite_vflip ? (sprite_height_pixels - ydiff[5:0]) : ydiff[5:0];

    // reg [13:0] addr;
    // always @* sprite_width


    wire render_busy;
    reg next_sprite;
    reg start_render;

    always @* begin
        sprite_idx_next = sprite_idx_r;
        next_sprite = 0;
        start_render = 0;

        if (sprite_idx_r[8] == 1'd0) begin
            if (sprite_enabled && sprite_on_line) begin
                if (render_busy) begin
                    next_sprite = 1;
                end

                start_render = 1;
            end else begin
                next_sprite = 1;
            end
        end

        if (next_sprite) begin
            sprite_idx_next = sprite_idx_r + 1;
        end
        if (line_render_start) begin
            sprite_idx_next = 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sprite_idx_r <= 0;
        end else begin
            sprite_idx_r <= sprite_idx_next;
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Fetch
    //////////////////////////////////////////////////////////////////////////

    reg [15:0] address_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            address_r <= 0;
        end else begin
            address_r <= address_r + 1;
        end
    end


    assign bus_strobe = 0;


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            linebuf_rdidx  <= 0;
            linebuf_wridx  <= 0;
            linebuf_wrdata <= 0;
            linebuf_wren   <= 0;

        end else begin
            linebuf_rdidx  <= 0;    //linebuf_rdidx + 1;
            linebuf_wridx  <= 0;    //linebuf_wridx + 1;
            linebuf_wrdata <= 0;    //linebuf_wrdata + 1;
            linebuf_wren   <= 0;    //1;
        end
    end

    reg  [9:0] render_x_r,     render_x_next;
    reg  [1:0] render_z_r,     render_z_next;
    reg  [1:0] render_width_r, render_width_next;
    reg [15:0] render_addr_r,  render_addr_next;


endmodule
