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

    // Synchronize external asynchronous reset signal to PHY2 domain
    wire extbus_reset;
    reset_sync reset_sync_phy2(
        .async_rst_in(!extbus_res_n),
        .clk(!extbus_phy2),
        .reset_out(extbus_reset));

    // Directly exposed bus registers
    reg  [3:0] addr_incr_r;
    reg [17:0] addr_r;

    reg [7:0] intbus_rddata_r;


    // Asynchronous selection of read data
    reg [7:0] extbus_d_out;
    always @* begin
        case (extbus_a)
            3'd0:    extbus_d_out = {addr_incr_r, 2'b0, addr_r[17:16]};
            3'd1:    extbus_d_out = addr_r[15:8];
            3'd2:    extbus_d_out = addr_r[7:0];
            3'd3:    extbus_d_out = intbus_rddata_r;
            default: extbus_d_out = 8'h42;
        endcase
    end

    assign extbus_d = (!extbus_cs_n && extbus_rw_n) ? extbus_d_out : 8'bZ;
    wire [7:0] extbus_d_in = extbus_d;
    assign extbus_irq_n = 1'bZ;
    assign extbus_rdy = 1'bZ;

    // From extbus domain to intbus domain
    reg do_access_toggle;
    reg [2:0] do_access_toggle_r;
    always @(posedge intbus_clk) do_access_toggle_r <= {do_access_toggle_r[1:0], do_access_toggle};
    wire do_access = do_access_toggle_r[1] ^ do_access_toggle_r[2];

    // From intbus domain to extbus domain
    reg access_done_toggle;
    reg [2:0] access_done_toggle_r;
    always @(negedge extbus_phy2) access_done_toggle_r <= {access_done_toggle_r[1:0], access_done_toggle};
    wire access_done = access_done_toggle_r[1] ^ access_done_toggle_r[2];

    // On positive edge of PHY2, 6502 updates address lines (and thus chipselect) and R/W# line:
    reg [2:0] extbus_a_r;
    reg extbus_rw_n_r;

    always @(posedge extbus_phy2) begin
        if (!extbus_cs_n) begin
            extbus_a_r <= extbus_a;
            extbus_rw_n_r <= extbus_rw_n;
        end
    end

    // On negative edge of PHY2, data lines should be valid
    reg [7:0] extbus_d_in_r;
    reg do_write;
    reg do_increment;

    always @(negedge extbus_phy2 or posedge extbus_reset) begin
        if (extbus_reset) begin
            do_access_toggle <= 0;
            extbus_d_in_r <= 8'h00;

            addr_incr_r <= 0;
            addr_r <= 0;
            do_write <= 0;
            do_increment <= 0;

        end else begin
            if (access_done && do_increment) begin
                addr_r <= addr_r + addr_incr_r;
                do_increment <= 0;
            end

            if (!extbus_cs_n) begin
                case (extbus_a_r)
                    3'd0: if (!extbus_rw_n) begin
                        addr_incr_r   <= extbus_d_in[7:4];
                        addr_r[17:16] <= extbus_d_in[1:0];

                        do_access_toggle <= !do_access_toggle;
                        do_write <= 0;
                    end

                    3'd1: if (!extbus_rw_n) begin
                        addr_r[15:8] <= extbus_d_in;

                        do_access_toggle <= !do_access_toggle;
                        do_write <= 0;
                    end

                    3'd2: if (!extbus_rw_n) begin
                        addr_r[7:0] <= extbus_d_in;

                        do_access_toggle <= !do_access_toggle;
                        do_write <= 0;
                    end

                    3'd3: begin
                        extbus_d_in_r <= extbus_d_in;

                        do_access_toggle <= !do_access_toggle;
                        do_write <= !extbus_rw_n_r;

                        if (!extbus_rw_n_r) begin
                            do_increment <= 1;
                        end else begin
                            addr_r <= addr_r + addr_incr_r;
                        end
                    end
                endcase

            end
        end
    end


    reg readback_result;
    reg readback_result_r;
    always @(posedge intbus_clk or posedge intbus_reset) begin
        if (intbus_reset) begin
            access_done_toggle <= 0;

            intbus_addr <= 18'h0;
            intbus_wrdata <= 8'h0;
            intbus_strobe <= 1'b0;
            intbus_write <= 1'b0;

            intbus_rddata_r <= 8'h0;

            readback_result <= 0;
            readback_result_r <= 0;

        end else begin
            readback_result <= intbus_strobe && !intbus_write;
            readback_result_r <= readback_result;

            intbus_strobe <= 1'b0;
            intbus_write  <= 1'b0;

            if (do_access) begin
                intbus_addr <= addr_r;
                intbus_strobe <= 1'b1;
                intbus_wrdata <= extbus_d_in_r;
                intbus_write <= do_write;

                readback_result <= !do_write;

                access_done_toggle <= !access_done_toggle;
            end

            if (readback_result_r) begin
                intbus_rddata_r <= intbus_rddata;
            end
        end
    end

endmodule
