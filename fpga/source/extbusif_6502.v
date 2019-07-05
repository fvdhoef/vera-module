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

    reg        bm_busy_done;

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
    reg eb_busy_value;
    always @(posedge extbus_phy2 or posedge bm_busy_done) begin
        if (bm_busy_done) begin
            eb_busy_value <= 0;
        end else begin
            eb_busy_value <= extbus_rw_n;
        end
    end

    assign extbus_rdy = (!extbus_cs_n && eb_busy_value) ? 1'b0 : 1'bZ;

    // On positive edge of PHY2, 6502 updates address lines (and thus chipselect) and R/W# line:
    reg [2:0] extbus_a_r;
    always @(posedge extbus_phy2) begin
        if (!extbus_cs_n) begin
            extbus_a_r <= extbus_a;
        end
    end

    // On negative edge of PHY2, write data from CPU is valid
    reg [7:0] eb_wrdata_r;
    always @(negedge extbus_phy2) begin
        if (!extbus_cs_n && !extbus_rw_n) begin
            eb_wrdata_r <= eb_wrdata;
        end
    end

    // Generate read and write pulses to internal bus
    wire bm_do_read;
    pulse2pulse p2p_do_read(
        .in_clk(extbus_phy2),
        .in_pulse(!extbus_cs_n && extbus_rw_n),
        .out_clk(bm_clk),
        .out_pulse(bm_do_read));

    wire bm_do_write;
    pulse2pulse p2p_do_write(
        .in_clk(!extbus_phy2),
        .in_pulse(!extbus_cs_n && !extbus_rw_n),
        .out_clk(bm_clk),
        .out_pulse(bm_do_write));

    //////////////////////////////////////////////////////////////////////////
    // Internal bus clock domain
    //////////////////////////////////////////////////////////////////////////

    reg   [3:0] bm_addr_incr_next;
    reg  [18:0] bm_addr_next;
    reg  [18:0] bm_access_addr_next;
    reg   [7:0] bm_write_data_next;
    reg   [7:0] bm_rddata_next;
    reg         bm_strobe_next, bm_write_next;

    reg         bm_strobe_r;

    always @* begin
        bm_addr_incr_next   = bm_addr_incr_r;
        bm_addr_next        = bm_addr_r;
        bm_access_addr_next = bm_addr;
        bm_write_data_next  = bm_wrdata;
        bm_rddata_next      = bm_rddata_r;
        bm_strobe_next      = 0;
        bm_write_next       = 0;

        bm_busy_done        = bm_do_write;

        if (bm_strobe_r && !bm_write) begin
            bm_rddata_next = bm_rddata;
            bm_busy_done = 1;
        end

        case (extbus_a_r)
            3'd0: if (bm_do_write) begin
                bm_addr_incr_next   = eb_wrdata_r[7:4];
                bm_addr_next[18:16] = eb_wrdata_r[2:0];
            end

            3'd1: if (bm_do_write) begin
                bm_addr_next[15:8]  = eb_wrdata_r;
            end

            3'd2: if (bm_do_write) begin
                bm_addr_next[7:0]   = eb_wrdata_r;
            end

            3'd3: if (bm_do_read || bm_do_write) begin
                bm_access_addr_next = bm_addr_r;
                bm_addr_next        = bm_addr_r + bm_addr_incr_r;
                bm_strobe_next      = 1;
                bm_write_data_next  = eb_wrdata_r;
                bm_write_next       = bm_do_write;
            end
        endcase
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
        end
    end

endmodule
