`default_nettype none

module pulse2pulse(
    input  wire in_clk,
    input  wire in_pulse,
    input  wire out_clk,
    output wire out_pulse);

    // in_clk domain
    reg toggle_r = 0;
    always @(posedge in_clk) if (in_pulse) toggle_r <= !toggle_r;

    // out_clk domain
    reg [2:0] toggle_sync_r = 0;
    always @(posedge out_clk) toggle_sync_r <= {toggle_sync_r[1:0], toggle_r};
    assign out_pulse = toggle_sync_r[1] ^ toggle_sync_r[2];

endmodule
