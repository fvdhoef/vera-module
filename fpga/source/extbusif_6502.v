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
    output reg  [18:0] bm_addr,
    output reg   [7:0] bm_wrdata,
    input  wire  [7:0] bm_rddata,
    output reg         bm_strobe,
    output reg         bm_write,
    
    input  wire  [7:0] irqs);

    // Directly exposed bus registers (bus master clock domain)
    reg  [3:0] reg_addr0_incr_r, reg_addr0_incr_next;
    reg [18:0] reg_addr0_r,      reg_addr0_next;
    reg  [3:0] reg_addr1_incr_r, reg_addr1_incr_next;
    reg [18:0] reg_addr1_r,      reg_addr1_next;
    reg        reg_addrsel_r,    reg_addrsel_next;
    reg  [7:0] reg_ien_r,        reg_ien_next;
    reg  [7:0] reg_isr_r,        reg_isr_next;
    reg        do_warmboot_r,    do_warmboot_next;

    wire [7:0] rddata;

    wire       irq = ((reg_isr_r & reg_ien_r) != 0);

    // Generate clock
    reg [2:0] clkdiv_r;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clkdiv_r <= 0;
        end else begin
            clkdiv_r <= clkdiv_r + 1;
        end
    end

    wire extbus_phi2 = clkdiv_r[1];
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
        3'd0:    eb_rddata = reg_addrsel_r ? {reg_addr1_incr_r, 1'b0, reg_addr1_r[18:16]} : {reg_addr0_incr_r, 1'b0, reg_addr0_r[18:16]};
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

    // Synchronize access signal
    reg ext_access_r;
    always @(posedge clk) ext_access_r <= ext_access;

    // Simulate latching of address, write data and read/write lines.
    reg [2:0] eb_addr_r;
    reg [7:0] eb_wrdata_r;
    reg       eb_rw_r;

    always @(posedge clk) begin
        if (ext_access) begin
            eb_addr_r    <= extbus_a;
            eb_wrdata_r  <= eb_wrdata;
            eb_rw_r      <= extbus_rw_n;
        end
    end

    wire do_read        = (phi2_r == 'b10 && !extbus_cs_n && extbus_rw_n);
    wire ext_access_end = ({ext_access_r, ext_access} == 2'b10);

    reg  [18:0] bm_access_addr_next;
    reg   [7:0] bm_write_data_next;
    reg   [7:0] bm_rddata_r, bm_rddata_next;
    reg         bm_strobe_next, bm_write_next;
    reg         bm_do_access;
    reg         bm_strobe_r;

    assign rddata = (bm_strobe_r && !bm_write) ? bm_rddata : bm_rddata_r;

    reg         access_port;

    always @* begin
        reg_addr0_incr_next = reg_addr0_incr_r;
        reg_addr0_next      = reg_addr0_r;
        reg_addr1_incr_next = reg_addr1_incr_r;
        reg_addr1_next      = reg_addr1_r;
        reg_addrsel_next    = reg_addrsel_r;
        reg_ien_next        = reg_ien_r;
        reg_isr_next        = reg_isr_r;

        bm_access_addr_next = bm_addr;
        bm_write_data_next  = bm_wrdata;
        bm_rddata_next      = bm_rddata_r;
        bm_strobe_next      = 0;
        bm_write_next       = 0;
        bm_do_access        = 0;
        access_port         = 0;

        do_warmboot_next    = do_warmboot_r;

        if (bm_strobe_r && !bm_write) begin
            bm_rddata_next = bm_rddata;
        end

        // Start the read access as early as possible to be able to get the
        // result in the same 6502 bus cycle (depending on the 6502 bus clock
        // speed).
        if (do_read && (extbus_a == 3'd3 || extbus_a == 3'd4)) begin
            bm_do_access = 1;
            access_port = (extbus_a == 3'd4);
        end

        // Write (use signals from a few cycles earlier)
        if (ext_access_end && !eb_rw_r) begin
            case (eb_addr_r)
                3'd0: begin
                    if (reg_addrsel_r) begin
                        reg_addr1_incr_next   = eb_wrdata_r[7:4];
                        reg_addr1_next[18:16] = eb_wrdata_r[2:0];
                    end else begin
                        reg_addr0_incr_next   = eb_wrdata_r[7:4];
                        reg_addr0_next[18:16] = eb_wrdata_r[2:0];
                    end
                end

                3'd1: begin
                    if (reg_addrsel_r) begin
                        reg_addr1_next[15:8]  = eb_wrdata_r;
                    end else begin
                        reg_addr0_next[15:8]  = eb_wrdata_r;
                    end
                end

                3'd2: begin
                    if (reg_addrsel_r) begin
                        reg_addr1_next[7:0]   = eb_wrdata_r;
                    end else begin
                        reg_addr0_next[7:0]   = eb_wrdata_r;
                    end
                end

                3'd3, 3'd4: begin
                    bm_do_access        = 1;
                    bm_write_data_next  = eb_wrdata_r;
                    bm_write_next       = 1;
                    access_port         = (eb_addr_r == 3'd4);
                end

                3'd5: begin
                    do_warmboot_next    = eb_wrdata_r[7];
                    reg_addrsel_next    = eb_wrdata_r[0];
                end

                3'd6: begin
                    reg_ien_next        = eb_wrdata_r;
                end

                3'd7: begin
                    reg_isr_next        = reg_isr_r & ~eb_wrdata_r;
                end
            endcase
        end

        // Handle interrupts
        reg_isr_next = reg_isr_next | irqs;

        if (bm_do_access) begin
            if (!access_port) begin
                bm_access_addr_next = reg_addr0_r;
                reg_addr0_next      = reg_addr0_r + reg_addr0_incr_r;

            end else begin
                bm_access_addr_next = reg_addr1_r;
                reg_addr1_next      = reg_addr1_r + reg_addr1_incr_r;

            end
            bm_strobe_next = 1;
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

            bm_addr          <= 0;
            bm_wrdata        <= 0;
            bm_rddata_r      <= 0;
            bm_strobe        <= 0;
            bm_write         <= 0;

            bm_strobe_r      <= 0;

            do_warmboot_r    <= 0;

        end else begin
            reg_addr0_incr_r <= reg_addr0_incr_next;
            reg_addr0_r      <= reg_addr0_next;
            reg_addr1_incr_r <= reg_addr1_incr_next;
            reg_addr1_r      <= reg_addr1_next;
            reg_addrsel_r    <= reg_addrsel_next;
            reg_ien_r        <= reg_ien_next;
            reg_isr_r        <= reg_isr_next;

            bm_addr          <= bm_access_addr_next;
            bm_wrdata        <= bm_write_data_next;
            bm_rddata_r      <= bm_rddata_next;
            bm_strobe        <= bm_strobe_next;
            bm_write         <= bm_write_next;

            bm_strobe_r      <= bm_strobe;

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
