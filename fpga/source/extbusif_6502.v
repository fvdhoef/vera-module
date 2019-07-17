`default_nettype none

module extbusif_6502(
    // 6502 slave bus interface
    input  wire        extbus_phy2,   /* Bus clock */
    input  wire        extbus_cs_n,   /* Chip select */
    input  wire        extbus_rw_n,   /* Read(1) / write(0) */
    input  wire  [2:0] extbus_a,      /* Address */
    inout  wire  [7:0] extbus_d,      /* Data (bi-directional) */
    output wire        extbus_rdy,    /* Ready out */
    output wire        extbus_irq_n,  /* IRQ */

    // Bus master interface
    input  wire        bm_reset,
    input  wire        bm_clk,
    output reg  [18:0] bm_addr,
    output reg   [7:0] bm_wrdata,
    input  wire  [7:0] bm_rddata,
    output reg         bm_strobe,
    output reg         bm_write);

    // Directly exposed bus registers (bus master clock domain)
    reg  [3:0] bm_addr_incr_r;
    reg [18:0] bm_addr_r;
    reg  [7:0] bm_rddata_r;

    reg        bm_irq_r;
    reg        bm_busy_r;

    //////////////////////////////////////////////////////////////////////////
    // External bus clock domain
    //////////////////////////////////////////////////////////////////////////

    // Asynchronous selection of read data
    reg [7:0] eb_rddata;
    always @* case (extbus_a)
        3'd0:    eb_rddata = {bm_addr_incr_r, 1'b0, bm_addr_r[18:16]};
        3'd1:    eb_rddata = bm_addr_r[15:8];
        3'd2:    eb_rddata = bm_addr_r[7:0];
        3'd3:    eb_rddata = bm_rddata_r;
        default: eb_rddata = 8'h00;
    endcase

    // Handle tristating of data bus
    assign extbus_d = (!extbus_cs_n && extbus_rw_n) ? eb_rddata : 8'bZ;
    wire [7:0] eb_wrdata = extbus_d;

    // IRQ signal (open-drain output)
    assign extbus_irq_n = bm_irq_r ? 1'b0 : 1'bZ;

    // RDY signal (open-drain output)
    assign extbus_rdy = (!extbus_cs_n && bm_busy_r) ? 1'b0 : 1'bZ;

    // Gate PHY2 by chipselect
    wire ext_access = extbus_phy2 && !extbus_cs_n;

    //////////////////////////////////////////////////////////////////////////
    // Internal bus clock domain
    //////////////////////////////////////////////////////////////////////////

    // Synchronize chipselect
    reg [2:0] chipselect_r;
    always @(posedge bm_clk) chipselect_r <= {chipselect_r[1:0], !extbus_cs_n};

    // Synchronize access signal
    reg [2:0] ext_access_r;
    always @(posedge bm_clk) ext_access_r <= {ext_access_r[1:0], ext_access};

    // Simulate latching of address, write data and read/write lines.
    reg [2:0] eb_addr_r, eb_addr_rr, eb_addr_rrr;
    reg [7:0] eb_wrdata_r, eb_wrdata_rr, eb_wrdata_rrr;
    reg       eb_rw_r, eb_rw_rr, eb_rw_rrr;

    always @(posedge bm_clk) begin
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

    wire ext_access_start = (ext_access_r[2:1] == 2'b01);
    wire ext_access_end   = (ext_access_r[2:1] == 2'b10);

    wire chip_selected    = (chipselect_r[2:1] == 2'b01);
    wire chip_deselected  = (chipselect_r[2:1] == 2'b10);

    reg   [3:0] bm_addr_incr_next;
    reg  [18:0] bm_addr_next;
    reg  [18:0] bm_access_addr_next;
    reg   [7:0] bm_write_data_next;
    reg   [7:0] bm_rddata_next;
    reg         bm_busy_next;
    reg         bm_strobe_next, bm_write_next;
    reg         bm_do_access;
    reg         bm_strobe_r;

    always @* begin
        bm_addr_incr_next   = bm_addr_incr_r;
        bm_addr_next        = bm_addr_r;
        bm_access_addr_next = bm_addr;
        bm_write_data_next  = bm_wrdata;
        bm_rddata_next      = bm_rddata_r;
        bm_busy_next        = bm_busy_r;
        bm_strobe_next      = 0;
        bm_write_next       = 0;
        bm_do_access        = 0;

        if (bm_strobe_r && !bm_write) begin
            bm_rddata_next = bm_rddata;
            bm_busy_next = 0;
        end

        // Always re-assert busy signal at end of cycle
        if (chip_deselected) begin
            bm_busy_next      = 1;
        end

        // Start the read access as early as possible to be able to get the
        // result in the same 6502 bus cycle (depending on the 6502 bus clock
        // speed).
        if (ext_access_start) begin
            if (extbus_rw_n && extbus_a == 3'd3) begin
                bm_do_access = 1;
            end else begin
                bm_busy_next = 0;
            end
        end

        // Write (use signals from a few cycles earlier)
        if (ext_access_end && !eb_rw_rrr) begin
            case (eb_addr_rrr)
                3'd0: begin
                    bm_addr_incr_next   = eb_wrdata_rrr[7:4];
                    bm_addr_next[18:16] = eb_wrdata_rrr[2:0];
                end

                3'd1: begin
                    bm_addr_next[15:8]  = eb_wrdata_rrr;
                end

                3'd2: begin
                    bm_addr_next[7:0]   = eb_wrdata_rrr;
                end

                3'd3: begin
                    bm_do_access        = 1;
                    bm_write_data_next  = eb_wrdata_rrr;
                    bm_write_next       = 1;
                end
            endcase
        end

        if (bm_do_access) begin
            bm_access_addr_next = bm_addr_r;
            bm_addr_next        = bm_addr_r + bm_addr_incr_r;
            bm_strobe_next      = 1;
        end
    end

    always @(posedge bm_clk or posedge bm_reset) begin
        if (bm_reset) begin
            bm_addr_incr_r <= 0;
            bm_addr_r      <= 0;

            bm_addr        <= 0;
            bm_wrdata      <= 0;
            bm_rddata_r    <= 0;
            bm_strobe      <= 0;
            bm_write       <= 0;

            bm_irq_r       <= 0;
            bm_busy_r      <= 0;

            bm_strobe_r    <= 0;

        end else begin
            bm_addr_incr_r <= bm_addr_incr_next;
            bm_addr_r      <= bm_addr_next;

            bm_addr        <= bm_access_addr_next;
            bm_wrdata      <= bm_write_data_next;
            bm_rddata_r    <= bm_rddata_next;
            bm_strobe      <= bm_strobe_next;
            bm_write       <= bm_write_next;

            bm_strobe_r    <= bm_strobe;

            bm_irq_r       <= 1'b0;
            bm_busy_r      <= bm_busy_next;
        end
    end

endmodule
