`timescale 1 ns / 1 ns
`default_nettype none

module tb();

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #3000000 $finish;
    end

    // Generate 25MHz sysclk
    reg sysclk = 0;
    always #20 sysclk = !sysclk;

    // Generate 2MHz PHY2 clock
    reg phy2 = 0;
    always #250 phy2 = !phy2;

    // Generate async reset
    reg extbus_res_n = 0;
    initial begin
        #123 extbus_res_n = 1'b1;
    end

    reg extbus_rw_n = 1;
    reg [15:0] extbus_a = 0;

    wire extbus_cs_n = !((extbus_a & 'hFFF0) == 'h1000);


    reg [7:0] extbus_d_wr = 0;


    wire [7:0] extbus_d = extbus_rw_n ? 8'hZ : extbus_d_wr;

    top top(
        .clk25(sysclk),

        .extbus_res_n(extbus_res_n),
        .extbus_phy2(phy2),
        .extbus_cs_n(extbus_cs_n),
        .extbus_rw_n(extbus_rw_n),
        .extbus_a(extbus_a[2:0]),
        .extbus_d(extbus_d));


    task extbus_write;
        input [15:0] addr;
        input  [7:0] data;

        begin
            @(negedge phy2)
            #10; // tAH = 10ns
            extbus_rw_n = 1'bX;
            extbus_a = 16'bX;
            extbus_d_wr = 8'bX;
            #20;
            extbus_a = addr; // address
            extbus_rw_n = 1'b0; // write

            @(posedge phy2)
            #140;
            extbus_d_wr = data;


            @(negedge phy2)
            #10;
            extbus_a = 16'b0;
            extbus_rw_n = 1'b1;
        end
    endtask

    task extbus_read;
        input [15:0] addr;

        begin
            @(negedge phy2)
            #10; // tAH = 10ns
            extbus_rw_n = 1'bX;
            extbus_a = 16'bX;
            extbus_d_wr = 8'bX;
            #20;
            extbus_a = addr;    // address
            extbus_rw_n = 1'b1; // read

            @(negedge phy2)
            #10;
            extbus_a = 16'b0;
            extbus_rw_n = 1'b1;
        end
    endtask



    initial begin
        #1000
        extbus_write(16'h1000, 8'h12);
        extbus_write(16'h1001, 8'h00);
        extbus_write(16'h1002, 8'h00);
        extbus_read(16'h1003);
        extbus_read(16'h1003);
        extbus_read(16'h1003);
        extbus_read(16'h1003);

        // extbus_write(16'h1002, 8'h10);
        // extbus_read(16'h1003);

        // extbus_write(16'h1000, 8'h00);
        // extbus_write(16'h1001, 8'h00);
        // extbus_write(16'h1002, 8'hA5);
        // extbus_read(16'h1003);
        // extbus_write(16'h1002, 8'h5A);
        // extbus_read(16'h1003);
        // extbus_write(16'h1002, 8'h42);
        // extbus_read(16'h1003);

        // extbus_write(16'h1003, 8'h01);
        // extbus_write(16'h1003, 8'h02);
        // extbus_write(16'h1003, 8'h03);
        // extbus_write(16'h1003, 8'h04);

        // extbus_write(16'h1000, 8'h10);
        // extbus_write(16'h1001, 8'h00);
        // extbus_write(16'h1002, 8'h00);

        // extbus_read(16'h1003);
        // extbus_read(16'h1003);
        // extbus_read(16'h1003);
        // extbus_read(16'h1003);

        // @(negedge phy2);
        // extbus_write(16'h1003, 8'h02);
        // @(negedge phy2);
        // extbus_write(16'h1003, 8'h03);
        // @(negedge phy2);
        // extbus_write(16'h1003, 8'h04);
        // @(negedge phy2);

        // extbus_write(16'h1000, 8'h10);
        // @(negedge phy2);
        // extbus_write(16'h1001, 8'h00);
        // @(negedge phy2);
        // extbus_write(16'h1002, 8'h00);
        // @(negedge phy2);




        // extbus_write(16'h1003, 8'h13);
        // extbus_write(16'h1003, 8'h42);
        // extbus_write(16'h1003, 8'h02);
        // extbus_write(16'h1003, 8'h03);

        // for (i=0; i<8; i=i+1) begin

        // end



    end



endmodule
