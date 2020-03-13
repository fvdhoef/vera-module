`timescale 1 ns / 1 ps
`default_nettype none

module tb();

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        // #3000000 $finish;
        #30000 $finish;
    end

    // Generate 8MHz phi2
    reg phi2 = 0;
    always #62.5 phi2 = !phi2;

    // Generate 25MHz sysclk
    reg sysclk = 0;
    always #20 sysclk = !sysclk;

    reg extbus_rw_n = 1;
    reg [15:0] extbus_a = 0;

    wire extbus_cs_n = !((extbus_a & 'hFFF0) == 'h9F20);


    reg [7:0] extbus_d_wr = 0;


    wire [7:0] extbus_d = extbus_rw_n ? 8'hZ : extbus_d_wr;

    wire extbus_wr_n = extbus_rw_n || !phi2;
    wire extbus_rd_n = !extbus_rw_n || !phi2;

    top top(
        .clk25(sysclk),

        .extbus_cs_n(extbus_cs_n),
        .extbus_rd_n(extbus_rd_n),
        .extbus_wr_n(extbus_wr_n),
        .extbus_a(extbus_a[4:0]),
        .extbus_d(extbus_d),
        
        .spi_miso(1'b1));


    task extbus_write;
        input [15:0] addr;
        input  [7:0] data;

        begin
            @(negedge phi2)
            #10; // tAH = 10ns
            // extbus_rw_n = 1'bX;
            // extbus_a = 16'bX;
            // extbus_d_wr = 8'bX;
            #20;
            extbus_a = addr; // address
            extbus_rw_n = 1'b0; // write

            @(posedge phi2)
            #25;
            extbus_d_wr = data;


            @(negedge phi2)
            #10;
            extbus_a = 16'b0;
            extbus_rw_n = 1'b1;
            // extbus_d_wr = 8'bX;

            @(negedge phi2);
            @(negedge phi2);
            @(negedge phi2);

        end
    endtask

    task extbus_read;
        input [15:0] addr;

        begin
            @(negedge phi2)
            #10; // tAH = 10ns
            // extbus_rw_n = 1'bX;
            // extbus_a = 16'bX;
            // extbus_d_wr = 8'bX;
            #20;
            extbus_a = addr;    // address
            extbus_rw_n = 1'b1; // read

            @(negedge phi2)
            #10;
            extbus_a = 16'b0;
            extbus_rw_n = 1'b1;


            @(negedge phi2);
            @(negedge phi2);
            @(negedge phi2);
        end
    endtask



    initial begin
        #6000

        extbus_write(16'h9F25, 8'h01);

        extbus_write(16'h9F20, 8'h00);
        extbus_write(16'h9F21, 8'h40);
        extbus_write(16'h9F22, 8'h10);

        extbus_write(16'h9F24, 8'hA1);
        extbus_write(16'h9F24, 8'hA2);
        extbus_write(16'h9F24, 8'hA3);
        extbus_write(16'h9F24, 8'hA4);

        extbus_write(16'h9F20, 8'h00);
        extbus_write(16'h9F21, 8'h40);
        extbus_write(16'h9F22, 8'h10);

        extbus_read(16'h9F24);
        extbus_read(16'h9F24);
        extbus_read(16'h9F24);
        extbus_read(16'h9F24);







        // extbus_write(16'h1000, 8'h00);
        // extbus_write(16'h1001, 8'h40);
        // extbus_write(16'h1002, 8'h10);

        // extbus_write(16'h1003, 8'hA0);
        // extbus_write(16'h1003, 8'hA1);
        // extbus_write(16'h1003, 8'hA2);
        // extbus_write(16'h1003, 8'hA3);

        // extbus_write(16'h1000, 8'h00);
        // extbus_write(16'h1001, 8'h40);

        // extbus_read(16'h1003);
        // extbus_read(16'h1003);
        // extbus_read(16'h1003);
        // extbus_read(16'h1003);

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

        // @(negedge phi2);
        // extbus_write(16'h1003, 8'h02);
        // @(negedge phi2);
        // extbus_write(16'h1003, 8'h03);
        // @(negedge phi2);
        // extbus_write(16'h1003, 8'h04);
        // @(negedge phi2);

        // extbus_write(16'h1000, 8'h10);
        // @(negedge phi2);
        // extbus_write(16'h1001, 8'h00);
        // @(negedge phi2);
        // extbus_write(16'h1002, 8'h00);
        // @(negedge phi2);




        // extbus_write(16'h1003, 8'h13);
        // extbus_write(16'h1003, 8'h42);
        // extbus_write(16'h1003, 8'h02);
        // extbus_write(16'h1003, 8'h03);

        // for (i=0; i<8; i=i+1) begin

        // end



    end



endmodule
