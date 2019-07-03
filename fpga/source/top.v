`default_nettype none

module top(
    input  wire       clk25,

    // VGA interface
    output wire [3:0] vga_r       /* synthesis syn_useioff = 1 */,
    output wire [3:0] vga_g       /* synthesis syn_useioff = 1 */,
    output wire [3:0] vga_b       /* synthesis syn_useioff = 1 */,
    output wire       vga_hsync   /* synthesis syn_useioff = 1 */,
    output wire       vga_vsync   /* synthesis syn_useioff = 1 */,

    // Bus interface
    input  wire       extbus_res_n,  /* Reset */
    input  wire       extbus_phy2,   /* Bus clock */
    input  wire       extbus_cs_n,   /* Chip select */
    input  wire       extbus_rw_n,   /* Read(1) / write(0) */
    input  wire [2:0] extbus_a,      /* Address */
    inout  wire [7:0] extbus_d,      /* Data (bi-directional) */
    output wire       extbus_rdy,    /* Ready out */
    output wire       extbus_irq_n   /* IRQ */
);

    // Synchronize external asynchronous reset signal to clk25 domain
    wire intbus_reset;
    reset_sync reset_sync_clk25(
        .async_rst_in(!extbus_res_n),
        .clk(clk25),
        .reset_out(intbus_reset));

    wire intbus_clk = clk25;


    wire [17:0] intbus_addr;
    wire  [7:0] intbus_wrdata;
    wire        intbus_strobe;
    wire        intbus_write;

    // Address decoding:
    // 00000-1FFFF Main RAM (128kB)
    // 20000-20FFF Character ROM (4kB)
    // 30000-301FF Palette RAM (512B)
    wire mainram_sel = (intbus_addr[17] == 0);
    wire charrom_sel = (intbus_addr[17:16] == 2'b10);
    wire palette_sel = (intbus_addr[17:16] == 2'b11);

    // 16-bit byte sel
    wire [1:0] bytesel16 = intbus_addr[0] ? 2'b10 : 2'b01;

    // 32-bit byte sel
    reg [3:0] bytesel32;
    always @* case (intbus_addr[1:0])
        2'b00: bytesel32 = 4'b0001;
        2'b01: bytesel32 = 4'b0010;
        2'b10: bytesel32 = 4'b0100;
        2'b11: bytesel32 = 4'b1000;
    endcase

    //
    // Main RAM (128kB) 00000-1FFFF
    //
    wire [31:0] mainram_wrdata = {4{intbus_wrdata}};
    wire [31:0] mainram_rddata;
    wire        mainram_write = mainram_sel && intbus_strobe && intbus_write;

    main_ram main_ram(
        .clk(intbus_clk),
        .bus_addr(intbus_addr[16:2]),
        .bus_wrdata(mainram_wrdata),
        .bus_wrbytesel(bytesel32),
        .bus_rddata(mainram_rddata),
        .bus_write(mainram_write));

    //
    // Display line buffer
    //
    wire [10:0] linebuf_wridx;
    wire  [7:0] linebuf_wrdata;
    wire        linebuf_wren;

    wire [10:0] linebuf_rdidx;
    wire  [7:0] linebuf_rddata;

    dpram #(.ADDR_WIDTH(11), .DATA_WIDTH(8)) display_linebuf(
        .wr_clk(intbus_clk),
        .wr_addr(linebuf_wridx),
        .wr_en(linebuf_wren),
        .wr_data(linebuf_wrdata),

        .rd_clk(intbus_clk),
        .rd_addr(linebuf_rdidx),
        .rd_data(linebuf_rddata));

    //
    // Palette - 2 instances to allow for readback of palette entries
    //
    wire        palette_write = palette_sel && intbus_strobe && intbus_write;
    wire [15:0] palette_ib_rddata;

    wire [15:0] palette_rgb_data;

    palette_ram palette_ram(
        .wr_clk_i(intbus_clk),
        .rd_clk_i(intbus_clk),
        .wr_clk_en_i(1'b1),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .wr_en_i(palette_write),
        .wr_data_i({2{intbus_wrdata}}),
        .ben_i(bytesel16),
        .wr_addr_i(intbus_addr[8:1]),
        .rd_addr_i(linebuf_rddata),
        .rd_data_o(palette_rgb_data));

    palette_ram palette_ram_readback(
        .wr_clk_i(intbus_clk),
        .rd_clk_i(intbus_clk),
        .wr_clk_en_i(1'b1),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .wr_en_i(palette_write),
        .wr_data_i({2{intbus_wrdata}}),
        .ben_i(bytesel16),
        .wr_addr_i(intbus_addr[8:1]),
        .rd_addr_i(intbus_addr[8:1]),
        .rd_data_o(palette_ib_rddata));

    //
    // Charactor ROM (4kB) 20000-20FFF
    //
    wire [31:0] charrom_rddata;
    char_rom char_rom(
        .clk(intbus_clk),
        .rd_addr(intbus_addr[11:2]),
        .rd_data(charrom_rddata));

    reg [31:0] intbus_rddata;
    always @* begin
        intbus_rddata = 0;
        if (mainram_sel) intbus_rddata = mainram_rddata;
        if (charrom_sel) intbus_rddata = charrom_rddata;
        if (palette_sel) intbus_rddata = {2{palette_ib_rddata}};
    end

    reg [7:0] intbus_rddata8;
    always @* case (intbus_addr[1:0])
        2'b00: intbus_rddata8 = intbus_rddata[7:0];
        2'b01: intbus_rddata8 = intbus_rddata[15:8];
        2'b10: intbus_rddata8 = intbus_rddata[23:16];
        2'b11: intbus_rddata8 = intbus_rddata[31:24];
    endcase

    extbusif_6502 extbus(
        // 6502 slave bus interface
        .extbus_res_n(extbus_res_n),
        .extbus_phy2(extbus_phy2),
        .extbus_cs_n(extbus_cs_n),
        .extbus_rw_n(extbus_rw_n),
        .extbus_a(extbus_a),
        .extbus_d(extbus_d),
        .extbus_rdy(extbus_rdy),
        .extbus_irq_n(extbus_irq_n),

        // Iternal bus master interface
        .intbus_reset(intbus_reset),
        .intbus_clk(intbus_clk),
        .intbus_addr(intbus_addr),
        .intbus_wrdata(intbus_wrdata),
        .intbus_rddata(intbus_rddata8),
        .intbus_strobe(intbus_strobe),
        .intbus_write(intbus_write));

    // Renderer
    renderer renderer(
        .rst(intbus_reset),
        .clk(intbus_clk),

        // Line buffer interface
        .linebuf_wridx(linebuf_wridx),
        .linebuf_wrdata(linebuf_wrdata),
        .linebuf_wren(linebuf_wren));

    // VGA video
    video_vga video_vga(
        .rst(intbus_reset),
        .clk(intbus_clk),

        .pixel_width(2'd0),
        .pixel_height(2'd0),

        // Line buffer / palette interface
        .linebuf_idx(linebuf_rdidx),
        .linebuf_rgb_data(palette_rgb_data[11:0]),

        // VGA interface
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync));

endmodule
