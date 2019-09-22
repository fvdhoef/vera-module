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

/*
    // Sound parameter RAM (CPU accessible)
    wire  [7:0] params_wraddr;
    wire [31:0] params_wrdata;
    wire        params_wren;

    wire  [7:0] params_rdaddr;
    wire [31:0] params_rddata;

    dpram param_ram #(.ADDR_WIDTH(8), .DATA_WIDTH(32)) (
        .wr_clk(clk),
        .wr_addr(params_wraddr),
        .wr_en(params_wren),
        .wr_data(params_wrdata),

        .rd_clk(clk),
        .rd_addr(params_rdaddr),
        .rd_data(params_rddata));

    // Variables RAM
    wire  [7:0] vars_wraddr;
    wire [31:0] vars_wrdata;
    wire        vars_wren;

    wire  [7:0] vars_rdaddr;
    wire [31:0] vars_rddata;

    dpram param_ram #(.ADDR_WIDTH(8), .DATA_WIDTH(32)) (
        .wr_clk(clk),
        .wr_addr(vars_wraddr),
        .wr_en(vars_wren),
        .wr_data(vars_wrdata),

        .rd_clk(clk),
        .rd_addr(vars_rdaddr),
        .rd_data(vars_rddata));

    // --- PSG channel ---
    // Params:
    //   [1:0] wavesel: square / saw / triangle / noise
    //  [13:0] freq
    //   [7:0] volume left
    //   [7:0] volume right
    // Variables:
    //  [21:0] current phase

    //
    // op4_freq = freq * op4_ratio
    // op4_current_phase += op4_freq;
    // op4_val = sin(op4_current_phase);
    //
    // op3_freq = freq * op3_ratio
    // op3_current_phase += op3_freq + op4_val;
    // op3_val = sin(op3_current_phase);
    //
    // op2_freq = freq * op2_ratio
    // op2_current_phase += op2_freq + op3_val;
    // op2_val = sin(op2_current_phase);
    //
    // op1_freq = freq * op1_ratio
    // op1_current_phase += op1_freq + op2_val;
    // op1_val = sin(op1_current_phase);
    //


    wire        next_sample;
    wire [23:0] left_data;
    wire [23:0] right_data;

    // Registers
    // reg [15:0] sample0_base_r;
    // reg [15:0] sample0_length_r;
    // reg [15:0] sample0_rate_r;
    // reg  [7:0] sample0_volume_l_r;
    // reg  [7:0] sample0_volume_r_r;
    // reg        sample0_16bit_r;


    reg [7:0] cnt_r = 0;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt_r <= 0;
        end else begin
            if (next_sample) begin
                cnt_r <= cnt_r + 1;
            end
        end
    end
*/

    // --- FM channel ---
    //  [13:0] freq
    //   [7:0] op1_ratio (4.4 fixed point)
    //   [7:0] op2_ratio (4.4 fixed point)
    //   [7:0] op3_ratio (4.4 fixed point)
    //   [7:0] op4_ratio (4.4 fixed point)


    // fs = 25e6 / 512
    // f_out = (FW * fs) / 2^20

    //  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 
    // +-------------------------------+-------------------------------+
    // |                               |             freq              |
    // +---------------+---------------+---------------+---------------+
    // |   op3_level   |   op2_level   |   op1_level   |   op0_level   |
    // +---------------+---------------+---------------+---------------+
    // |   op3_ratio   |   op2_ratio   |   op1_ratio   |   op0_ratio   |
    // +---------------+-------+-------+---------------+---------------+
    // |                       |               op0_phase               |
    // +-----------------------+---------------------------------------+
    // |                       |               op1_phase               |
    // +-----------------------+---------------------------------------+
    // |                       |               op2_phase               |
    // +-----------------------+---------------------------------------+
    // |                       |               op3_phase               |
    // +-----------------------+---------------------------------------+

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
