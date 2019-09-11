`default_nettype none

module top(
    input  wire       clk25,

    // External 6502 bus interface
    output wire       extbus_phi2_n, /* Bus clock */
    input  wire       extbus_cs_n,   /* Chip select */
    input  wire       extbus_rw_n,   /* Read(1) / write(0) */
    input  wire [2:0] extbus_a,      /* Address */
    inout  wire [7:0] extbus_d,      /* Data (bi-directional) */
    output wire       extbus_irq_n,  /* IRQ */

    // VGA interface
    output reg  [3:0] vga_r       /* synthesis syn_useioff = 1 */,
    output reg  [3:0] vga_g       /* synthesis syn_useioff = 1 */,
    output reg  [3:0] vga_b       /* synthesis syn_useioff = 1 */,
    output reg        vga_hsync   /* synthesis syn_useioff = 1 */,
    output reg        vga_vsync   /* synthesis syn_useioff = 1 */,

    // SPI interface
    output wire       spi_sck,
    output wire       spi_mosi,
    input  wire       spi_miso,
    output wire       spi_ssel_n_sd,

    // DBG serial interface
    input  wire       uart_rxd,
    output wire       uart_txd,

    // Audio output
    output wire       audio_lrck,
    output wire       audio_bck,
    output wire       audio_data
);

    // Register bus signals
    wire [18:0] regbus_addr;
    wire  [7:0] regbus_wrdata;
    reg   [7:0] regbus_rddata;
    wire        regbus_strobe;
    wire        regbus_write;

    // Register bus read outputs
    wire  [7:0] layer1_regs_rddata;
    wire  [7:0] layer2_regs_rddata;
    wire  [7:0] sprites_regs_rddata;
    wire  [7:0] composer_regs_rddata;
    wire  [7:0] palette_rddata;
    reg   [7:0] sprite_attr_rddata;
    wire  [7:0] uart_rddata;

    // Memory bus signals
    reg  [17:0] membus_addr;
    wire [31:0] membus_wrdata;
    reg  [31:0] membus_rddata;
    reg   [3:0] membus_bytesel;
    wire        membus_strobe;
    reg         membus_write;

    // Memory bus read outputs
    wire [31:0] mainram_rddata;
    wire [31:0] charrom_rddata;

    wire [15:0] layer1_bm_addr;
    wire        layer1_bm_strobe;
    reg         layer1_bm_ack;
    reg         layer1_bm_ack_next;

    wire [15:0] layer2_bm_addr;
    wire        layer2_bm_strobe;
    reg         layer2_bm_ack;
    reg         layer2_bm_ack_next;

    wire [15:0] sprite_bm_addr;
    wire        sprite_bm_strobe;
    reg         sprite_bm_ack;
    reg         sprite_bm_ack_next;

    // Line buffer signals
    wire  [9:0] layer1_linebuf_wridx;
    wire  [7:0] layer1_linebuf_wrdata;
    wire        layer1_linebuf_wren;
    wire  [9:0] layer1_linebuf_rdidx;
    wire  [7:0] layer1_linebuf_rddata;

    wire  [9:0] layer2_linebuf_wridx;
    wire  [7:0] layer2_linebuf_wrdata;
    wire        layer2_linebuf_wren;
    wire  [9:0] layer2_linebuf_rdidx;
    wire  [7:0] layer2_linebuf_rddata;

    wire  [9:0] sprite_lb_renderer_rd_idx;
    wire [15:0] sprite_lb_renderer_rd_data;
    wire  [9:0] sprite_lb_renderer_wr_idx;
    wire [15:0] sprite_lb_renderer_wr_data;
    wire        sprite_lb_renderer_wr_en;
    wire  [9:0] sprite_lb_composer_rd_idx;
    wire [15:0] sprite_lb_composer_rd_data;
    wire        sprite_lb_composer_erase_start;
    wire        sprite_lb_composer_erase_busy;

    wire  [7:0] sprite_idx;
    wire [31:0] sprite_attr;

    wire        line_irq;
    wire        sprcol_irq;
    wire        uart_irq;

    wire next_frame;
    wire vblank_pulse;
    wire next_line;

    //////////////////////////////////////////////////////////////////////////
    // Synchronize external asynchronous reset signal to clk25 domain
    //////////////////////////////////////////////////////////////////////////
    reg [7:0] por_cnt_r = 0;
    always @(posedge clk25) if (!por_cnt_r[7]) por_cnt_r <= por_cnt_r + 1;

    wire reset;
    reset_sync reset_sync_clk25(
        .async_rst_in(!por_cnt_r[7]),
        .clk(clk25),
        .reset_out(reset));

    wire clk = clk25;

    //////////////////////////////////////////////////////////////////////////
    // Register bus
    //////////////////////////////////////////////////////////////////////////

    wire [7:0] irqs;

    // External 6502 bus to register bus master
    extbusif_6502 extbus(
        .rst(reset),
        .clk(clk),

        // 6502 slave bus interface
        .extbus_phi2_n(extbus_phi2_n),
        .extbus_cs_n(extbus_cs_n),
        .extbus_rw_n(extbus_rw_n),
        .extbus_a(extbus_a),
        .extbus_d(extbus_d),
        .extbus_irq_n(extbus_irq_n),

        // Bus master interface
        .bm_addr(regbus_addr),
        .bm_wrdata(regbus_wrdata),
        .bm_rddata(regbus_rddata),
        .bm_strobe(regbus_strobe),
        .bm_write(regbus_write),
        
        .irqs(irqs));

    assign irqs = {4'b0, uart_irq, sprcol_irq, line_irq, vblank_pulse};

    // Register bus memory map:
    // 00000-1FFFF  Main RAM
    // 20000-20FFF  Character ROM
    // 40000-4000F  Layer 1 registers
    // 40010-4001F  Layer 2 registers
    // 40020-4002F  Sprite registers
    // 40030-4003F  ---
    // 40040-4005F  Composer registers
    // 40200-403FF  Palette
    // 40800-40FFF  Sprite attributes
    // 41000-41003  UART
    wire membus_sel        = !regbus_addr[18];
    wire layer1_regs_sel   = regbus_addr[18] && regbus_addr[17:4]  == 'b00_00000000_0000;
    wire layer2_regs_sel   = regbus_addr[18] && regbus_addr[17:4]  == 'b00_00000000_0001;
    wire sprites_regs_sel  = regbus_addr[18] && regbus_addr[17:4]  == 'b00_00000000_0010;
    wire composer_regs_sel = regbus_addr[18] && regbus_addr[17:5]  == 'b00_00000000_010;
    wire palette_sel       = regbus_addr[18] && regbus_addr[17:9]  == 'b00_0000001;
    wire sprite_attr_sel   = regbus_addr[18] && regbus_addr[17:11] == 'b00_00001;
    wire uart_sel          = regbus_addr[18] && regbus_addr[17:12] == 'b00_0001;

    // Memory bus read data selection
    reg [7:0] membus_rddata8;
    always @* case (regbus_addr[1:0])
        2'b00: membus_rddata8 = membus_rddata[7:0];
        2'b01: membus_rddata8 = membus_rddata[15:8];
        2'b10: membus_rddata8 = membus_rddata[23:16];
        2'b11: membus_rddata8 = membus_rddata[31:24];
    endcase

    // Register bus read data mux
    always @* begin
        regbus_rddata = 8'h00;
        if (membus_sel)        regbus_rddata = membus_rddata8;
        if (layer1_regs_sel)   regbus_rddata = layer1_regs_rddata;
        if (layer2_regs_sel)   regbus_rddata = layer2_regs_rddata;
        if (sprites_regs_sel)  regbus_rddata = sprites_regs_rddata;
        if (composer_regs_sel) regbus_rddata = composer_regs_rddata;
        if (palette_sel)       regbus_rddata = palette_rddata;
        if (sprite_attr_sel)   regbus_rddata = sprite_attr_rddata;
        if (uart_sel)          regbus_rddata = uart_rddata;
    end

    //////////////////////////////////////////////////////////////////////////
    // Memory bus
    //////////////////////////////////////////////////////////////////////////

    // Memory bus memory map:
    // 00000-1FFFF  Main RAM
    // 20000-20FFF  Character ROM
    wire mainram_sel = (membus_addr[17]    == 0);
    wire charrom_sel = (membus_addr[17:12] == 6'b10_0000);

    assign membus_wrdata = {4{regbus_wrdata}};
    always @* case (membus_addr[1:0])
        2'b00: membus_bytesel = 4'b0001;
        2'b01: membus_bytesel = 4'b0010;
        2'b10: membus_bytesel = 4'b0100;
        2'b11: membus_bytesel = 4'b1000;
    endcase

    // Read data mux (with pipeline delay on selection)
    reg mainram_sel_r, charrom_sel_r;
    always @(posedge clk) begin
        mainram_sel_r <= mainram_sel;
        charrom_sel_r <= charrom_sel;
    end

    always @* begin
        membus_rddata = 32'h00000000;
        if (mainram_sel_r) membus_rddata = mainram_rddata;
        if (charrom_sel_r) membus_rddata = charrom_rddata;
    end

    wire regbus_bm_strobe = membus_sel && regbus_strobe;

    assign membus_strobe = regbus_bm_strobe || layer1_bm_strobe || layer2_bm_strobe || sprite_bm_strobe;

    always @* begin
        membus_addr        = 18'b0;
        membus_write       = 1'b0;
        layer1_bm_ack_next = 1'b0;
        layer2_bm_ack_next = 1'b0;
        sprite_bm_ack_next = 1'b0;

        if (regbus_bm_strobe) begin
            membus_addr        = regbus_addr[17:0];
            membus_write       = regbus_write;

        end else if (layer1_bm_strobe) begin
            membus_addr        = {layer1_bm_addr, 2'b0};
            layer1_bm_ack_next = 1'b1;

        end else if (layer2_bm_strobe) begin
            membus_addr        = {layer2_bm_addr, 2'b0};
            layer2_bm_ack_next = 1'b1;

        end else if (sprite_bm_strobe) begin
            membus_addr        = {sprite_bm_addr, 2'b0};
            sprite_bm_ack_next = 1'b1;
        end
    end

    always @(posedge clk) layer1_bm_ack <= layer1_bm_ack_next;
    always @(posedge clk) layer2_bm_ack <= layer2_bm_ack_next;
    always @(posedge clk) sprite_bm_ack <= sprite_bm_ack_next;

    //////////////////////////////////////////////////////////////////////////
    // Layer 1 renderer
    //////////////////////////////////////////////////////////////////////////
    wire        layer1_regs_write = layer1_regs_sel && regbus_strobe && regbus_write;
    wire  [8:0] layer1_line_idx;
    wire        layer1_line_render_start;
    wire        layer1_line_render_done;
    wire        layer1_enabled;

    layer_renderer layer1_renderer(
        .rst(reset),
        .clk(clk),

        // Composer interface
        .line_idx(layer1_line_idx),
        .line_render_start(layer1_line_render_start),
        .line_render_done(layer1_line_render_done),
        .layer_enabled(layer1_enabled),

        // Register interface (on register bus)
        .regs_addr(regbus_addr[3:0]),
        .regs_wrdata(regbus_wrdata),
        .regs_rddata(layer1_regs_rddata),
        .regs_write(layer1_regs_write),

        // Bus master interface
        .bus_addr(layer1_bm_addr),
        .bus_rddata(membus_rddata),
        .bus_strobe(layer1_bm_strobe),
        .bus_ack(layer1_bm_ack),

        // Line buffer interface
        .linebuf_wridx(layer1_linebuf_wridx),
        .linebuf_wrdata(layer1_linebuf_wrdata),
        .linebuf_wren(layer1_linebuf_wren));

    //////////////////////////////////////////////////////////////////////////
    // Layer 2 renderer
    //////////////////////////////////////////////////////////////////////////
    wire        layer2_regs_write = layer2_regs_sel && regbus_strobe && regbus_write;
    wire  [8:0] layer2_line_idx;
    wire        layer2_line_render_start;
    wire        layer2_line_render_done;
    wire        layer2_enabled;

    layer_renderer layer2_renderer(
        .rst(reset),
        .clk(clk),

        // Composer interface
        .line_idx(layer2_line_idx),
        .line_render_start(layer2_line_render_start),
        .line_render_done(layer2_line_render_done),
        .layer_enabled(layer2_enabled),

        // Register interface (on register bus)
        .regs_addr(regbus_addr[3:0]),
        .regs_wrdata(regbus_wrdata),
        .regs_rddata(layer2_regs_rddata),
        .regs_write(layer2_regs_write),

        // Bus master interface
        .bus_addr(layer2_bm_addr),
        .bus_rddata(membus_rddata),
        .bus_strobe(layer2_bm_strobe),
        .bus_ack(layer2_bm_ack),

        // Line buffer interface
        .linebuf_wridx(layer2_linebuf_wridx),
        .linebuf_wrdata(layer2_linebuf_wrdata),
        .linebuf_wren(layer2_linebuf_wren));

    //////////////////////////////////////////////////////////////////////////
    // Sprite renderer
    //////////////////////////////////////////////////////////////////////////
    wire        sprites_regs_write = sprites_regs_sel && regbus_strobe && regbus_write;
    wire  [8:0] sprites_line_idx;
    wire        sprites_line_render_start;
    wire        sprites_line_render_done;
    wire        sprites_enabled;

    sprite_renderer sprite_renderer(
        .rst(reset),
        .clk(clk),

        .sprcol_irq(sprcol_irq),

        // Composer interface
        .line_idx(sprites_line_idx),
        .line_render_start(sprites_line_render_start),
        .line_render_done(sprites_line_render_done),
        .sprites_enabled(sprites_enabled),
        .frame_done(vblank_pulse),

        // Register interface (on register bus)
        .regs_addr(regbus_addr[3:0]),
        .regs_wrdata(regbus_wrdata),
        .regs_rddata(sprites_regs_rddata),
        .regs_write(sprites_regs_write),

        // Bus master interface
        .bus_addr(sprite_bm_addr),
        .bus_rddata(membus_rddata),
        .bus_strobe(sprite_bm_strobe),
        .bus_ack(sprite_bm_ack),

        // Sprite attribute RAM interface
        .sprite_idx(sprite_idx),
        .sprite_attr(sprite_attr),

        // Line buffer interface
        .linebuf_rdidx(sprite_lb_renderer_rd_idx),
        .linebuf_rddata(sprite_lb_renderer_rd_data),

        .linebuf_wridx(sprite_lb_renderer_wr_idx),
        .linebuf_wrdata(sprite_lb_renderer_wr_data),
        .linebuf_wren(sprite_lb_renderer_wr_en));

    //////////////////////////////////////////////////////////////////////////
    // Composer
    //////////////////////////////////////////////////////////////////////////
    wire composer_regs_write = composer_regs_sel && regbus_strobe && regbus_write;
    wire [7:0] composer_display_data;
    wire       next_pixel;
    wire [1:0] display_mode;
    wire       display_chroma_disable;

    wire       composer_display_current_field;

    composer composer(
        .rst(reset),
        .clk(clk),

        .line_irq(line_irq),

        // Register interface
        .regs_addr(regbus_addr[4:0]),
        .regs_wrdata(regbus_wrdata),
        .regs_rddata(composer_regs_rddata),
        .regs_write(composer_regs_write),

        // Layer 1 interface
        .layer1_line_idx(layer1_line_idx),
        .layer1_line_render_start(layer1_line_render_start),
        .layer1_line_render_done(layer1_line_render_done),
        .layer1_enabled(layer1_enabled),
        .layer1_lb_rdidx(layer1_linebuf_rdidx),
        .layer1_lb_rddata(layer1_linebuf_rddata),

        // Layer 2 interface
        .layer2_line_idx(layer2_line_idx),
        .layer2_line_render_start(layer2_line_render_start),
        .layer2_line_render_done(layer2_line_render_done),
        .layer2_enabled(layer2_enabled),
        .layer2_lb_rdidx(layer2_linebuf_rdidx),
        .layer2_lb_rddata(layer2_linebuf_rddata),

        // Sprite interface
        .sprites_line_idx(sprites_line_idx),
        .sprites_line_render_start(sprites_line_render_start),
        .sprites_line_render_done(sprites_line_render_done),
        .sprites_enabled(sprites_enabled),

        .sprite_lb_rdidx(sprite_lb_composer_rd_idx),
        .sprite_lb_rddata(sprite_lb_composer_rd_data),
        .sprite_lb_erase_start(sprite_lb_composer_erase_start),
        .sprite_lb_erase_busy(sprite_lb_composer_erase_busy),

        // Display interface
        .display_next_frame(next_frame),
        .display_next_line(next_line),
        .display_next_pixel(next_pixel),
        .display_current_field(composer_display_current_field),
        .display_data(composer_display_data),

        // Video selection
        .display_mode(display_mode),
        .chroma_disable(display_chroma_disable));

    //////////////////////////////////////////////////////////////////////////
    // Palette (2 instances to allow for readback of palette entries)
    //////////////////////////////////////////////////////////////////////////
    wire        palette_write   = palette_sel && regbus_strobe && regbus_write;
    wire  [1:0] palette_bytesel = regbus_addr[0] ? 2'b10 : 2'b01;

    wire [15:0] palette_rgb_data;
    wire [15:0] palette_rddata16;

    assign palette_rddata = regbus_addr[0] ? palette_rddata16[15:8] : palette_rddata16[7:0];

    palette_ram palette_ram(
        .wr_clk_i(clk),
        .rd_clk_i(clk),
        .wr_clk_en_i(1'b1),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .wr_en_i(palette_write),
        .wr_data_i({2{regbus_wrdata}}),
        .ben_i(palette_bytesel),
        .wr_addr_i(regbus_addr[8:1]),
        .rd_addr_i(composer_display_data),
        .rd_data_o(palette_rgb_data));

    palette_ram palette_ram_readback(
        .wr_clk_i(clk),
        .rd_clk_i(clk),
        .wr_clk_en_i(1'b1),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .wr_en_i(palette_write),
        .wr_data_i({2{regbus_wrdata}}),
        .ben_i(palette_bytesel),
        .wr_addr_i(regbus_addr[8:1]),
        .rd_addr_i(regbus_addr[8:1]),
        .rd_data_o(palette_rddata16));

    //////////////////////////////////////////////////////////////////////////
    // Sprite attribute RAM
    //////////////////////////////////////////////////////////////////////////
    wire        sprite_attr_write = sprite_attr_sel && regbus_strobe && regbus_write;

    reg   [3:0] sprite_attr_bytesel;
    always @* case (regbus_addr[1:0])
        3'd0: sprite_attr_bytesel = 4'b0001;
        3'd1: sprite_attr_bytesel = 4'b0010;
        3'd2: sprite_attr_bytesel = 4'b0100;
        3'd3: sprite_attr_bytesel = 4'b1000;
    endcase

    wire [31:0] sprite_ram_rddata32;
    always @* case (regbus_addr[1:0])
        3'd0: sprite_attr_rddata = sprite_ram_rddata32[7:0];
        3'd1: sprite_attr_rddata = sprite_ram_rddata32[15:8];
        3'd2: sprite_attr_rddata = sprite_ram_rddata32[23:16];
        3'd3: sprite_attr_rddata = sprite_ram_rddata32[31:24];
    endcase

    sprite_ram sprite_attr_ram(
        .wr_clk_i(clk),
        .rd_clk_i(clk),
        .wr_clk_en_i(1'b1),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .wr_en_i(sprite_attr_write),
        .wr_data_i({4{regbus_wrdata}}),
        .ben_i(sprite_attr_bytesel),
        .wr_addr_i(regbus_addr[9:2]),
        .rd_addr_i(sprite_idx),
        .rd_data_o(sprite_attr));

    sprite_ram sprite_attr_ram_readback(
        .wr_clk_i(clk),
        .rd_clk_i(clk),
        .wr_clk_en_i(1'b1),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .wr_en_i(sprite_attr_write),
        .wr_data_i({4{regbus_wrdata}}),
        .ben_i(sprite_attr_bytesel),
        .wr_addr_i(regbus_addr[9:2]),
        .rd_addr_i(regbus_addr[9:2]),
        .rd_data_o(sprite_ram_rddata32));

    //////////////////////////////////////////////////////////////////////////
    // Main RAM
    //////////////////////////////////////////////////////////////////////////
    wire mainram_write = mainram_sel && membus_strobe && membus_write;

    main_ram main_ram(
        .clk(clk),
        .bus_addr(membus_addr[16:2]),
        .bus_wrdata(membus_wrdata),
        .bus_wrbytesel(membus_bytesel),
        .bus_rddata(mainram_rddata),
        .bus_write(mainram_write));

    //////////////////////////////////////////////////////////////////////////
    // Charactor ROM
    //////////////////////////////////////////////////////////////////////////
    char_rom char_rom(
        .clk(clk),
        .rd_addr(membus_addr[11:2]),
        .rd_data(charrom_rddata));

    //////////////////////////////////////////////////////////////////////////
    // Line buffers
    //////////////////////////////////////////////////////////////////////////
    reg active_line_buf_r;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            active_line_buf_r <= 0;
        end else begin
            if (next_line) begin
                active_line_buf_r <= !active_line_buf_r;
            end
        end
    end

    // Layer 1 line buffer
    layer_line_buffer layer1_line_buffer(
        .rst(reset),
        .clk(clk),

        .active_render_buffer(active_line_buf_r),

        // Renderer interface
        .renderer_wr_idx(layer1_linebuf_wridx),
        .renderer_wr_data(layer1_linebuf_wrdata),
        .renderer_wr_en(layer1_linebuf_wren),

        // Composer interface
        .composer_rd_idx(layer1_linebuf_rdidx),
        .composer_rd_data(layer1_linebuf_rddata));

    // Layer 2 line buffer
    layer_line_buffer layer2_line_buffer(
        .rst(reset),
        .clk(clk),

        .active_render_buffer(active_line_buf_r),

        // Renderer interface
        .renderer_wr_idx(layer2_linebuf_wridx),
        .renderer_wr_data(layer2_linebuf_wrdata),
        .renderer_wr_en(layer2_linebuf_wren),

        // Composer interface
        .composer_rd_idx(layer2_linebuf_rdidx),
        .composer_rd_data(layer2_linebuf_rddata));

    // Sprite line buffers
    sprite_line_buffer sprite_line_buffer(
        .rst(reset),
        .clk(clk),

        .active_render_buffer(active_line_buf_r),

        // Renderer interface
        .renderer_rd_idx(sprite_lb_renderer_rd_idx),
        .renderer_rd_data(sprite_lb_renderer_rd_data),
        .renderer_wr_idx(sprite_lb_renderer_wr_idx),
        .renderer_wr_data(sprite_lb_renderer_wr_data),
        .renderer_wr_en(sprite_lb_renderer_wr_en),

        // Composer interface
        .composer_rd_idx(sprite_lb_composer_rd_idx),
        .composer_rd_data(sprite_lb_composer_rd_data),
        .composer_erase_start(sprite_lb_composer_erase_start),
        .composer_erase_busy(sprite_lb_composer_erase_busy));

    //////////////////////////////////////////////////////////////////////////
    // Composite video
    //////////////////////////////////////////////////////////////////////////
    wire       video_composite_next_frame;
    wire       video_composite_next_line;
    wire       video_composite_display_next_pixel;
    wire       video_composite_vblank_pulse;

    wire [5:0] video_composite_luma, video_composite_chroma;
    wire [3:0] video_rgb_r, video_rgb_g, video_rgb_b;
    wire       video_rgb_sync_n;

    wire [5:0] video_composite_chroma2 = display_chroma_disable ? 0 : video_composite_chroma;

    video_composite video_composite(
        .rst(reset),
        .clk(clk),

        // Line buffer / palette interface
        .palette_rgb_data(palette_rgb_data[11:0]),

        .next_frame(video_composite_next_frame),
        .next_line(video_composite_next_line),
        .next_pixel(video_composite_display_next_pixel),
        .vblank_pulse(video_composite_vblank_pulse),
        .current_field(composer_display_current_field),

        // Composite interface
        .luma(video_composite_luma),
        .chroma(video_composite_chroma),
    
        // RGB interface
        .rgb_r(video_rgb_r),
        .rgb_g(video_rgb_g),
        .rgb_b(video_rgb_b),
        .rgb_sync_n(video_rgb_sync_n));

    //////////////////////////////////////////////////////////////////////////
    // VGA video
    //////////////////////////////////////////////////////////////////////////
    wire       video_vga_next_frame;
    wire       video_vga_next_line;
    wire       video_vga_display_next_pixel;
    wire       video_vga_vblank_pulse;

    wire [3:0] video_vga_r, video_vga_g, video_vga_b;
    wire       video_vga_hsync, video_vga_vsync;

    video_vga video_vga(
        .rst(reset),
        .clk(clk),

        // Palette interface
        .palette_rgb_data(palette_rgb_data[11:0]),

        .next_frame(video_vga_next_frame),
        .next_line(video_vga_next_line),
        .next_pixel(video_vga_display_next_pixel),
        .vblank_pulse(video_vga_vblank_pulse),

        // VGA interface
        .vga_r(video_vga_r),
        .vga_g(video_vga_g),
        .vga_b(video_vga_b),
        .vga_hsync(video_vga_hsync),
        .vga_vsync(video_vga_vsync));

    //////////////////////////////////////////////////////////////////////////
    // Video output selection
    //////////////////////////////////////////////////////////////////////////
    assign next_frame   = display_mode[1] ? video_composite_next_frame         : video_vga_next_frame;
    assign next_line    = display_mode[1] ? video_composite_next_line          : video_vga_next_line;
    assign next_pixel   = display_mode[1] ? video_composite_display_next_pixel : video_vga_display_next_pixel;
    assign vblank_pulse = display_mode[1] ? video_composite_vblank_pulse       : video_vga_vblank_pulse;

    always @(posedge clk) case (display_mode)
        2'b01: begin
            vga_r     <= video_vga_r;
            vga_g     <= video_vga_g;
            vga_b     <= video_vga_b;
            vga_hsync <= video_vga_hsync;
            vga_vsync <= video_vga_vsync;
        end

        2'b10: begin
            vga_r     <= video_composite_luma[5:2];
            vga_g     <= {video_composite_luma[1:0], video_composite_chroma2[5:4]};
            vga_b     <= video_composite_chroma2[3:0];
            vga_hsync <= 0;
            vga_vsync <= 0;
        end

        2'b11: begin
            vga_r     <= video_rgb_r;
            vga_g     <= video_rgb_g;
            vga_b     <= video_rgb_b;
            vga_hsync <= video_rgb_sync_n;
            vga_vsync <= 0;
        end

        default: begin
            vga_r     <= 0;
            vga_g     <= 0;
            vga_b     <= 0;
            vga_hsync <= 0;
            vga_vsync <= 0;
        end
    endcase

    //////////////////////////////////////////////////////////////////////////
    // UART
    //////////////////////////////////////////////////////////////////////////
    uart uart(
        .rst(reset),
        .clk(clk),

        .irq(uart_irq),
        
        // Slave bus interface
        .bus_addr(regbus_addr[1:0]),
        .bus_wrdata(regbus_wrdata),
        .bus_rddata(uart_rddata),
        .bus_sel(uart_sel),
        .bus_strobe(regbus_strobe),
        .bus_write(regbus_write),

        // UART interface
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));

endmodule
