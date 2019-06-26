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
    input  wire       bus_res_n,  /* Reset */
    input  wire       bus_phy2,   /* Bus clock */
    input  wire       bus_cs_n,   /* Chip select */
    input  wire       bus_rw_n,   /* Read(1) / write(0) */
    input  wire [2:0] bus_a,      /* Address */
    inout  wire [7:0] bus_d,      /* Data (bi-directional) */
    output wire       bus_rdy,    /* Ready out */
    output wire       bus_irq_n   /* IRQ */
);

    // Synchronize external asynchronous reset signal to phy2 domain
    wire bus_reset;
    reset_sync reset_sync_phy2(
        .async_rst_in(!bus_res_n),
        .clk(bus_phy2),
        .reset_out(bus_reset));

    // Synchronize external asynchronous reset signal to clk25 domain
    wire clk25_reset;
    reset_sync reset_sync_clk25(
        .async_rst_in(!bus_res_n),
        .clk(clk25),
        .reset_out(clk25_reset));


    reg [7:0] reg_addr_h, reg_addr_l;

    reg  [7:0] bus_d_out;
    wire [7:0] bus_d_in;

    assign bus_d    = (!bus_cs_n && bus_rw_n) ? bus_d_out : 8'bZ;
    assign bus_d_in = bus_d;

    assign bus_irq_n = 1'bZ;
    assign bus_rdy   = 1'bZ;

    reg [7:0] data_in;
    reg [2:0] bus_addr;
    reg bus_read, bus_write;

    always @(negedge bus_phy2) data_in <= bus_d_in;
    always @(posedge bus_phy2) bus_addr <= bus_a;
    always @(posedge bus_phy2) bus_read <= !bus_cs_n && bus_rw_n;
    always @(posedge bus_phy2) bus_write <= !bus_cs_n && !bus_rw_n;

    always @* case (bus_a)
        3'b000:  bus_d_out <= reg_addr_l;
        3'b001:  bus_d_out <= reg_addr_h;
        default: bus_d_out <= 8'h42;
    endcase

    always @(posedge bus_phy2 or posedge bus_reset) begin
        if (bus_reset) begin
            reg_addr_l <= 8'h13;
            reg_addr_h <= 8'h42;

        end else begin
            if (bus_write) begin
                case (bus_addr)
                    3'b000: reg_addr_l <= data_in;
                    3'b001: reg_addr_h <= data_in;
                endcase
            end
        end
    end


    // VGA video
    video_vga video_vga(
        .rst(clk25_reset),
        .clk(clk25),

        // VGA interface
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync));


endmodule
