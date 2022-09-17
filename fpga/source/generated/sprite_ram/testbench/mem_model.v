`ifndef MEM_MODEL
`define MEM_MODEL

module mem_model # (
    parameter FAMILY      = "common",
    parameter A_DEPTH     = 1024,
    parameter A_AWID      = clog2(A_DEPTH),
    parameter A_DWID      = 32,
    parameter B_DEPTH     = 2048,
    parameter B_AWID      = clog2(B_DEPTH),
    parameter B_DWID      = 16,
    parameter INIT_MODE   = "none",
    parameter INIT_FORMAT = "hex",
    parameter INIT_FILE   = "none",
    parameter BEN_WID     = 8,
    parameter A_BDWID     = roundUP(A_DWID, BEN_WID),
    parameter B_BDWID     = roundUP(B_DWID, BEN_WID),
    parameter BYTE_EN_A   = 1,
    parameter BYTE_EN_B   = 1,
    parameter BENA_POL    = 1,
    parameter BENB_POL    = 1,
    parameter REGMODE_A   = "noreg",
    parameter REGMODE_B   = "noreg",
    parameter RSTA_POL    = 1,
    parameter RSTB_POL    = 1
)(
    input                    clk_a_i,
    input                    clk_en_a_i,
    input                    rst_a_i,
    input                    wr_en_a_i,
    input      [A_AWID-1:0]  addr_a_i,
    input      [A_DWID-1:0]  data_a_i,
    input      [A_BDWID-1:0] ben_a_i,

    output reg [A_DWID-1:0]  data_a_o,

    input                    clk_b_i,
    input                    clk_en_b_i,
    input                    rst_b_i,
    input                    wr_en_b_i,
    input      [B_AWID-1:0]  addr_b_i,
    input      [B_DWID-1:0]  data_b_i,
    input      [B_BDWID-1:0] ben_b_i,

    output reg [B_DWID-1:0]  data_b_o
);

genvar g0, g1;
integer i0;

reg [A_DWID-1:0] mem [(2**A_AWID)-1:0];

wire rst_a_c;
wire rst_b_c;

assign rst_a_c = (RSTA_POL) ? rst_a_i : ~rst_a_i;
assign rst_b_c = (RSTB_POL) ? rst_b_i : ~rst_b_i;

