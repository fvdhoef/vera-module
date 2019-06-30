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
    wire mainram_sel = (intbus_addr[17] == 0);
    wire charrom_sel = (intbus_addr[17] == 1);

    //
    // Main RAM (128kB) 00000-1FFFF
    //
    wire [31:0] mainram_wrdata = {4{intbus_wrdata}};
    reg   [3:0] mainram_wrbytesel;
    wire [31:0] mainram_rddata;
    wire        mainram_write = mainram_sel && intbus_strobe && intbus_write;

    always @* case (intbus_addr[1:0])
        2'b00: mainram_wrbytesel = 4'b0001;
        2'b01: mainram_wrbytesel = 4'b0010;
        2'b10: mainram_wrbytesel = 4'b0100;
        2'b11: mainram_wrbytesel = 4'b1000;
    endcase

    main_ram main_ram(
        .clk(intbus_clk),
        .bus_addr(intbus_addr[16:2]),
        .bus_wrdata(mainram_wrdata),
        .bus_wrbytesel(mainram_wrbytesel),
        .bus_rddata(mainram_rddata),
        .bus_write(mainram_write));

    //
    // Charactor ROM (4kB) 20000-20FFF
    //
    wire [7:0] charrom_rddata;
    char_rom char_rom(
        .clk(intbus_clk),
        .rd_addr(intbus_addr[11:0]),
        .rd_data(charrom_rddata));


    reg [7:0] mainram_rddata8;
    always @* case (intbus_addr[1:0])
        2'b00: mainram_rddata8 = mainram_rddata[7:0];
        2'b01: mainram_rddata8 = mainram_rddata[15:8];
        2'b10: mainram_rddata8 = mainram_rddata[23:16];
        2'b11: mainram_rddata8 = mainram_rddata[31:24];
    endcase

    
    reg [7:0] intbus_rddata;
    always @* begin
        intbus_rddata = 8'h00;
        if (mainram_sel) intbus_rddata = mainram_rddata8;
        if (charrom_sel) intbus_rddata = charrom_rddata;
    end

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
        .intbus_rddata(intbus_rddata),
        .intbus_strobe(intbus_strobe),
        .intbus_write(intbus_write));

    // VGA video
    video_vga video_vga(
        .rst(intbus_reset),
        .clk(intbus_clk),

        // VGA interface
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync));

endmodule
