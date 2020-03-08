`timescale 1 ns / 1 ps
// `default_nettype none
module tb();

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #5000000 $finish;
    end

    // Generate 25MHz sysclk
    reg clk = 0;
    always #20 clk = !clk;

    reg rst = 1;
    always #100 rst = 0;


    reg [5:0] attr_addr = 0;
    reg [7:0] attr_wrdata = 0;
    reg       attr_write = 0;

    reg [7:0] sample_rate = 0;
    reg       mode_stereo = 0;
    reg       mode_16bit = 0;

    reg [3:0] volume = 0;

    reg       fifo_reset;
    reg [7:0] fifo_wrdata;
    reg       fifo_write;


    audio audio(
        .rst(rst),
        .clk(clk),

        // PSG interface
        .attr_addr(attr_addr),
        .attr_wrdata(attr_wrdata),
        .attr_write(attr_write),

        // Register interface
        .sample_rate(sample_rate),
        .mode_stereo(mode_stereo),
        .mode_16bit(mode_16bit),
        .volume(volume),

        // Audio FIFO interface
        .fifo_reset(fifo_reset),
        .fifo_wrdata(fifo_wrdata),
        .fifo_write(fifo_write),
        .fifo_full(),
        .fifo_almost_empty(),
        
        // I2S audio output
        .i2s_lrck(),
        .i2s_bck(),
        .i2s_data());

    task awrite;
        input [5:0] addr;
        input [7:0] data;

        begin
            @(posedge clk)
            attr_addr   = addr;
            attr_wrdata = data;
            attr_write  = 1;

            @(posedge clk)
            attr_write  = 0;
        end
    endtask

    initial begin : TB
        integer i;

        #200;

        for (i=0; i<16; i=i+1) begin
            awrite(6'h00 + i*4, 8'h9D);
            awrite(6'h01 + i*4, 8'hFF);
            awrite(6'h02 + i*4, 8'hBF);
            awrite(6'h03 + i*4, 8'h40);
        end


        // awrite(7'h04, 8'h9D);
        // awrite(7'h05, 8'hFF);
        // awrite(7'h06, 8'hBF);
        // awrite(7'h07, 8'h80);


        // // awrite(7'h04, 8'h9D);
        // // awrite(7'h05, 8'hFF);
        // // awrite(7'h06, 8'h7F);
        // // awrite(7'h07, 8'h80);
        // awrite(7'h7C, 8'h9D);
        // awrite(7'h7D, 8'hFF);
        // awrite(7'h7E, 8'h7F);
        // awrite(7'h7F, 8'h80);

        // // awrite(7'h04, 8'hFF);
        // // awrite(7'h05, 8'h09);
        // // awrite(7'h06, 8'hFF);
        // // awrite(7'h07, 8'h7F);
    end


endmodule
