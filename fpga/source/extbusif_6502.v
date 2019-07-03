`default_nettype none

module extbusif_6502(
    // 6502 slave bus interface
    input  wire        extbus_res_n,  /* Reset */
    input  wire        extbus_phy2,   /* Bus clock */
    input  wire        extbus_cs_n,   /* Chip select */
    input  wire        extbus_rw_n,   /* Read(1) / write(0) */
    input  wire  [2:0] extbus_a,      /* Address */
    inout  wire  [7:0] extbus_d,      /* Data (bi-directional) */
    output wire        extbus_rdy,    /* Ready out */
    output wire        extbus_irq_n,  /* IRQ */

    // Internal bus master interface
    input  wire        intbus_reset,
    input  wire        intbus_clk,
    output reg  [17:0] intbus_addr,
    output reg   [7:0] intbus_wrdata,
    input  wire  [7:0] intbus_rddata,
    output reg         intbus_strobe,
    output reg         intbus_write);

    // Directly exposed bus registers (internal bus clock domain)
    reg  [3:0] ib_addr_incr_r;
    reg [17:0] ib_addr_r;
    reg  [7:0] ib_rddata_r;

    reg        ib_irq_r;

    reg        ib_busy_done;

    //////////////////////////////////////////////////////////////////////////
    // External bus clock domain
    //////////////////////////////////////////////////////////////////////////

    // Asynchronous selection of read data
    reg [7:0] eb_rddata;
    always @* begin
        case (extbus_a)
            3'd0:    eb_rddata = {ib_addr_incr_r, 2'b0, ib_addr_r[17:16]};
            3'd1:    eb_rddata = ib_addr_r[15:8];
            3'd2:    eb_rddata = ib_addr_r[7:0];
            3'd3:    eb_rddata = ib_rddata_r;
            default: eb_rddata = 8'h42;
        endcase
    end

    // Handle tristating of data bus
    assign extbus_d = (!extbus_cs_n && extbus_rw_n) ? eb_rddata : 8'bZ;
    wire [7:0] eb_wrdata = extbus_d;

    // IRQ signal (open-drain output)
    assign extbus_irq_n = ib_irq_r ? 1'b0 : 1'bZ;

    // RDY signal (open-drain output)
    reg eb_busy_value;
    always @(posedge extbus_phy2 or posedge ib_busy_done) begin
        if (ib_busy_done) begin
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
    wire ib_do_read;
    pulse2pulse p2p_do_read(
        .in_clk(extbus_phy2),
        .in_pulse(!extbus_cs_n && extbus_rw_n),
        .out_clk(intbus_clk),
        .out_pulse(ib_do_read));

    wire ib_do_write;
    pulse2pulse p2p_do_write(
        .in_clk(!extbus_phy2),
        .in_pulse(!extbus_cs_n && !extbus_rw_n),
        .out_clk(intbus_clk),
        .out_pulse(ib_do_write));

    //////////////////////////////////////////////////////////////////////////
    // Internal bus clock domain
    //////////////////////////////////////////////////////////////////////////

    reg [2:0] eb_cs_r;
    always @(posedge intbus_clk) eb_cs_r <= {eb_cs_r[1:0], extbus_cs_n};
    wire end_of_cycle = eb_cs_r[1] && !eb_cs_r[2];

    reg   [3:0] ib_addr_incr_next;
    reg  [17:0] ib_addr_next;
    reg  [17:0] ib_access_addr_next;
    reg   [7:0] ib_write_data_next;
    reg   [7:0] ib_rddata_next;
    reg         ib_strobe_next, ib_write_next;

    reg         intbus_strobe_r;

    always @* begin
        ib_addr_incr_next   = ib_addr_incr_r;
        ib_addr_next        = ib_addr_r;
        ib_access_addr_next = intbus_addr;
        ib_write_data_next  = intbus_wrdata;
        ib_rddata_next      = ib_rddata_r;
        ib_strobe_next      = 0;
        ib_write_next       = 0;

        ib_busy_done        = ib_do_write;

        if (intbus_strobe_r && !intbus_write) begin
            ib_rddata_next = intbus_rddata;
            ib_busy_done = 1;
        end

        case (extbus_a_r)
            3'd0: if (ib_do_write) begin
                ib_addr_incr_next   = eb_wrdata_r[7:4];
                ib_addr_next[17:16] = eb_wrdata_r[1:0];
            end

            3'd1: if (ib_do_write) begin
                ib_addr_next[15:8]  = eb_wrdata_r;
            end

            3'd2: if (ib_do_write) begin
                ib_addr_next[7:0]   = eb_wrdata_r;
            end

            3'd3: if (ib_do_read || ib_do_write) begin
                ib_access_addr_next = ib_addr_r;
                ib_addr_next        = ib_addr_r + ib_addr_incr_r;
                ib_strobe_next      = 1;
                ib_write_data_next  = eb_wrdata_r;
                ib_write_next       = ib_do_write;
            end
        endcase
    end

    always @(posedge intbus_clk or posedge intbus_reset) begin
        if (intbus_reset) begin
            ib_addr_incr_r   <= 0;
            ib_addr_r        <= 0;

            intbus_addr      <= 0;
            intbus_wrdata    <= 0;
            ib_rddata_r      <= 0;
            intbus_strobe    <= 0;
            intbus_write     <= 0;

            ib_irq_r         <= 0;

            intbus_strobe_r  <= 0;

        end else begin
            ib_addr_incr_r   <= ib_addr_incr_next;
            ib_addr_r        <= ib_addr_next;

            intbus_addr      <= ib_access_addr_next;
            intbus_wrdata    <= ib_write_data_next;
            ib_rddata_r      <= ib_rddata_next;
            intbus_strobe    <= ib_strobe_next;
            intbus_write     <= ib_write_next;

            intbus_strobe_r  <= intbus_strobe;
        end
    end

endmodule
