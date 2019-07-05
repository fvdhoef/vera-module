`default_nettype none

module top(
    input  wire       clk25,

    // VGA interface
    output wire [3:0] vga_r       /* synthesis syn_useioff = 1 */,
    output wire [3:0] vga_g       /* synthesis syn_useioff = 1 */,
    output wire [3:0] vga_b       /* synthesis syn_useioff = 1 */,
    output wire       vga_hsync   /* synthesis syn_useioff = 1 */,
    output wire       vga_vsync   /* synthesis syn_useioff = 1 */,

    // External 6502 bus interface
    input  wire       extbus_res_n,  /* Reset */
    input  wire       extbus_phy2,   /* Bus clock */
    input  wire       extbus_cs_n,   /* Chip select */
    input  wire       extbus_rw_n,   /* Read(1) / write(0) */
    input  wire [2:0] extbus_a,      /* Address */
    inout  wire [7:0] extbus_d,      /* Data (bi-directional) */
    output wire       extbus_rdy,    /* Ready out */
    output wire       extbus_irq_n   /* IRQ */
);

    // Register bus signals
    wire [18:0] regbus_addr;
    wire  [7:0] regbus_wrdata;
    reg   [7:0] regbus_rddata;
    wire        regbus_strobe;
    wire        regbus_write;

    // Register bus read outputs
    wire  [7:0] layer1_regs_rddata;
    wire  [7:0] palette_rddata;

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

    wire [17:0] layer1_bm_addr;
    wire        layer1_bm_strobe;
    reg         layer1_bm_ack;

    // Line buffer signals
    wire [10:0] linebuf_wridx;
    wire  [7:0] linebuf_wrdata;
    wire        linebuf_wren;

    wire [10:0] linebuf_rdidx;
    wire  [7:0] linebuf_rddata;


    //////////////////////////////////////////////////////////////////////////
    // Synchronize external asynchronous reset signal to clk25 domain
    //////////////////////////////////////////////////////////////////////////
    wire reset;
    reset_sync reset_sync_clk25(
        .async_rst_in(!extbus_res_n),
        .clk(clk25),
        .reset_out(reset));

    wire clk = clk25;

    //////////////////////////////////////////////////////////////////////////
    // Register bus
    //////////////////////////////////////////////////////////////////////////

    // External 6502 bus to register bus master
    extbusif_6502 extbus(
        // 6502 slave bus interface
        .extbus_phy2(extbus_phy2),
        .extbus_cs_n(extbus_cs_n),
        .extbus_rw_n(extbus_rw_n),
        .extbus_a(extbus_a),
        .extbus_d(extbus_d),
        .extbus_rdy(extbus_rdy),
        .extbus_irq_n(extbus_irq_n),

        // Bus master interface
        .bm_reset(reset),
        .bm_clk(clk),
        .bm_addr(regbus_addr),
        .bm_wrdata(regbus_wrdata),
        .bm_rddata(regbus_rddata),
        .bm_strobe(regbus_strobe),
        .bm_write(regbus_write));

    // Register bus memory map:
    // 00000-1FFFF  Main RAM
    // 20000-20FFF  Character ROM
    // 40000-4000F  Layer 1 registers
    // 40200-403FF  Palette
    wire membus_sel      = !regbus_addr[18];
    wire layer1_regs_sel = regbus_addr[18] && regbus_addr[17:4] == 'b00_00000000_0000;
    wire palette_sel     = regbus_addr[18] && regbus_addr[17:9] == 'b00_0000001;

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
        if (membus_sel)      regbus_rddata = membus_rddata8;
        if (layer1_regs_sel) regbus_rddata = layer1_regs_rddata;
        if (palette_sel)     regbus_rddata = palette_rddata;
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

    // Read data mux
    always @* begin
        membus_rddata = 32'h00000000;
        if (mainram_sel) membus_rddata = mainram_rddata;
        if (charrom_sel) membus_rddata = charrom_rddata;
    end

    wire regbus_bm_strobe = membus_sel && regbus_strobe;

    assign membus_strobe = regbus_bm_strobe || layer1_bm_strobe;

    reg layer1_bm_ack_next;

    always @* begin
        membus_addr        = 18'b0;
        membus_write       = 1'b0;
        layer1_bm_ack_next = 1'b0;

        if (regbus_bm_strobe) begin
            membus_addr  = regbus_addr[17:0];
            membus_write = regbus_write;

        end else if (layer1_bm_strobe) begin
            membus_addr        = layer1_bm_addr[17:0];
            layer1_bm_ack_next = 1'b1;
        end
    end

    always @(posedge clk) layer1_bm_ack <= layer1_bm_ack_next;

    //////////////////////////////////////////////////////////////////////////
    // Layer 1 renderer
    //////////////////////////////////////////////////////////////////////////
    wire layer1_regs_write = layer1_regs_sel && regbus_strobe && regbus_write;

    layer_renderer layer1_renderer(
        .rst(reset),
        .clk(clk),

        // Register interface (on register bus)
        .regs_addr(regbus_addr[3:0]),
        .regs_wrdata(regbus_wrdata),
        .regs_rddata(layer1_regs_rddata),
        .regs_write(layer1_regs_write),

        // Bus master interface
        .bus_addr(layer1_bm_addr),
        .bus_data(membus_rddata),
        .bus_strobe(layer1_bm_strobe),
        .bus_ack(layer1_bm_ack),

        // Line buffer interface
        .linebuf_wridx(linebuf_wridx),
        .linebuf_wrdata(linebuf_wrdata),
        .linebuf_wren(linebuf_wren));
    
    //////////////////////////////////////////////////////////////////////////
    // Palette (2 instances to allow for readback of palette entries)
    //////////////////////////////////////////////////////////////////////////
    wire        palette_write = palette_sel && regbus_strobe && regbus_write;
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
        .rd_addr_i(linebuf_rddata),
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
    // Display line buffer
    //////////////////////////////////////////////////////////////////////////
    dpram #(.ADDR_WIDTH(11), .DATA_WIDTH(8)) display_linebuf(
        .wr_clk(clk),
        .wr_addr(linebuf_wridx),
        .wr_en(linebuf_wren),
        .wr_data(linebuf_wrdata),

        .rd_clk(clk),
        .rd_addr(linebuf_rdidx),
        .rd_data(linebuf_rddata));

    //////////////////////////////////////////////////////////////////////////
    // VGA video
    //////////////////////////////////////////////////////////////////////////
    video_vga video_vga(
        .rst(reset),
        .clk(clk),

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
