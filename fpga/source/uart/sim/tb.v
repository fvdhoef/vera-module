`timescale 1 ns / 1 ps
`default_nettype none

module tb();

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #300000 $finish;
    end

    // Generate 25MHz sysclk
    reg sysclk = 0;
    always #20 sysclk = !sysclk;

    reg reset = 1;
    always #100 reset = 0;

    wire       uart_irq;
    reg  [1:0] bus_addr   = 0;
    reg  [7:0] bus_wrdata = 0;
    wire [7:0] bus_rddata;
    reg        bus_sel    = 0;
    reg        bus_strobe    = 0;
    reg        bus_write  = 0;
    wire       uart_rxd   = 1;
    wire       uart_txd;

    uart uart(
        .rst(reset),
        .clk(sysclk),

        .irq(),
        
        // Slave bus interface
        .bus_addr(bus_addr),
        .bus_wrdata(bus_wrdata),
        .bus_rddata(bus_rddata),
        .bus_sel(bus_sel),
        .bus_strobe(bus_strobe),
        .bus_write(bus_write),

        // UART interface
        .uart_rxd(uart_txd),
        .uart_txd(uart_txd));

    // uart_rx uart_rx(
    //     .clk(sysclk),
    //     .rst(reset),

    //     .baudrate_div(16'd24),

    //     .uart_rxd(uart_txd),
    //     .rx_data(),
    //     .rx_valid());


    task bwrite;
        input [15:0] addr;
        input  [7:0] data;

        begin
            @(posedge sysclk);
            bus_addr   = addr[1:0];
            bus_wrdata = data;
            bus_sel    = 1;
            bus_strobe = 1;
            bus_write  = 1;

            @(posedge sysclk);
            bus_sel    = 0;
            bus_strobe = 0;
            bus_write  = 0;
        end
    endtask

    task bread;
        input [15:0] addr;

        begin
            @(posedge sysclk);
            bus_addr   = addr[1:0];
            bus_sel    = 1;
            bus_strobe = 1;
            bus_write  = 0;

            @(posedge sysclk);
            bus_sel    = 0;
            bus_strobe = 0;
        end
    endtask

    task uart_tx;
        input [7:0] data;

        begin
            bus_addr = 'd1;
            @(posedge sysclk);
            while (bus_rddata[1]) begin
                @(posedge sysclk);
            end

            bwrite(16'h0000, data);
        end
    endtask

    initial begin
        #200

        uart_tx(8'h5A);
        uart_tx(8'h12);
        uart_tx(8'h34);
        uart_tx(8'h56);


    end

endmodule
