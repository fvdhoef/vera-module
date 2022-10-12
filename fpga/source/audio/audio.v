//`default_nettype none

module audio(
    input  wire        rst,
    input  wire        clk,

    // PSG interface
    input  wire  [5:0] attr_addr,
    input  wire  [7:0] attr_wrdata,
    input  wire        attr_write,

    // Register interface
    input  wire  [7:0] sample_rate,
    input  wire        mode_stereo,
    input  wire        mode_16bit,
    input  wire  [3:0] volume,

    // Audio FIFO interface
    input  wire        fifo_reset,
    input  wire  [7:0] fifo_wrdata,
    input  wire        fifo_write,
    output wire        fifo_full,
    output wire        fifo_almost_empty,
    output wire        fifo_empty,
    
    // I2S audio output
    output wire        i2s_lrck,
    output wire        i2s_bck,
    output wire        i2s_data);

    wire        next_sample;
    wire signed [22:0] psg_left;
    wire signed [22:0] psg_right;

    wire signed [22:0] pcm_left;
    wire signed [22:0] pcm_right;

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

        .next_sample(next_sample),

        // Audio output
        .left_audio(psg_left),
        .right_audio(psg_right));

    //////////////////////////////////////////////////////////////////////////
    // PCM playback
    //////////////////////////////////////////////////////////////////////////
    pcm pcm(
        .rst(rst),
        .clk(clk),

        .next_sample(next_sample),

        // Register interface
        .sample_rate(sample_rate),
        .mode_stereo(mode_stereo),
        .mode_16bit(mode_16bit),
        .volume(volume),

        // Audio FIFO interface
        .fifo_reset(fifo_reset),
        .fifo_wrdata(fifo_wrdata),
        .fifo_write(fifo_write),
        .fifo_full(fifo_full),
        .fifo_almost_empty(fifo_almost_empty),
        .fifo_empty(fifo_empty),

        // Audio output
        .left_audio(pcm_left),
        .right_audio(pcm_right));

    //////////////////////////////////////////////////////////////////////////
    // I2S DAC interface
    //////////////////////////////////////////////////////////////////////////

    wire [23:0] left_data = psg_left + pcm_left;
    wire [23:0] right_data = psg_right + pcm_right;

    dacif dacif(
        .rst(rst),
        .clk(clk),

        // Sample input
        .next_sample(next_sample),
        .left_data(left_data),
        .right_data(right_data),

        // I2S audio output
        .i2s_lrck(i2s_lrck),
        .i2s_bck(i2s_bck),
        .i2s_data(i2s_data));

endmodule
