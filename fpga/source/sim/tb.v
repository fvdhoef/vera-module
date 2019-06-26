`timescale 1 ns / 1 ns
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

    // Generate 2MHz PHY2 clock
    reg phy2 = 0;
    always #250 phy2 = !phy2;

    // Generate async reset
    reg bus_res_n = 0;
    initial begin
        #123 bus_res_n = 1'b1;
    end

    reg bus_rw_n = 1;
    reg [15:0] bus_a = 0;

    wire bus_cs_n = !((bus_a & 'hFFF0) == 'h1000);


    reg [7:0] bus_d_wr = 0;


    wire [7:0] bus_d = bus_rw_n ? 8'hZ : bus_d_wr;

    top top(
        .clk25(sysclk),

        .bus_res_n(bus_res_n),
        .bus_phy2(phy2),
        .bus_cs_n(bus_cs_n),
        .bus_rw_n(bus_rw_n),
        .bus_a(bus_a[2:0]),
        .bus_d(bus_d));


    task bus_write;
        input [15:0] addr;
        input  [7:0] data;

        begin
            @(negedge phy2)
            #10; // tAH = 10ns
            bus_rw_n = 1'bX;
            bus_a = 16'bX;
            bus_d_wr = 8'bX;
            #20;
            bus_a = addr; // address
            bus_rw_n = 1'b0; // write

            @(posedge phy2)
            #140;
            bus_d_wr = data;


            @(negedge phy2)
            #10;
            bus_a = 16'b0;
            bus_rw_n = 1'b1;
        end
    endtask

    task bus_read;
        input [15:0] addr;

        begin
            @(negedge phy2)
            #10; // tAH = 10ns
            bus_rw_n = 1'bX;
            bus_a = 16'bX;
            bus_d_wr = 8'bX;
            #20;
            bus_a = addr;    // address
            bus_rw_n = 1'b1; // read

            @(negedge phy2)
            #10;
            bus_a = 16'b0;
            bus_rw_n = 1'b1;
        end
    endtask



    initial begin
        #1000
        bus_write(16'h1000, 8'hAA);
        bus_read(16'h1000);

        // for (i=0; i<8; i=i+1) begin

        // end



    end



endmodule
