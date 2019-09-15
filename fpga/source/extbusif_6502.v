`default_nettype none

module extbusif_6502(
    input  wire        rst,
    input  wire        clk,

    // 6502 slave bus interface
    output wire        extbus_phi2_n, /* Bus clock */
    input  wire        extbus_cs_n,   /* Chip select */
    input  wire        extbus_rw_n,   /* Read(1) / write(0) */
    input  wire  [2:0] extbus_a,      /* Address */
    inout  wire  [7:0] extbus_d,      /* Data (bi-directional) */
    output wire        extbus_irq_n,  /* IRQ */

    // Bus master interface
    output wire [19:0] bm_addr,
    output wire  [7:0] bm_wrdata,
    input  wire  [7:0] bm_rddata,
    output wire        bm_strobe,
    output wire        bm_write,
    
    input  wire  [7:0] irqs);

    // Directly exposed bus registers (bus master clock domain)
    reg  [3:0] reg_addr0_incr_r, reg_addr0_incr_next;
    reg [19:0] reg_addr0_r,      reg_addr0_next;
    reg  [3:0] reg_addr1_incr_r, reg_addr1_incr_next;
    reg [19:0] reg_addr1_r,      reg_addr1_next;
    reg        reg_addrsel_r,    reg_addrsel_next;
    reg  [7:0] reg_ien_r,        reg_ien_next;
    reg  [7:0] reg_isr_r,        reg_isr_next;
    reg        do_warmboot_r,    do_warmboot_next;

    wire [7:0] rddata;

    wire       irq = ((reg_isr_r & reg_ien_r) != 0);

    wire stretch_phi2;

    // Generate clock
    reg [1:0] clkdiv_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clkdiv_r <= 0;
        end else begin
            clkdiv_r <= (clkdiv_r == 'd2 && !stretch_phi2) ? 0 : (clkdiv_r + 1);
        end
    end

    wire extbus_phi2 = clkdiv_r != 0;
    assign extbus_phi2_n = !extbus_phi2;

    reg [1:0] phi2_r;
    always @(posedge clk) begin
        phi2_r <= {phi2_r[0], extbus_phi2};
    end

    //////////////////////////////////////////////////////////////////////////
    // External bus clock domain
    //////////////////////////////////////////////////////////////////////////

    // Asynchronous selection of read data
    reg [7:0] eb_rddata;
    always @* case (extbus_a)
        3'd0:    eb_rddata = reg_addrsel_r ? reg_addr1_r[7:0]  : reg_addr0_r[7:0];
        3'd1:    eb_rddata = reg_addrsel_r ? reg_addr1_r[15:8] : reg_addr0_r[15:8];
        3'd2:    eb_rddata = reg_addrsel_r ? {reg_addr1_incr_r, reg_addr1_r[19:16]} : {reg_addr0_incr_r, reg_addr0_r[19:16]};
        3'd3:    eb_rddata = rddata;
        3'd4:    eb_rddata = rddata;
        3'd5:    eb_rddata = {do_warmboot_r, 6'b0, reg_addrsel_r};
        3'd6:    eb_rddata = reg_ien_r;
        3'd7:    eb_rddata = reg_isr_r;
        default: eb_rddata = 8'h00;
    endcase

    // Handle tristating of data bus
    assign extbus_d = (!extbus_cs_n && extbus_rw_n) ? eb_rddata : 8'bZ;
    wire [7:0] eb_wrdata = extbus_d;

    // IRQ signal (open-drain output)
    assign extbus_irq_n = irq ? 1'b0 : 1'bZ;

    //////////////////////////////////////////////////////////////////////////
    // Internal bus clock domain
    //////////////////////////////////////////////////////////////////////////

    assign stretch_phi2 = !extbus_cs_n && extbus_rw_n;

    wire do_read  = (phi2_r == 'b10 && !extbus_cs_n &&  extbus_rw_n);
    wire do_write = (phi2_r == 'b01 && !extbus_cs_n && !extbus_rw_n);

    reg  [19:0] ib_addr_r,   ib_addr_next;
    reg   [7:0] ib_wrdata_r, ib_wrdata_next;
    reg   [7:0] ib_rddata_r, ib_rddata_next;
    reg         ib_strobe_r, ib_strobe_next;
    reg         ib_write_r,  ib_write_next;
    reg         ib_do_access;

    assign bm_addr   = ib_addr_next;
    assign bm_wrdata = ib_wrdata_next;
    assign bm_strobe = ib_strobe_next;
    assign bm_write  = ib_write_next;

    wire read_done = ib_strobe_r && !ib_write_r;

    assign rddata = read_done ? bm_rddata : ib_rddata_r;

    reg access_port;

    // Decode increment value
    wire [3:0] incr_regval = !access_port ? reg_addr0_incr_r : reg_addr1_incr_r;
    reg [15:0] increment;
    always @* case (incr_regval)
        4'h0: increment = 'd0;
        4'h1: increment = 'd1;
        4'h2: increment = 'd2;
        4'h3: increment = 'd4;
        4'h4: increment = 'd8;
        4'h5: increment = 'd16;
        4'h6: increment = 'd32;
        4'h7: increment = 'd64;
        4'h8: increment = 'd128;
        4'h9: increment = 'd256;
        4'hA: increment = 'd512;
        4'hB: increment = 'd1024;
        4'hC: increment = 'd2048;
        4'hD: increment = 'd4096;
        4'hE: increment = 'd8192;
        4'hF: increment = 'd16384;
    endcase

    always @* begin
        reg_addr0_incr_next = reg_addr0_incr_r;
        reg_addr0_next      = reg_addr0_r;
        reg_addr1_incr_next = reg_addr1_incr_r;
        reg_addr1_next      = reg_addr1_r;
        reg_addrsel_next    = reg_addrsel_r;
        reg_ien_next        = reg_ien_r;
        reg_isr_next        = reg_isr_r;

        ib_addr_next        = ib_addr_r;
        ib_wrdata_next      = ib_wrdata_r;
        ib_rddata_next      = ib_rddata_r;
        ib_strobe_next      = 0;
        ib_write_next       = 0;
        ib_do_access        = 0;
        access_port         = 0;

        do_warmboot_next    = do_warmboot_r;

        if (read_done) begin
            ib_rddata_next = bm_rddata;
        end

        // Start the read access as early as possible to be able to get the
        // result in the same 6502 bus cycle (depending on the 6502 bus clock
        // speed).
        if (do_read && (extbus_a == 3'd3 || extbus_a == 3'd4)) begin
            ib_do_access = 1;
            access_port = (extbus_a == 3'd4);
        end

        // Write
        if (do_write) begin
            case (extbus_a)
                3'd0: begin
                    if (!reg_addrsel_r) begin
                        reg_addr0_next[7:0] = eb_wrdata;
                    end else begin
                        reg_addr1_next[7:0] = eb_wrdata;
                    end
                end

                3'd1: begin
                    if (!reg_addrsel_r) begin
                        reg_addr0_next[15:8] = eb_wrdata;
                    end else begin
                        reg_addr1_next[15:8] = eb_wrdata;
                    end
                end

                3'd2: begin
                    if (!reg_addrsel_r) begin
                        reg_addr0_incr_next   = eb_wrdata[7:4];
                        reg_addr0_next[19:16] = eb_wrdata[3:0];
                    end else begin
                        reg_addr1_incr_next   = eb_wrdata[7:4];
                        reg_addr1_next[19:16] = eb_wrdata[3:0];
                    end
                end

                3'd3, 3'd4: begin
                    ib_do_access   = 1;
                    ib_wrdata_next = eb_wrdata;
                    ib_write_next  = 1;
                    access_port    = (extbus_a == 3'd4);
                end

                3'd5: begin
                    do_warmboot_next = eb_wrdata[7];
                    reg_addrsel_next = eb_wrdata[0];
                end

                3'd6: begin
                    reg_ien_next = eb_wrdata;
                end

                3'd7: begin
                    reg_isr_next = reg_isr_r & ~eb_wrdata;
                end
            endcase
        end

        // Handle interrupts
        reg_isr_next = reg_isr_next | irqs;

        if (ib_do_access) begin
            if (!access_port) begin
                ib_addr_next   = reg_addr0_r;
                reg_addr0_next = reg_addr0_r + increment;

            end else begin
                ib_addr_next   = reg_addr1_r;
                reg_addr1_next = reg_addr1_r + increment;
            end
            ib_strobe_next = 1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_addr0_incr_r <= 0;
            reg_addr0_r      <= 0;
            reg_addr1_incr_r <= 0;
            reg_addr1_r      <= 0;
            reg_addrsel_r    <= 0;
            reg_ien_r        <= 0;
            reg_isr_r        <= 0;

            ib_addr_r        <= 0;
            ib_wrdata_r      <= 0;
            ib_rddata_r      <= 0;
            ib_strobe_r      <= 0;
            ib_write_r       <= 0;

            do_warmboot_r    <= 0;

        end else begin
            reg_addr0_incr_r <= reg_addr0_incr_next;
            reg_addr0_r      <= reg_addr0_next;
            reg_addr1_incr_r <= reg_addr1_incr_next;
            reg_addr1_r      <= reg_addr1_next;
            reg_addrsel_r    <= reg_addrsel_next;
            reg_ien_r        <= reg_ien_next;
            reg_isr_r        <= reg_isr_next;

            ib_addr_r        <= ib_addr_next;
            ib_wrdata_r      <= ib_wrdata_next;
            ib_rddata_r      <= ib_rddata_next;
            ib_strobe_r      <= ib_strobe_next;
            ib_write_r       <= ib_write_next;

            do_warmboot_r    <= do_warmboot_next;
        end
    end

`ifndef __ICARUS__
    WARMBOOT warmboot(
        .S1(1'b0),
        .S0(1'b0),
        .BOOT(do_warmboot_r));
`endif

endmodule
