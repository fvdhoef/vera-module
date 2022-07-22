//`default_nettype none

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
    output wire        fifo_empty,

    // Audio output
    output wire [15:0] left_audio,
    output wire [15:0] right_audio);

    //////////////////////////////////////////////////////////////////////////
    // Audio FIFO
    //////////////////////////////////////////////////////////////////////////
    wire       audio_fifo_reset = rst || fifo_reset;

    wire [7:0] fifo_rddata;
    reg        fifo_read;

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

    //////////////////////////////////////////////////////////////////////////
    // Sample rate
    //////////////////////////////////////////////////////////////////////////
    reg [7:0] sr_accum_r;
    reg       sr_accum7_r;

    reg       next_sample_r;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sr_accum_r <= 0;
            next_sample_r <= 0;
        end else begin
            next_sample_r <= next_sample;

            if (next_sample) begin
                sr_accum7_r <= sr_accum_r[7];
                sr_accum_r <= sr_accum_r + sample_rate;
            end
        end
    end

    wire new_sample = next_sample_r && (sr_accum7_r != sr_accum_r[7]);

    //////////////////////////////////////////////////////////////////////////
    // FIFO reading
    //////////////////////////////////////////////////////////////////////////
    parameter
        IDLE         = 3'd0,
        FETCH_L_7_0  = 3'd1,
        FETCH_L_15_8 = 3'd2,
        FETCH_R_7_0  = 3'd3,
        FETCH_R_15_8 = 3'd4,
        DONE         = 3'd5;

    reg  [2:0] state_r, state_next;
    reg [15:0] left_sample_r,  left_sample_next;
    reg [15:0] right_sample_r, right_sample_next;

    reg signed [15:0] left_output_r,  left_output_next;
    reg signed [15:0] right_output_r, right_output_next;

    wire [15:0] left_sample  = mode_16bit ? left_sample_r  : {left_sample_r[7:0], 8'b0};
    wire [15:0] right_sample = mode_16bit ? right_sample_r : {right_sample_r[7:0], 8'b0};

    always @* begin
        state_next        = state_r;
        left_sample_next  = left_sample_r;
        right_sample_next = right_sample_r;
        left_output_next  = left_output_r;
        right_output_next = right_output_r;
        fifo_read         = 0;

        case (state_r)
            IDLE: begin
                if (fifo_empty) begin
                    left_output_next  = 0;
                    right_output_next = 0;
                end

                if (new_sample && !fifo_empty) begin
                    left_sample_next  = 0;
                    right_sample_next = 0;
                    state_next        = FETCH_L_7_0;
                    fifo_read         = 1;
                end
            end

            FETCH_L_7_0: begin
                left_sample_next[7:0] = fifo_rddata;

                if (mode_16bit) begin
                    state_next = FETCH_L_15_8;
                    fifo_read  = 1;
                end else if (mode_stereo) begin
                    state_next = FETCH_R_7_0;
                    fifo_read  = 1;
                end else begin
                    state_next = DONE;
                end
            end

            FETCH_L_15_8: begin
                left_sample_next[15:8] = fifo_rddata;

                if (mode_stereo) begin
                    state_next = FETCH_R_7_0;
                    fifo_read  = 1;
                end else begin
                    state_next = DONE;
                end
            end

            FETCH_R_7_0: begin
                right_sample_next[7:0] = fifo_rddata;
                if (mode_16bit) begin
                    state_next = FETCH_R_15_8;
                    fifo_read  = 1;
                end else begin
                    state_next = DONE;
                end
            end

            FETCH_R_15_8: begin
                right_sample_next[15:8] = fifo_rddata;
                state_next             = DONE;
            end

            DONE: begin
                left_output_next  = left_sample;
                right_output_next = mode_stereo ? right_sample : left_sample;
                state_next        = IDLE;
            end
        endcase

        if (state_r != DONE && fifo_empty) begin
            fifo_read  = 0;
            state_next = IDLE;
        end

    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r        <= IDLE;
            left_sample_r  <= 0;
            right_sample_r <= 0;
            left_output_r  <= 0;
            right_output_r <= 0;
        
        end else begin
            state_r        <= state_next;
            left_sample_r  <= left_sample_next;
            right_sample_r <= right_sample_next;
            left_output_r  <= left_output_next;
            right_output_r <= right_output_next;
        end
    end

    //////////////////////////////////////////////////////////////////////////
    // Volume
    //////////////////////////////////////////////////////////////////////////

    // Logarithmic volume conversion (3dB per step)
    reg signed [7:0] volume_log;
    always @* case (volume)
        4'd0:  volume_log = 8'd0;
        4'd1:  volume_log = 8'd1;
        4'd2:  volume_log = 8'd2;
        4'd3:  volume_log = 8'd3;
        4'd4:  volume_log = 8'd4;
        4'd5:  volume_log = 8'd5;
        4'd6:  volume_log = 8'd6;
        4'd7:  volume_log = 8'd8;
        4'd8:  volume_log = 8'd11;
        4'd9:  volume_log = 8'd14;
        4'd10: volume_log = 8'd18;
        4'd11: volume_log = 8'd23;
        4'd12: volume_log = 8'd30;
        4'd13: volume_log = 8'd38;
        4'd14: volume_log = 8'd49;
        4'd15: volume_log = 8'd64;
    endcase

    reg signed [21:0] left_scaled_r, right_scaled_r;

    always @(posedge clk) begin
        left_scaled_r  <= left_output_r  * volume_log;
        right_scaled_r <= right_output_r * volume_log;
    end

    assign left_audio  = left_scaled_r[21:6];
    assign right_audio = right_scaled_r[21:6];

endmodule
