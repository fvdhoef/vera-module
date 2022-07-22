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
    wire [15:0] psg_left;
    wire [15:0] psg_right;

    wire [15:0] pcm_left;
    wire [15:0] pcm_right;

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
    wire [16:0] psg_l = {psg_left[15], psg_left};
    wire [16:0] psg_r = {psg_right[15], psg_right};
    wire [16:0] pcm_l = {pcm_left[15], pcm_left};
    wire [16:0] pcm_r = {pcm_right[15], pcm_right};

    wire [16:0] mix_l = psg_l + pcm_l;
    wire [16:0] mix_r = psg_r + pcm_r;

    wire [23:0] left_data = {mix_l, 7'b0};
    wire [23:0] right_data = {mix_r, 7'b0};

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
