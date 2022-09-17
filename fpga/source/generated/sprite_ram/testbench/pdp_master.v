`ifndef PDP_MASTER
`define PDP_MASTER

module pdp_master # (
    parameter    WADDR_DEPTH        = 1024,
    parameter    WADDR_WIDTH        = clog2(WADDR_DEPTH),
    parameter    WDATA_WIDTH        = 18,
    parameter    RADDR_DEPTH        = 1024,
    parameter    RADDR_WIDTH        = clog2(RADDR_DEPTH),
    parameter    RDATA_WIDTH        = 18,
    parameter    REGMODE            = "reg",
    parameter    RESETMODE          = "sync",
    parameter    INIT_FILE          = "none",
    parameter    INIT_FILE_FORMAT   = "binary",
    parameter    INIT_MODE          = "none",
    parameter    BYTE_ENABLE        = 1,
    parameter    BYTE_SIZE          = 9,
    parameter    BYTE_WIDTH         = WDATA_WIDTH/BYTE_SIZE,
    parameter    ECC_ENABLE         = 0,
    parameter    OUTPUT_CLK_EN      = 0,
    parameter    BYTE_ENABLE_POL    = "active-high"
)(
    input                        wr_clk_i,       
    input                        rd_clk_i,       
    input                        rst_i,    
			                     
    output reg                   wr_clk_en_o,       
    output reg                   rd_clk_en_o,       
    output reg                   rd_out_clk_en_o,       
                                                                          
    output reg                   wr_en_o,       
    output reg [WDATA_WIDTH-1:0] wr_data_o,       
    output reg [WADDR_WIDTH-1:0] wr_addr_o,       
    output reg                   rd_en_o,       
    output reg [RADDR_WIDTH-1:0] rd_addr_o,       
    output reg [BYTE_WIDTH-1:0]  ben_o,       
                                                            
    input [RDATA_WIDTH-1:0]      rd_data_dut_i,
    input [RDATA_WIDTH-1:0]      rd_data_ref_i,
    input                        one_err_det_i,
    input                        two_err_det_i
);

genvar g0;
integer i0, i1;

reg [WADDR_WIDTH-1:0] waddr_rand_r;
reg [RADDR_WIDTH-1:0] raddr_rand_r;

wire [WADDR_WIDTH-1:0] waddr_rand_nxt_c;
wire [RADDR_WIDTH-1:0] raddr_rand_nxt_c;

reg [1023:0] rdat0;
reg [1023:0] rdat1;
reg [1023:0] rdat2;

reg rd_valid_r;
reg chk_r;

assign waddr_rand_nxt_c = (rdat0[WADDR_WIDTH-1:0] > WADDR_DEPTH) ? (rdat0[WADDR_WIDTH-1:0] - WADDR_DEPTH): rdat0[WADDR_WIDTH-1:0];
assign raddr_rand_nxt_c = (rdat2[RADDR_WIDTH-1:0] > RADDR_DEPTH) ? (rdat2[RADDR_WIDTH-1:0] - RADDR_DEPTH): rdat2[RADDR_WIDTH-1:0];

for (g0 = 0; g0 < 32; g0 = g0 + 1) begin
    always @ (posedge wr_clk_i) begin
        rdat0[g0*32 +: 32] <= $urandom_range({32{1'b0}}, {32{1'b1}});
        rdat1[g0*32 +: 32] <= $urandom_range({32{1'b0}}, {32{1'b1}});
    end
    always @ (posedge rd_clk_i) begin
        rdat2[g0*32 +: 32] <= $urandom_range({32{1'b0}}, {32{1'b1}});
    end
end

