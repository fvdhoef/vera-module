`ifndef CLK_RST_GEN
`define CLK_RST_GEN

`timescale 1ns/1ns

module clk_rst_gen # (
    parameter CLK_FREQ   = 10,
    parameter RESET_CNT  = 10,
    parameter DIFF_CLOCK = 1
)(
    output reg clk1,
    output reg clk2,
    output reg rst
);

initial begin
    rst <= 1'b1;
    #RESET_CNT;
    rst <= 1'b0;
end

initial begin
    clk1 <= 1'b0;
    forever #CLK_FREQ clk1 <= ~clk1;
end

if(DIFF_CLOCK) begin
    localparam CLK2FREQ = 11*CLK_FREQ/7;
    initial begin
        clk2 <= 1'b0;
        #2;
        forever #CLK2FREQ clk2 <= ~clk2;
    end
end
else begin
    initial begin
        clk2 <= 1'b0;
        forever #CLK_FREQ clk2 <= ~clk2;
    end
end

endmodule
`endif