initial begin
    if(INIT_MODE == "mem_file") begin
        if(INIT_FORMAT == "hex") begin
            $readmemh(INIT_FILE, mem, 0, A_DEPTH-1);
        end
        else begin
            $readmemb(INIT_FILE, mem, 0, A_DEPTH-1);
        end
        for(i0 = 0; i0 < (2**A_AWID); i0 = i0 + 1) begin
            if(mem[i0] == {A_DWID{1'bx}} && FAMILY != "common") begin
                mem[i0] = {A_DWID{1'b0}};
            end
        end
    end
    else if(FAMILY != "common") begin
        for(i0 = 0; i0 < (2**A_AWID); i0 = i0 + 1) begin
            mem[i0] = (INIT_MODE == "all_one") ? {A_DWID{1'b1}} : {A_DWID{1'b0}};
        end
    end
end

/*
 *    WRITING AT PORT A
 */
wire [A_DWID-1:0] data_a_nxt_c;
if(BYTE_EN_A == 0) begin : _BEN_A_DIS
    assign data_a_nxt_c = data_a_i;
end
else begin : _BEN_A_EN
    wire [A_DWID-1:0] data_a_p;
    assign data_a_p = mem[addr_a_i];

    for(g0 = 0; g0 < A_BDWID; g0 = g0 + 1) begin
        assign data_a_nxt_c[g0*BEN_WID +: BEN_WID] = (ben_a_i[g0] == BENA_POL) ? data_a_i[g0*BEN_WID +: BEN_WID] : 
                                                                                 data_a_p[g0*BEN_WID +: BEN_WID];
    end
end

always @ (posedge clk_a_i) begin
    if(clk_en_a_i & wr_en_a_i) begin
        mem[addr_a_i] <= data_a_nxt_c;
    end
end

/*
 *    READING AT PORT A
 */
if(REGMODE_A == "noreg") begin :_NREG_A
    always @ (posedge clk_a_i, posedge rst_a_c) begin
        if(rst_a_c) begin
            data_a_o <= {A_DWID{1'b0}};
        end
        else begin
            if(~wr_en_a_i & clk_en_a_i) begin
                data_a_o <= mem[addr_a_i];
            end
        end
    end
end
else begin : _REG_A
    reg [A_DWID-1:0] dbuf_a_r;
    always @ (posedge clk_a_i, posedge rst_a_c) begin
        if(rst_a_c) begin
            dbuf_a_r <= {A_DWID{1'b0}};
            data_a_o <= {A_DWID{1'b0}};
        end
        else begin
            if(clk_en_a_i) begin
                data_a_o <= dbuf_a_r;
                if(~wr_en_a_i) begin
                    dbuf_a_r <= mem[addr_a_i];
                end
            end
        end
    end
end

if(A_DWID == B_DWID) begin : A_EQ_B
    wire [B_DWID-1:0] data_b_nxt_c;
    /*
     *    WRITING AT PORT B
     */
    if(BYTE_EN_B == 0) begin : _BEN_B_DIS
        assign data_b_nxt_c = data_b_i;
    end
    else begin : _BEN_B_EN
        wire [B_DWID-1:0] data_b_p;
        for(g0 = 0; g0 < B_BDWID; g0 = g0 + 1) begin
            assign data_b_nxt_c[g0*BEN_WID +: BEN_WID] = (ben_b_i[g0] == BENB_POL) ? data_b_i[g0*BEN_WID +: BEN_WID] : 
                                                                                     data_b_p[g0*BEN_WID +: BEN_WID];
        end
    end

    always @ (posedge clk_b_i) begin
        if(clk_en_b_i & wr_en_b_i) begin
            mem[addr_b_i] <= data_b_nxt_c;
        end
    end
    /*
     *    READING AT PORT B
     */
    if(REGMODE_B == "noreg") begin : _NREG_B
        always @ (posedge clk_b_i, posedge rst_b_c) begin
            if(rst_b_c) begin
                data_b_o <= {B_DWID{1'b0}};
            end
            else begin
                if(~wr_en_b_i) begin
                    data_b_o <= mem[addr_b_i];
                end
            end
        end
    end
    else begin : _REG_B
        reg [B_DWID-1:0] dbuf_b_r;
        always @ (posedge clk_b_i, posedge rst_b_c) begin
            if(rst_b_c) begin
                dbuf_b_r <= {B_DWID{1'b0}};
                data_b_o <= {B_DWID{1'b0}};
            end
            else begin
                data_b_o <= dbuf_b_r;
                if(~wr_en_b_i) begin
                    dbuf_b_r <= mem[addr_b_i];
                end
            end
        end
    end
end
else if(A_DWID > B_DWID) begin : A_GR_B
    /*
     *    WRITING AT PORT B
     */
    wire [A_AWID-1:0]          addr_b_eq_c;
    wire [B_AWID-(A_AWID+1):0] addr_b_exc_c;
    wire [A_DWID-1:0]          data_b_p_c;
    wire [A_DWID-1:0]          data_b_nxt_c;

    assign addr_b_eq_c  = addr_b_i[B_AWID-1:B_AWID-A_AWID];
    assign addr_b_exc_c = addr_b_i[B_AWID-(A_AWID+1):0];
    assign data_b_p_c   = mem[addr_b_eq_c];

    if(BYTE_EN_B == 0) begin : _BEN_B_DIS
        for(g0 = 0; g0 < 2**(B_AWID-A_AWID); g0 = g0 + 1) begin
            assign data_b_nxt_c [B_DWID*g0 +: B_DWID] = (addr_b_exc_c == g0) ? data_b_i : data_b_p_c[B_DWID*g0 +: B_DWID];
        end
    end
    else begin : _BEN_B_EN
        for(g0 = 0; g0 < 2**(B_AWID-A_AWID); g0 = g0 + 1) begin
            for(g1 = 0; g1 < B_BDWID; g1 = g1 + 1) begin
                assign data_b_nxt_c [(B_DWID*g0 + BEN_WID*g1) +: BEN_WID] = (addr_b_exc_c == g0 && ben_b_i[g0] == BENB_POL) ? data_b_i[g1*BEN_WID +: BEN_WID] : 
                                                                                                                              data_b_p_c[(B_DWID*g0 + BEN_WID*g1) +: BEN_WID];
            end
        end
    end

    always @ (posedge clk_b_i) begin
        if(clk_en_b_i & wr_en_b_i) begin
            mem[addr_b_eq_c] <= data_b_nxt_c;
        end
    end

    /*
     *    READING AT PORT B
     */
    wire [B_DWID-1:0] data_b_o_nxt_c;
    assign data_b_o_nxt_c = (addr_b_eq_c >= A_DEPTH) ? {B_DWID{(INIT_MODE == "all_one") ? 1'b1 : 1'b0}} : (data_b_p_c >> (B_DWID * addr_b_exc_c));

    if(REGMODE_B == "noreg") begin : _NREG_B
        always @ (posedge clk_b_i, posedge rst_b_c) begin
            if(rst_b_c) begin
                data_b_o <= {B_DWID{1'b0}};
            end
            else begin
                if(~wr_en_b_i & clk_en_b_i) begin
                    data_b_o <= data_b_o_nxt_c;
                end
            end
        end
    end
    else begin : _REG_B
        reg [B_DWID-1:0] dbuf_b_r;
        always @ (posedge clk_b_i, posedge rst_b_c) begin
            if(rst_b_c) begin
                dbuf_b_r <= {B_DWID{1'b0}};
                data_b_o <= {B_DWID{1'b0}};
            end
            else begin
                data_b_o <= dbuf_b_r;
                if(~wr_en_b_i) begin
                    dbuf_b_r <= data_b_o_nxt_c;
                end
            end
        end
    end

end
else begin : B_GR_A
    /*
     *    WRITING AT PORT B
     */
    wire [A_AWID-1:0] addr_b_eq_c;
    assign            addr_b_eq_c = {addr_b_i, {(A_AWID-B_AWID){1'b0}}};

    if(BYTE_EN_B == 0) begin : _BEN_B_DIS
        for(g0 = 0; g0 < B_DWID/A_DWID; g0 = g0 + 1) begin
            always @ (posedge clk_b_i) begin
                if(clk_en_b_i & wr_en_b_i) begin
                    mem[addr_b_eq_c + g0] <= data_b_i[g0*A_DWID +: A_DWID];
                end
            end
        end
    end
    else begin : _BEN_B_EN
        wire [B_DWID-1:0] data_b_nxt_c;
        wire [B_DWID-1:0] data_b_p_c;
        for(g0 = 0; g0 < B_BDWID; g0 = g0 + 1) begin
            assign data_b_nxt_c = (ben_b_i[g0] == BENB_POL) ? data_b_i[g0 * BEN_WID +: BEN_WID] : data_b_p_c [g0 * BEN_WID +: BEN_WID];
        end
        for(g0 = 0; g0 < B_DWID/A_DWID; g0 = g0 + 1) begin
            assign data_b_p_c[g0*A_DWID +: A_DWID] = mem[addr_b_eq_c + g0];
            always @ (posedge clk_b_i) begin
                if(clk_en_b_i & wr_en_b_i) begin
                    mem[addr_b_eq_c + g0] <= data_b_nxt_c[g0*A_DWID +: A_DWID];
                end
            end
        end
    end
    /*
     *    READING AT PORT B
     */
    wire [B_DWID-1:0] data_b_o_nxt_c;
    for(g0 = 0; g0 < B_DWID/A_DWID; g0 = g0 + 1) begin
        assign data_b_o_nxt_c [g0*A_DWID +: A_DWID] = mem[addr_b_eq_c + g0];
    end

    if(REGMODE_B == "noreg") begin : _NREG_B
        always @ (posedge clk_b_i, posedge rst_b_c) begin
            if(rst_b_c) begin
                data_b_o <= {B_DWID{1'b0}};
            end
            else begin
                if(~wr_en_b_i & clk_en_b_i) begin
                    data_b_o <= data_b_o_nxt_c;
                end
            end
        end
    end
    else begin : _REG_B
        reg [B_DWID-1:0] dbuf_b_r;
        always @ (posedge clk_b_i, posedge rst_b_c) begin
            if(rst_b_c) begin
                dbuf_b_r <= {B_DWID{1'b0}};
                data_b_o <= {B_DWID{1'b0}};
            end
            else begin
                data_b_o <= dbuf_b_r;
                if(~wr_en_b_i) begin
                    dbuf_b_r <= data_b_o_nxt_c;
                end
            end
        end
    end
end

function [31:0] roundUP;
    input [31:0] dividend;
    input [31:0] divisor;
    begin
        if(divisor == 1) begin
            roundUP = dividend;
        end
        else if(divisor == dividend) begin
            roundUP = 1;
        end
        else begin
            roundUP = dividend/divisor + (((dividend % divisor) == 0) ? 0 : 1);
        end
    end
endfunction

function [31:0] clog2;
    input [31:0] value;
    reg   [31:0] num;
    begin
        num = value - 1;
        for (clog2=0; num>0; clog2=clog2+1) num = num>>1;
    end
endfunction

endmodule
`endif