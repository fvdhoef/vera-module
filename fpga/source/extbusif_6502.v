`default_nettype none

module extbusif_6502(
    input  wire        rst,
    input  wire        clk,

    // 6502 slave bus interface
    input  wire        extbus_phi2,   /* Bus clock */
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


    //////////////////////////////////////////////////////////////////////////
    // External bus clock domain
    //////////////////////////////////////////////////////////////////////////

    // Asynchronous selection of read data
    reg [7:0] eb_rddata;
    always @* case (extbus_a)
        3'd0:    eb_rddata = reg_addrsel_r ? {reg_addr1_incr_r, reg_addr1_r[19:16]} : {reg_addr0_incr_r, reg_addr0_r[19:16]};
        3'd1:    eb_rddata = reg_addrsel_r ? reg_addr1_r[15:8] : reg_addr0_r[15:8];
        3'd2:    eb_rddata = reg_addrsel_r ? reg_addr1_r[7:0]  : reg_addr0_r[7:0];
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

    // Gate PHI2 by chipselect
    wire ext_access = extbus_phi2 && !extbus_cs_n;

    //////////////////////////////////////////////////////////////////////////
    // Internal bus clock domain
    //////////////////////////////////////////////////////////////////////////

    // Synchronize chipselect
    reg [2:0] chipselect_r;
    always @(posedge clk) chipselect_r <= {chipselect_r[1:0], !extbus_cs_n};

    // Synchronize access signal
    reg [2:0] ext_access_r;
    always @(posedge clk) ext_access_r <= {ext_access_r[1:0], ext_access};

    // Simulate latching of address, write data and read/write lines.
    reg [2:0] eb_addr_r, eb_addr_rr, eb_addr_rrr;
    reg [7:0] eb_wrdata_r, eb_wrdata_rr, eb_wrdata_rrr;
    reg       eb_rw_r, eb_rw_rr, eb_rw_rrr;

    always @(posedge clk) begin
        if (ext_access_r[1]) begin
            eb_addr_r    <= extbus_a;
            eb_wrdata_r  <= eb_wrdata;
            eb_rw_r      <= extbus_rw_n;

            eb_addr_rr   <= eb_addr_r;
            eb_wrdata_rr <= eb_wrdata_r;
            eb_rw_rr     <= eb_rw_r;

            eb_addr_rrr   <= eb_addr_rr;
            eb_wrdata_rrr <= eb_wrdata_rr;
            eb_rw_rrr     <= eb_rw_rr;
        end
    end

    wire do_read  = (ext_access_r[2:1] == 2'b01 &&  extbus_rw_n);
    wire do_write = (ext_access_r[2:1] == 2'b10);    // && !extbus_rw_n);

    wire chip_selected    = (chipselect_r[2:1] == 2'b01);
    wire chip_deselected  = (chipselect_r[2:1] == 2'b10);

    reg  [19:0] ib_addr_r,   ib_addr_next;
    reg   [7:0] ib_wrdata_r, ib_wrdata_next;
    reg   [7:0] ib_rddata_r, ib_rddata_next;
    reg         ib_strobe_r, ib_strobe_next;
    reg         ib_write_r,  ib_write_next;
    reg         ib_do_access;
    reg         ib_strobe_rr;

    assign bm_addr   = ib_addr_r;
    assign bm_wrdata = ib_wrdata_r;
    assign bm_strobe = ib_strobe_r;
    assign bm_write  = ib_write_r;

    wire read_done = ib_strobe_rr && !bm_write;

    assign rddata = read_done ? bm_rddata : ib_rddata_r;

    reg access_port;

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

        // Write (use signals from a few cycles earlier)
        if (do_write && !eb_rw_rrr) begin
            case (eb_addr_rrr)
                3'd0: begin
                    if (reg_addrsel_r) begin
                        reg_addr1_incr_next   = eb_wrdata_rrr[7:4];
                        reg_addr1_next[19:16] = eb_wrdata_rrr[3:0];
                    end else begin
                        reg_addr0_incr_next   = eb_wrdata_rrr[7:4];
                        reg_addr0_next[19:16] = eb_wrdata_rrr[3:0];
                    end
                end

                3'd1: begin
                    if (reg_addrsel_r) begin
                        reg_addr1_next[15:8] = eb_wrdata_rrr;
                    end else begin
                        reg_addr0_next[15:8] = eb_wrdata_rrr;
                    end
                end

                3'd2: begin
                    if (reg_addrsel_r) begin
                        reg_addr1_next[7:0] = eb_wrdata_rrr;
                    end else begin
                        reg_addr0_next[7:0] = eb_wrdata_rrr;
                    end
                end

                3'd3, 3'd4: begin
                    ib_do_access   = 1;
                    ib_wrdata_next = eb_wrdata_rrr;
                    ib_write_next  = 1;
                    access_port    = (eb_addr_rrr == 3'd4);
                end

                3'd5: begin
                    do_warmboot_next = eb_wrdata_rrr[7];
                    reg_addrsel_next = eb_wrdata_rrr[0];
                end

                3'd6: begin
                    reg_ien_next = eb_wrdata_rrr;
                end

                3'd7: begin
                    reg_isr_next = reg_isr_r & ~eb_wrdata_rrr;
                end
            endcase
        end

        // Handle interrupts
        reg_isr_next = reg_isr_next | irqs;

        if (ib_do_access) begin
            if (!access_port) begin
                ib_addr_next   = reg_addr0_r;
                reg_addr0_next = reg_addr0_r + reg_addr0_incr_r;

            end else begin
                ib_addr_next   = reg_addr1_r;
                reg_addr1_next = reg_addr1_r + reg_addr1_incr_r;

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

            ib_strobe_rr     <= 0;

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

            ib_strobe_rr     <= ib_strobe_r;

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
