`default_nettype none

module operator(
    input  wire        clk,

    input  wire [19:0] phase,
    input  wire [11:0] attenuation,

    output reg  [12:0] result);

    // log(sin()) lookup
    wire [11:0] logsin_result;
    logsin_table logsin_table(
        .clk(clk),
        .addr(phase[18] ? ~phase[17:10] : phase[17:10]),
        .value(logsin_result));

    reg invert_result_r;
    always @(posedge clk) invert_result_r <= phase[19];

    //////////////////////////////////////////////////////////////////////////

    wire [12:0] logsin_plus_attenuation = {1'b0, logsin_result} + {1'b0, attenuation};

    // exp() lookup
    wire [9:0] exp_out;
    exp_table exp_table(
        .clk(clk),
        .addr(~logsin_plus_attenuation[7:0]),
        .value(exp_out));

    reg [4:0] shift_amount_r;
    always @(posedge clk) shift_amount_r <= logsin_plus_attenuation[12:8];

    reg invert_result_rr;
    always @(posedge clk) invert_result_rr <= (logsin_plus_attenuation[12:8] < 5'd12) ? invert_result_r : 1'b0;

    //////////////////////////////////////////////////////////////////////////

    wire [11:0] pre_shift = {1'b1, exp_out, 1'b0};

    // Shift result
    reg [12:0] shift_result;
    always @*
        case (shift_amount_r)
            5'd0:    shift_result <= {1'b0, pre_shift[11:0]};
            5'd1:    shift_result <= {2'b0, pre_shift[11:1]};
            5'd2:    shift_result <= {3'b0, pre_shift[11:2]};
            5'd3:    shift_result <= {4'b0, pre_shift[11:3]};
            5'd4:    shift_result <= {5'b0, pre_shift[11:4]};
            5'd5:    shift_result <= {6'b0, pre_shift[11:5]};
            5'd6:    shift_result <= {7'b0, pre_shift[11:6]};
            5'd7:    shift_result <= {8'b0, pre_shift[11:7]};
            5'd8:    shift_result <= {9'b0, pre_shift[11:8]};
            5'd9:    shift_result <= {10'b0, pre_shift[11:9]};
            5'd10:   shift_result <= {11'b0, pre_shift[11:10]};
            5'd11:   shift_result <= {12'b0, pre_shift[11]};
            default: shift_result <= 13'b0;
        endcase

    always @(posedge clk) result <= invert_result_rr ? ~shift_result : shift_result;

endmodule
