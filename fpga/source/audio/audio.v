`default_nettype none

module audio(
    input  wire        rst,
    input  wire        clk,

    // PSG interface
    input  wire  [5:0] attr_addr,
    input  wire  [7:0] attr_wrdata,
    input  wire        attr_write,

    // Register interface
    input  wire        pcm_enable,
    input  wire        sample_rate,
    input  wire        sample_duplicate,
    input  wire        mode_stereo,
    input  wire        mode_16bit,
    input  wire        psg_enable,
    input  wire  [7:0] volume,

    // Audio FIFO interface
    input  wire        fifo_reset,
    input  wire  [7:0] fifo_wrdata,
    input  wire        fifo_write,
    output wire        fifo_full,
    output wire        fifo_almost_empty,
    
    // I2S audio output
    output wire        i2s_lrck,
    output wire        i2s_bck,
    output wire        i2s_data);

    wire        next_sample;
    wire [15:0] psg_left;
    wire [15:0] psg_right;

    //////////////////////////////////////////////////////////////////////////
    // Programmable Sound Generator
    //////////////////////////////////////////////////////////////////////////
    psg psg(
        .rst(rst),
        .clk(clk),

        // PSG interface
        .attr_addr(attr_addr),
        .attr_wrdata(attr_wrdata),
        .attr_write(attr_write),

        .enable(psg_enable),
        .next_sample(next_sample),

        // Audio output
        .left_audio(psg_left),
        .right_audio(psg_right));

    //////////////////////////////////////////////////////////////////////////
    // Audio FIFO
    //////////////////////////////////////////////////////////////////////////
    // wire       audio_fifo_reset = rst || fifo_reset;

    // wire [7:0] fifo_rddata;
    // wire       fifo_read;
    // wire       fifo_empty;

    // audio_fifo audio_fifo(
    //     .clk(clk),
    //     .rst(audio_fifo_reset),

    //     .wrdata(fifo_wrdata),
    //     .wr_en(fifo_write),

    //     .rddata(fifo_rddata),
    //     .rd_en(fifo_read),
        
    //     .empty(fifo_empty),
    //     .almost_empty(fifo_almost_empty),
    //     .full(fifo_full));

    //////////////////////////////////////////////////////////////////////////
    // I2S DAC interface
    //////////////////////////////////////////////////////////////////////////
    wire [23:0] left_data = {psg_left, 8'b0};
    wire [23:0] right_data = {psg_right, 8'b0};

    dacif dacif(
        .rst(rst),
        .clk(clk),

        .sample_rate(sample_rate),

        // Sample input
        .next_sample(next_sample),
        .left_data(left_data),
        .right_data(right_data),

        // I2S audio output
        .i2s_lrck(i2s_lrck),
        .i2s_bck(i2s_bck),
        .i2s_data(i2s_data));

endmodule
