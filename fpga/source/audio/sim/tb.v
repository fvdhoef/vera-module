`timescale 1 ns / 1 ps
`default_nettype none

module tb();

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        #30000000 $finish;
    end

    // Generate 25MHz sysclk
    reg sysclk = 0;
    always #20 sysclk = !sysclk;

    reg reset = 1;
    always #100 reset = 0;

    audio audio(
        .rst(reset),
        .clk(sysclk),

        // Register interface
        .regs_addr(4'b0),
        .regs_wrdata(8'b0),
        .regs_rddata(),
        .regs_write(1'b0),

        // Bus master interface
        .bus_addr(),
        .bus_rddata(32'b0),
        .bus_strobe(),
        .bus_ack(1'b0),

        // I2S audio output
        .audio_lrck(),
        .audio_bck(),
        .audio_data());

endmodule
