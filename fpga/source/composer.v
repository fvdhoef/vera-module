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
    input  wire        layer1_enabled,
    output wire        layer1_start_of_screen,
    output wire        layer1_start_of_line,
    output wire  [9:0] layer1_lb_idx,
    input  wire  [7:0] layer1_lb_data,

    // Layer 2 interface
    input  wire        layer2_enabled,
    output wire        layer2_start_of_screen,
    output wire        layer2_start_of_line,
    output wire  [9:0] layer2_lb_idx,
    input  wire  [7:0] layer2_lb_data,

    // Sprite interface
    input  wire        sprite_enabled,
    output wire        sprite_start_of_screen,
    output wire        sprite_start_of_line,
    output wire  [9:0] sprite_lb_idx,
    input  wire [15:0] sprite_lb_data,

    // Display interface
    input  wire        display_start_of_screen,
    input  wire        display_start_of_line,
    input  wire        display_next_pixel,
    output reg   [7:0] display_data);

    reg [9:0] x_counter;

    assign layer1_start_of_screen = display_start_of_screen;
    assign layer1_start_of_line   = display_start_of_line;
    assign layer1_lb_idx          = x_counter;

    assign layer2_start_of_screen = display_start_of_screen;
    assign layer2_start_of_line   = display_start_of_line;
    assign layer2_lb_idx          = x_counter;

    assign sprite_start_of_screen = display_start_of_screen;
    assign sprite_start_of_line   = display_start_of_line;
    assign sprite_lb_idx          = x_counter;

    wire layer1_opaque = layer1_lb_data[7:0] != 8'h0;
    wire layer2_opaque = layer2_lb_data[7:0] != 8'h0;
    wire sprite_opaque = sprite_lb_data[7:0] != 8'h0;

    wire sprite_z1 = sprite_lb_data[9:8] != 2'd1;
    wire sprite_z2 = sprite_lb_data[9:8] != 2'd2;
    wire sprite_z3 = sprite_lb_data[9:8] != 2'd3;

    always @* begin
        display_data = 8'h00;
        if (sprite_enabled && sprite_opaque && sprite_z1) display_data = sprite_lb_data[7:0];
        if (layer1_enabled && layer1_opaque)              display_data = layer1_lb_data;
        if (sprite_enabled && sprite_opaque && sprite_z2) display_data = sprite_lb_data[7:0];
        if (layer2_enabled && layer2_opaque)              display_data = layer2_lb_data;
        if (sprite_enabled && sprite_opaque && sprite_z3) display_data = sprite_lb_data[7:0];
    end

    assign regs_rddata = 8'h00;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
`ifdef __ICARUS__
            x_counter <= 10'd750;
`else
            x_counter <= 10'd0;
`endif
        end else begin
            x_counter <= display_start_of_line ? 0 : (x_counter + 1);
        end
    end

endmodule