initial begin
    wr_clk_en_o     <= 1'b0;
    rd_clk_en_o     <= 1'b0;
    rd_out_clk_en_o <= 1'b0;
    wr_en_o         <= 1'b0;       
    wr_data_o       <= {WDATA_WIDTH{1'b0}};
    wr_addr_o       <= {WADDR_WIDTH{1'b0}};
    rd_en_o         <= 1'b0;       
    rd_addr_o       <= {RADDR_WIDTH{1'b0}};       
    ben_o           <= {BYTE_WIDTH{1'b0}};
    waddr_rand_r    <= {WADDR_WIDTH{1'b0}};
    raddr_rand_r    <= {RADDR_WIDTH{1'b0}};
    rdat0           <= {1024{1'b0}};
    rdat1           <= {1024{1'b0}};
    rdat2           <= {1024{1'b0}};
    chk_r           <= 1'b1;
    $timeformat(-9, 2, " ns", 20);
end

initial begin
    @(posedge rst_i);
    @(posedge wr_clk_i);
    wr_clk_en_o     <= 1'b1;
    @(posedge wr_clk_i);
    @(posedge rd_clk_i);
    rd_clk_en_o     <= 1'b1;
    @(posedge rd_clk_i);
    rd_out_clk_en_o <= 1'b1;
    $display("-----------------------------------------------------");
    $display("----------- Pseudo-Dual Port Memory Test ------------");
    if(INIT_MODE == "mem_file") begin
        $display("------------- Start Initialization Test -------------");
        rd_en_o <= 1'b1;
        for(i0 = 0; i0 < RADDR_DEPTH; i0 = i0 + 1) begin
            read_data(i0);
        end
        rd_en_o <= 1'b0;
    end
    @(posedge rd_clk_i);
    $display("------------- Start Random Access Test --------------");
    fork
        begin
            for(i0 = 0; i0 < 2*WADDR_DEPTH; i0 = i0 + 1) begin
                write_data(waddr_rand_nxt_c, rdat1[WDATA_WIDTH-1:0], rdat1[BYTE_WIDTH-1:0]);
                random_write_enable();
            end
            wr_en_o <= 1'b0;
        end
        begin
            for(i1 = 0; i1 < 2*RADDR_DEPTH; i1 = i1 + 1) begin
                read_data(raddr_rand_nxt_c);
                random_read_enable();
            end
            rd_en_o <= 1'b0;
        end
    join
    @(posedge wr_clk_i);
    @(posedge rd_clk_i);
    @(posedge wr_clk_i);
    $display("-------------- Start Memory Sweep Test --------------");
    wr_en_o <= 1'b1;
    for(i0 = 0; i0 < WADDR_DEPTH; i0 = i0 + 1) begin
        write_data(i0, rdat1[WDATA_WIDTH-1:0], rdat1[BYTE_WIDTH-1:0]);
    end
    wr_en_o <= 1'b0;
    @(posedge wr_clk_i);
    @(posedge rd_clk_i);
    rd_en_o <= 1'b1;
    for(i0 = 0; i0 < RADDR_DEPTH; i0 = i0 + 1) begin
        read_data(i0);
    end
    rd_en_o <= 1'b0;
    @(posedge rd_clk_i);
    @(posedge rd_clk_i);
    @(posedge rd_clk_i);
    @(posedge rd_clk_i);
    @(posedge rd_clk_i);
    if(chk_r) begin
        $display("-----------------------------------------------------");
        $display("----------------- SIMULATION PASSED -----------------");
        $display("-----------------------------------------------------");
    end
    else begin
        $display("-----------------------------------------------------");
        $display("!!!!!!!!!!!!!!!!! SIMULATION FAILED !!!!!!!!!!!!!!!!!");
        $display("-----------------------------------------------------");
    end
    $display("Total Simulation Time : %t", $time);
    $finish;
end

if(REGMODE == "reg") begin : _REG_CHECK
    reg del1;
    always @ (posedge rd_clk_i, posedge rst_i) begin
        if(rst_i) begin
            del1       <= 1'b0;
            rd_valid_r <= 1'b0;
        end
        else begin
            del1       <= rd_en_o;
            rd_valid_r <= del1;
        end
    end
end
else begin : _NREG_CHECK
    always @ (posedge rd_clk_i, posedge rst_i) begin
        if(rst_i) begin
            rd_valid_r <= 1'b0;
        end
        else begin
            rd_valid_r <= rd_en_o;
        end
    end
end

always @ (posedge rd_clk_i) begin
    if(rd_valid_r) begin
        if(rd_data_dut_i != rd_data_ref_i) begin
            $display("!! Error Occurred at : %t", $time);
            chk_r <= 1'b0;
        end
    end
end

task write_data;
    input [WADDR_WIDTH-1:0] wtb_addr_i;
    input [WDATA_WIDTH-1:0] wtb_data_i;
    input [BYTE_WIDTH-1:0]  wtb_byte_i;
    begin
        wr_addr_o <= wtb_addr_i;
        wr_data_o <= wtb_data_i;
        ben_o     <= wtb_byte_i;
        @(posedge wr_clk_i);
    end
endtask

task random_write_enable;
    begin
       wr_en_o <= $urandom_range({1'b0}, {1'b1});
       @(posedge wr_clk_i);
    end
endtask

task read_data;
    input [RADDR_WIDTH-1:0] rtb_addr_i;
    begin
        rd_addr_o <= rtb_addr_i;
        @(posedge rd_clk_i);
    end
endtask

task random_read_enable;
    begin
       rd_en_o <= $urandom_range({1'b0}, {1'b1});
       @(posedge rd_clk_i);
    end
endtask

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