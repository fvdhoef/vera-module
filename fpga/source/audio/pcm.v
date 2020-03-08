`default_nettype none

module pcm(
    input  wire        rst,
    input  wire        clk,

    input  wire        next_sample,

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

    // Audio output
    output wire [15:0] left_audio,
    output wire [15:0] right_audio);

    //////////////////////////////////////////////////////////////////////////
    // Audio FIFO
    //////////////////////////////////////////////////////////////////////////
    wire       audio_fifo_reset = rst || fifo_reset;

    wire [7:0] fifo_rddata;
    wire       fifo_read = 0;
    wire       fifo_empty;

    audio_fifo audio_fifo(
        .clk(clk),
        .rst(audio_fifo_reset),

        .wrdata(fifo_wrdata),
        .wr_en(fifo_write),

        .rddata(fifo_rddata),
        .rd_en(fifo_read),
        
        .empty(fifo_empty),
        .almost_empty(fifo_almost_empty),
        .full(fifo_full));

    assign left_audio = 0;
    assign right_audio = 0;


endmodule
