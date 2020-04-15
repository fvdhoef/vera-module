`timescale 1 ns / 1 ps
//`default_nettype none

module tb();

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        // #3000000 $finish;
        #30000 $finish;
    end

    // Generate 25MHz sysclk
    reg clk = 0;
    always #20 clk = !clk;

    reg rst = 1;
    always #200 rst = 0;

    reg  [7:0] txdata = 0;
    reg        txstart = 0;
    wire [7:0] rxdata;
    wire       busy;
    reg        slow = 0;

    spictrl spictrl(
        .rst(rst),
        .clk(clk),
        
        // Register interface
        .txdata(txdata),
        .txstart(txstart),
        .rxdata(rxdata),
        .busy(busy),

        .slow(slow),
        
        // SPI interface
        .spi_sck(),
        .spi_mosi(),
        .spi_miso(1'b1));

    initial begin
        #1000;

        @(negedge clk);

        txdata = 8'h55;
        txstart = 1;

        @(negedge clk);

        txstart = 0;

        #1000;

        @(negedge clk);
        slow = 1;
        txstart = 1;

        @(negedge clk);

        txstart = 0;

    end



endmodule
