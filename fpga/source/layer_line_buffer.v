`default_nettype none

module layer_line_buffer(
    input  wire        rst,
    input  wire        clk,

    input  wire        active_render_buffer,

    // Renderer interface
    input  wire  [9:0] renderer_wr_idx,
    input  wire  [7:0] renderer_wr_data,
    input  wire        renderer_wr_en,

    // Composer interface
    input  wire  [9:0] composer_rd_idx,
    output wire  [7:0] composer_rd_data);

    dpram #(.ADDR_WIDTH(11), .DATA_WIDTH(8)) linebuf(
        .wr_clk(clk), .wr_addr({ active_render_buffer, renderer_wr_idx}), .wr_data(renderer_wr_data), .wr_en(renderer_wr_en),
        .rd_clk(clk), .rd_addr({!active_render_buffer, composer_rd_idx}), .rd_data(composer_rd_data));

endmodule
