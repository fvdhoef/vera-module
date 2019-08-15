`default_nettype none

module sprite_line_buffer(
    input  wire        rst,
    input  wire        clk,

    input  wire        active_render_buffer,

    // Renderer interface
    input  wire  [9:0] renderer_rd_idx,
    output wire [15:0] renderer_rd_data,
    input  wire  [9:0] renderer_wr_idx,
    input  wire [15:0] renderer_wr_data,
    input  wire        renderer_wr_en,

    // Composer interface
    input  wire  [9:0] composer_rd_idx,
    output wire [15:0] composer_rd_data,
    input  wire        composer_erase_start,
    output wire        composer_erase_busy);

    //////////////////////////////////////////////////////////////////////////
    // Line buffer 1
    //////////////////////////////////////////////////////////////////////////
    wire  [9:0] wr_addr_1;
    wire [15:0] wr_data_1;
    wire        wr_en_1a, wr_en_1b, wr_en_1c;
    wire  [9:0] rd_addr_1;
    wire [15:0] rd_data_1a, rd_data_1b, rd_data_1c;

    dpram #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) linebuf_1a(
        .wr_clk(clk), .wr_addr(wr_addr_1[7:0]), .wr_data(wr_data_1), .wr_en(wr_en_1a),
        .rd_clk(clk), .rd_addr(rd_addr_1[7:0]), .rd_data(rd_data_1a));
    dpram #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) linebuf_1b(
        .wr_clk(clk), .wr_addr(wr_addr_1[7:0]), .wr_data(wr_data_1), .wr_en(wr_en_1b),
        .rd_clk(clk), .rd_addr(rd_addr_1[7:0]), .rd_data(rd_data_1b));
    dpram #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) linebuf_1c(
        .wr_clk(clk), .wr_addr(wr_addr_1[7:0]), .wr_data(wr_data_1), .wr_en(wr_en_1c),
        .rd_clk(clk), .rd_addr(rd_addr_1[7:0]), .rd_data(rd_data_1c));

    // Multiplex read output
    reg [1:0] rd_addr_1_sel_r;
    always @(posedge clk) rd_addr_1_sel_r <= rd_addr_1[9:8];

    reg [15:0] rd_data_1;
    always @* case (rd_addr_1_sel_r)
        2'b00: rd_data_1 = rd_data_1a;
        2'b01: rd_data_1 = rd_data_1b;
        2'b10: rd_data_1 = rd_data_1c;
        default: rd_data_1 = 'h0;
    endcase
    
    //////////////////////////////////////////////////////////////////////////
    // Line buffer 2
    //////////////////////////////////////////////////////////////////////////
    wire  [9:0] wr_addr_2;
    wire [15:0] wr_data_2;
    wire        wr_en_2a, wr_en_2b, wr_en_2c;
    wire  [9:0] rd_addr_2;
    wire [15:0] rd_data_2a, rd_data_2b, rd_data_2c;

    dpram #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) linebuf_2a(
        .wr_clk(clk), .wr_addr(wr_addr_2[7:0]), .wr_data(wr_data_2), .wr_en(wr_en_2a),
        .rd_clk(clk), .rd_addr(rd_addr_2[7:0]), .rd_data(rd_data_2a));
    dpram #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) linebuf_2b(
        .wr_clk(clk), .wr_addr(wr_addr_2[7:0]), .wr_data(wr_data_2), .wr_en(wr_en_2b),
        .rd_clk(clk), .rd_addr(rd_addr_2[7:0]), .rd_data(rd_data_2b));
    dpram #(.ADDR_WIDTH(8), .DATA_WIDTH(16)) linebuf_2c(
        .wr_clk(clk), .wr_addr(wr_addr_2[7:0]), .wr_data(wr_data_2), .wr_en(wr_en_2c),
        .rd_clk(clk), .rd_addr(rd_addr_2[7:0]), .rd_data(rd_data_2c));

    // Multiplex read output
    reg [1:0] rd_addr_2_sel_r;
    always @(posedge clk) rd_addr_2_sel_r <= rd_addr_2[9:8];

    reg [15:0] rd_data_2;
    always @* case (rd_addr_2_sel_r)
        2'b00: rd_data_2 = rd_data_2a;
        2'b01: rd_data_2 = rd_data_2b;
        2'b10: rd_data_2 = rd_data_2c;
        default: rd_data_2 = 'h0;
    endcase

    //////////////////////////////////////////////////////////////////////////
    // Line buffer erase logic
    //////////////////////////////////////////////////////////////////////////
    reg [7:0] composer_wr_idx;
    reg       composer_wr_en;
    assign composer_erase_busy = composer_wr_idx != 'd255;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            composer_wr_idx <= 'd255;
            composer_wr_en  <= 0;

        end else begin
            composer_wr_en  <= 0;

            if (composer_erase_start) begin
                composer_wr_idx <= 0;
                composer_wr_en  <= 1;

            end else if (composer_erase_busy) begin
                composer_wr_idx <= composer_wr_idx + 1;
                composer_wr_en <= 1;
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Multiplexing of all signals
    //////////////////////////////////////////////////////////////////////////
    wire renderer_wr_en_a = renderer_wr_en && renderer_wr_idx[9:8] == 2'b00;
    wire renderer_wr_en_b = renderer_wr_en && renderer_wr_idx[9:8] == 2'b01;
    wire renderer_wr_en_c = renderer_wr_en && renderer_wr_idx[9:8] == 2'b10;

    assign rd_addr_1 = !active_render_buffer ? renderer_rd_idx  : composer_rd_idx;
    assign rd_addr_2 =  active_render_buffer ? renderer_rd_idx  : composer_rd_idx;
    assign wr_addr_1 = !active_render_buffer ? renderer_wr_idx  : {2'b0, composer_wr_idx};
    assign wr_addr_2 =  active_render_buffer ? renderer_wr_idx  : {2'b0, composer_wr_idx};
    assign wr_data_1 = !active_render_buffer ? renderer_wr_data : 16'b0;
    assign wr_data_2 =  active_render_buffer ? renderer_wr_data : 16'b0;
    assign wr_data_1 = !active_render_buffer ? renderer_wr_data : 16'b0;
    assign wr_data_2 =  active_render_buffer ? renderer_wr_data : 16'b0;
    assign wr_en_1a  = !active_render_buffer ? renderer_wr_en_a : composer_wr_en;
    assign wr_en_2a  =  active_render_buffer ? renderer_wr_en_a : composer_wr_en;
    assign wr_en_1b  = !active_render_buffer ? renderer_wr_en_b : composer_wr_en;
    assign wr_en_2b  =  active_render_buffer ? renderer_wr_en_b : composer_wr_en;
    assign wr_en_1c  = !active_render_buffer ? renderer_wr_en_c : composer_wr_en;
    assign wr_en_2c  =  active_render_buffer ? renderer_wr_en_c : composer_wr_en;

    assign renderer_rd_data = !active_render_buffer ? rd_data_1 : rd_data_2;
    assign composer_rd_data =  active_render_buffer ? rd_data_1 : rd_data_2;

endmodule
