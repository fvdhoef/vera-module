`default_nettype none

module composer(
    input  wire        rst,
    input  wire        clk,

    // Register interface
    input  wire  [4:0] regs_addr,
    input  wire  [7:0] regs_wrdata,
    output wire  [7:0] regs_rddata,
    input  wire        regs_write,

    // Layer 1 interface
    output wire  [8:0] layer1_line_idx,
    output wire        layer1_line_render_start,
    input  wire        layer1_line_render_done,
    input  wire        layer1_enabled,
    output wire  [9:0] layer1_lb_rdidx,
    input  wire  [7:0] layer1_lb_rddata,

    // Layer 2 interface
    output wire  [8:0] layer2_line_idx,
    output wire        layer2_line_render_start,
    input  wire        layer2_line_render_done,
    input  wire        layer2_enabled,
    output wire  [9:0] layer2_lb_rdidx,
    input  wire  [7:0] layer2_lb_rddata,

    // Sprite interface
    output wire  [8:0] sprites_line_idx,
    output wire        sprites_line_render_start,
    input  wire        sprites_line_render_done,
    input  wire        sprites_enabled,
    output wire  [9:0] sprites_lb_rdidx,
    input  wire [15:0] sprites_lb_rddata,
    output reg   [9:0] sprites_lb_wridx,
    output wire [15:0] sprites_lb_wrdata,
    output reg         sprites_lb_wren,

    // Display interface
    input  wire  [8:0] display_line_idx,
    input  wire        display_start_of_screen,
    input  wire        display_start_of_line,
    input  wire        display_next_pixel,
    output reg   [7:0] display_data);

    reg [9:0] x_counter;

    reg render_start_r;
    always @(posedge clk) render_start_r <= display_start_of_line;


    assign layer1_line_idx           = display_line_idx;
    assign layer1_line_render_start  = render_start_r;
    assign layer2_line_idx           = display_line_idx;
    assign layer2_line_render_start  = render_start_r;
    assign sprites_line_idx          = display_line_idx;
    assign sprites_line_render_start = render_start_r;

    assign layer1_lb_rdidx           = x_counter;
    assign layer2_lb_rdidx           = x_counter;
    assign sprites_lb_rdidx          = x_counter;

    assign sprites_lb_wrdata = 16'h0000;

    wire layer1_opaque = layer1_lb_rddata[7:0] != 8'h0;
    wire layer2_opaque = layer2_lb_rddata[7:0] != 8'h0;
    wire sprite_opaque = sprites_lb_rddata[7:0] != 8'h0;

    wire sprite_z1 = sprites_lb_rddata[9:8] != 2'd1;
    wire sprite_z2 = sprites_lb_rddata[9:8] != 2'd2;
    wire sprite_z3 = sprites_lb_rddata[9:8] != 2'd3;

    always @* begin
        display_data = 8'h00;
        if (sprites_enabled && sprite_opaque && sprite_z1) display_data = sprites_lb_rddata[7:0];
        if (layer1_enabled  && layer1_opaque)              display_data = layer1_lb_rddata;
        if (sprites_enabled && sprite_opaque && sprite_z2) display_data = sprites_lb_rddata[7:0];
        if (layer2_enabled  && layer2_opaque)              display_data = layer2_lb_rddata;
        if (sprites_enabled && sprite_opaque && sprite_z3) display_data = sprites_lb_rddata[7:0];
    end

    assign regs_rddata = 8'h00;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
`ifdef __ICARUS__
            x_counter <= 10'd750;
`else
            x_counter <= 10'd0;
`endif
            sprites_lb_wren  <= 0;
            sprites_lb_wridx <= 0;

        end else begin
            sprites_lb_wren <= 0;

            if (display_next_pixel) begin
                if (x_counter < 'd640) begin
                    x_counter <= x_counter + 1;

                    sprites_lb_wridx <= x_counter;
                    sprites_lb_wren  <= 1;
                end
            end
            
            if (display_start_of_line) begin
                x_counter <= 0;
            end
        end
    end

endmodule
