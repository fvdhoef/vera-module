`default_nettype none

module audio(
    input  wire        rst,
    input  wire        clk,

    // Register interface
    input  wire  [3:0] regs_addr,
    input  wire  [7:0] regs_wrdata,
    output reg   [7:0] regs_rddata,
    input  wire        regs_write,

    // Bus master interface
    output reg  [15:0] bus_addr,
    input  wire [31:0] bus_rddata,
    output wire        bus_strobe,
    input  wire        bus_ack,

    // I2S audio output
    output wire        audio_lrck,
    output wire        audio_bck,
    output wire        audio_data);

    wire        next_sample;
    wire [23:0] left_data;
    wire [23:0] right_data;

    reg  [19:0] phase;
    wire [11:0] attenuation;
    wire [12:0] result;

    reg [7:0] cnt_r = 0;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            phase <= 0;
        end else begin
            if (next_sample) begin
                phase <= phase + 'd10240;
            end
        end
    end


    assign attenuation = 12'b0;

    operator operator(
        .clk(clk),
        .phase(phase),
        .attenuation(attenuation),
        .result(result));


    assign left_data  = { result, 11'b0 };
    assign right_data = { result, 11'b0 };

    // DAC interface
    dacif dacif(
        .rst(rst),
        .clk(clk),

        // Sample input
        .next_sample(next_sample),
        .left_data(left_data),
        .right_data(right_data),

        // I2S audio output
        .audio_lrck(audio_lrck),
        .audio_bck(audio_bck),
        .audio_data(audio_data));

endmodule
