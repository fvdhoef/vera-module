// =============================================================================
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// -----------------------------------------------------------------------------
//   Copyright (c) 2018 by Lattice Semiconductor Corporation
//   ALL RIGHTS RESERVED
// --------------------------------------------------------------------
//
//   Permission:
//
//      Lattice SG Pte. Ltd. grants permission to use this code
//      pursuant to the terms of the Lattice Reference Design License Agreement.
//
//
//   Disclaimer:
//
//      This VHDL or Verilog source code is intended as a design reference
//      which illustrates how these types of functions can be implemented.
//      It is the user's responsibility to verify their design for
//      consistency and functionality through the use of formal
//      verification methods.  Lattice provides no warranty
//      regarding the use or functionality of this code.
//
// -----------------------------------------------------------------------------
//
//                  Lattice SG Pte. Ltd.
//                  101 Thomson Road, United Square #07-02
//                  Singapore 307591
//
//
//                  TEL: 1-800-Lattice (USA and Canada)
//                       +65-6631-2000 (Singapore)
//                       +1-503-268-8001 (other locations)
//
//                  web: http://www.latticesemi.com/
//                  email: techsupport@latticesemi.com
//
// -----------------------------------------------------------------------------
//
// =============================================================================
//                         FILE DETAILS
// Project               :
// File                  : tb_top.v
// Title                 : Testbench for ram_dp.
// Dependencies          : 1.
//                       : 2.
// Description           :
// =============================================================================
//                        REVISION HISTORY
// Version               : 1.0.1
// Author(s)             :
// Mod. Date             : 03/05/2018
// Changes Made          : Initial version of testbench for ram_dp
// =============================================================================

`ifndef TB_TOP
`define TB_TOP

//==========================================================================
// Module : tb_top
//==========================================================================

`timescale 1ns/1ns

module tb_top();

`include "dut_params.v"

localparam CLK_FREQ = (FAMILY == "iCE40UP") ? 40 : 10;
localparam RESET_CNT = (FAMILY == "iCE40UP") ? 140 : 35;

reg                         chk_init = 1'b1;
reg                         chk_norm = 1'b1;

reg                         wr_clk_i;
reg                         rd_clk_i;
reg                         rst_i;
reg                         wr_clk_en_i;
reg                         rd_clk_en_i;

reg                         rd_out_clk_en_i;

reg                         wr_en_i;
reg [WDATA_WIDTH-1:0]       wr_data_i;
reg [WADDR_WIDTH-1:0]       wr_addr_i;
reg                         rd_en_i;
reg [RADDR_WIDTH-1:0]       rd_addr_i;
reg [BYTE_WIDTH-1:0]        ben_i;

wire [RDATA_WIDTH-1:0] 	    rd_data_o;

reg [255:0]                 data_in = {256{1'b0}};

`ifdef LIFCL
    // ----------------------------
    // LIFCL GSR instance
    // ----------------------------
    reg CLK_GSR = 0;
    reg USER_GSR = 1;
    wire GSROUT;
    
    initial begin
        forever begin
            #5;
            CLK_GSR = ~CLK_GSR;
        end
    end
    
    GSR GSR_INST (
        .GSR_N(USER_GSR),
        .CLK(CLK_GSR)
    );
`endif

`include "dut_inst.v"

genvar din0;
begin : data_generate
    for(din0 = 0; din0 < 8; din0 = din0 + 1) begin
        always @ (posedge wr_clk_i) begin
            data_in[din0*32+31:din0*32] <= $urandom_range({32{1'b0}}, {32{1'b1}});
        end
    end
end

initial begin
	wr_clk_en_i <= 1'b1;
	rd_clk_en_i <= 1'b1;
	rd_out_clk_en_i <= 1'b1;
	wr_en_i <= 1'b0;
	rd_en_i <= 1'b0;
	ben_i <= {BYTE_WIDTH{1'b1}};
	wr_addr_i <= 'h0;
	rd_addr_i <= 'h0;
    wr_data_i <= data_in[WDATA_WIDTH-1:0];
end

initial begin
	wr_clk_i = 1'b0;
	forever #CLK_FREQ wr_clk_i = ~wr_clk_i;
end

initial begin
	rd_clk_i = 1'b0;
	forever #CLK_FREQ rd_clk_i = ~rd_clk_i;
end

initial begin
	rst_i = 1'b1;
	#RESET_CNT;
	rst_i = 1'b0;
end

localparam INIT_EN      = (INIT_MODE == "none") ? 0 : 1;
localparam WRITE_EN     = 1;
localparam READ_EN      = 1;
localparam TARGET_WRITE = WADDR_DEPTH;
localparam TARGET_READ = RADDR_DEPTH;

localparam [1:0] SM_IDLE       = 2'b00;
localparam [1:0] SM_INIT_MODE  = 2'b01;
localparam [1:0] SM_WRITE_MODE = 2'b10;
localparam [1:0] SM_READ_MODE  = 2'b11;

reg [1:0] current_state;
reg [1:0] prev_state = SM_IDLE;
reg [1:0] prev2_state = SM_IDLE;

always @ (posedge rd_clk_i) begin
    prev_state <= current_state;
    prev2_state <= prev_state;
end

integer i0, i1;
initial begin
    current_state <= (INIT_EN == 1) ? SM_INIT_MODE : SM_WRITE_MODE;
	@(negedge rst_i);
    @(posedge wr_clk_i);
    if(current_state == SM_INIT_MODE) begin
        rd_addr_i <= 'h0;
        rd_en_i <= 1'b1;
	    for(i1 = 0; i1 < TARGET_READ; i1 = i1 + 1) begin
            @(posedge rd_clk_i);
            rd_addr_i <= rd_addr_i + 1;
	    end
        current_state <= SM_WRITE_MODE;
        @(posedge rd_clk_i);
        if(REGMODE == "noreg") @(posedge rd_clk_i);
        rd_en_i <= 1'b0;
        if(chk_init == 1'b1) begin
            $display("-----------------------------------------------------");
            $display("------------ MEMORY INITIALIZATION PASSED -----------");
            $display("-----------------------------------------------------");
        end
        else begin
            $display("-----------------------------------------------------");
            $display("!!!!!!!!!!!! MEMORY INITIALIZATION FAILED !!!!!!!!!!!");
            $display("-----------------------------------------------------");
        end
    end
    if(current_state == SM_WRITE_MODE) begin
        wr_addr_i <= 'h0;
        wr_data_i <= data_in[WDATA_WIDTH-1:0];
        wr_en_i <= 1'b1;
        for(i1 = 0; i1 < TARGET_WRITE; i1 = i1 + 1) begin
            @(posedge wr_clk_i);
            wr_addr_i <= wr_addr_i + 1'b1;
            wr_data_i <= data_in[WDATA_WIDTH-1:0];
            if(BYTE_ENABLE == 1) begin
                ben_i <= (ben_i == {BYTE_WIDTH{1'b1}}) ?  {{(BYTE_WIDTH-1){1'b0}}, 1'b1} :
                         (ben_i == {BYTE_WIDTH{1'b0}}) ?  {BYTE_WIDTH{1'b1}} : (ben_i << 1);   
            end      
        end
        wr_en_i <= 1'b0;
        current_state <= SM_READ_MODE;
        @(posedge wr_clk_i);
    end
    if(current_state == SM_READ_MODE) begin
        rd_addr_i <= 'h0;
        rd_en_i <= 1'b1;
	    for(i1 = 0; i1 < TARGET_READ; i1 = i1 + 1) begin
            @(posedge rd_clk_i);
            rd_addr_i <= rd_addr_i + 1;
	    end
        @(posedge rd_clk_i);
        current_state <= SM_IDLE;
        if(REGMODE == "reg") @(posedge rd_clk_i);    
    end
    if(chk_norm == 1'b1) begin
        $display("-----------------------------------------------------");
        $display("----------------- SIMULATION PASSED -----------------");
        $display("-----------------------------------------------------");
    end
    else begin
        $display("-----------------------------------------------------");
        $display("!!!!!!!!!!!!!!!!! SIMULATION FAILED !!!!!!!!!!!!!!!!!");
        $display("-----------------------------------------------------");
    end
    $finish;
end

genvar i_1;
integer mem_i0;
if (INIT_EN == 1) begin : INIT_MODE_CHECKER
    reg [WDATA_WIDTH-1:0] mem_init [2**WADDR_WIDTH-1:0];
    initial begin
        if (INIT_MODE == "mem_file") begin
          if (INIT_FILE_FORMAT == "hex") begin
            $readmemh(INIT_FILE, mem_init, 0, WADDR_DEPTH-1);
          end
          else begin
            $readmemb(INIT_FILE, mem_init, 0, WADDR_DEPTH-1);
          end
        end
        else begin
            for(mem_i0 = 0; mem_i0 < WADDR_DEPTH; mem_i0 = mem_i0 + 1) begin
                mem_init[mem_i0] = (INIT_MODE == "all_one") ? {WDATA_WIDTH{1'b1}} : {WDATA_WIDTH{1'b0}};
            end
        end
    end
    
    localparam Q_WOR = WDATA_WIDTH/RDATA_WIDTH;
    localparam Q_ROW = RDATA_WIDTH/WDATA_WIDTH;

    wire [1:0] state_check = (REGMODE == "noreg") ? prev_state : prev2_state;

    if(WDATA_WIDTH == RDATA_WIDTH) begin : W_EQ_R
        wire [WADDR_WIDTH-1:0] rd_addr_chk_w = rd_addr_i;
        reg [WADDR_WIDTH-1:0] rd_addr_p = {WADDR_WIDTH{1'b0}};
        reg rd_en_p_r = 1'b0;
        wire [WDATA_WIDTH-1:0] sel_mem = (INIT_MODE == "mem_file") ? mem_init[rd_addr_p] :
                                         (INIT_MODE == "all_one") ? {WDATA_WIDTH{1'b1}} : {WDATA_WIDTH{1'b0}};
        
        if(REGMODE == "noreg") begin
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_chk_w;
                rd_en_p_r <= rd_en_i;
            end
        end
        else begin
            reg [WADDR_WIDTH-1:0] rd_addr_p2 = {WADDR_WIDTH{1'b0}};
            reg rd_en_p2_r = 1'b0; 
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_p2;
                rd_en_p_r <= rd_en_p2_r;
                rd_addr_p2 <= rd_addr_chk_w;
                rd_en_p2_r <= rd_en_i;
            end
        end

        always @ (posedge rd_clk_i) begin
            if(rd_en_p_r & state_check == SM_INIT_MODE) begin
                if(sel_mem != rd_data_o) begin
                    $display("Expected DATA = %h, Read DATA = %h", sel_mem, rd_data_o);
                    chk_init = 1'b0;
                end
            end
        end           
    end
    else if(WDATA_WIDTH > RDATA_WIDTH) begin : W_G_R
        wire [WADDR_WIDTH-1:0] rd_addr_chk_w = rd_addr_i[RADDR_WIDTH-1:RADDR_WIDTH-WADDR_WIDTH];
        wire [RADDR_WIDTH-(WADDR_WIDTH+1):0] rd_addr_sel_w = rd_addr_i[RADDR_WIDTH-(WADDR_WIDTH+1):0];
        reg [WADDR_WIDTH-1:0] rd_addr_p = {WADDR_WIDTH{1'b0}};
        reg [RADDR_WIDTH-(WADDR_WIDTH+1):0] rd_addr_sel_r = {(RADDR_WIDTH-WADDR_WIDTH){1'b0}};
        reg rd_en_p_r = 1'b0;
        wire [WDATA_WIDTH-1:0] sel_mem = (INIT_MODE == "mem_file") ? mem_init[rd_addr_p] :
                                         (INIT_MODE == "all_one") ? {WDATA_WIDTH{1'b1}} : {WDATA_WIDTH{1'b0}};
        wire [RDATA_WIDTH-1:0] cmp_mem = sel_mem >> (RDATA_WIDTH*rd_addr_sel_r);
    
        if(REGMODE == "noreg") begin
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_chk_w;
                rd_addr_sel_r <= rd_addr_sel_w;
                rd_en_p_r <= rd_en_i;
            end
        end
        else begin
            reg [WADDR_WIDTH-1:0] rd_addr_p2 = {WADDR_WIDTH{1'b0}};
            reg [RADDR_WIDTH-(WADDR_WIDTH+1):0] rd_addr_sel2_r = {(RADDR_WIDTH-WADDR_WIDTH){1'b0}};
            reg rd_en_p2_r = 1'b0;
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_p2;
                rd_addr_sel_r <= rd_addr_sel2_r;
                rd_en_p_r <= rd_en_p2_r;
                rd_addr_p2 <= rd_addr_chk_w;
                rd_addr_sel2_r <= rd_addr_sel_w;
                rd_en_p2_r <= rd_en_i;
            end
        end
        always @ (posedge rd_clk_i) begin 
            if(rd_en_p_r & state_check == SM_INIT_MODE) begin
                if(cmp_mem != rd_data_o) begin
                    $display("Expected DATA = %h, Read DATA = %h", cmp_mem, rd_data_o);
                    chk_init = 1'b0;
                end
            end
        end
    end
    else begin : W_L_R
        wire [WADDR_WIDTH-1:0] rd_addr_chk_w;
        assign rd_addr_chk_w [WADDR_WIDTH-1:WADDR_WIDTH-RADDR_WIDTH] = rd_addr_i;
        assign rd_addr_chk_w [(WADDR_WIDTH-RADDR_WIDTH)-1:0] = {(WADDR_WIDTH-RADDR_WIDTH){1'b0}};
        reg [WADDR_WIDTH-1:0] rd_addr_p = {WADDR_WIDTH{1'b0}};
        reg rd_en_p_r;
        wire [RDATA_WIDTH-1:0] cmp_mem;
        for(i_1 = 0; i_1 < Q_ROW; i_1 = i_1 + 1) begin
            wire [WDATA_WIDTH-1:0] tmem_read = (INIT_MODE == "mem_file") ? mem_init[rd_addr_p + i_1] :
                                               (INIT_MODE == "all_one") ? {WDATA_WIDTH{1'b1}} : {WDATA_WIDTH{1'b0}};
            assign cmp_mem[i_1*WDATA_WIDTH+WDATA_WIDTH-1:i_1*WDATA_WIDTH] = tmem_read;
        end
        if(REGMODE == "noreg") begin
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_chk_w;
                rd_en_p_r <= rd_en_i;
            end
        end
        else begin
            reg [WADDR_WIDTH-1:0] rd_addr_p2 = {WADDR_WIDTH{1'b0}}; 
            reg rd_en_p2_r = 1'b0;
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_p2;
                rd_en_p_r <= rd_en_p2_r;
                rd_addr_p2 <= rd_addr_chk_w;
                rd_en_p2_r <= rd_en_i;
            end
        end
        always @ (posedge rd_clk_i) begin
            if(rd_en_p_r & state_check == SM_INIT_MODE) begin
                if(cmp_mem != rd_data_o) begin
                    $display("Expected DATA = %h, Read DATA = %h", cmp_mem, rd_data_o);
                    chk_init = 1'b0;
                end
            end
        end
    end
end

genvar ben0;
integer mem_normi0;
begin : MEM_NORMAL_OPERATION
    reg [WDATA_WIDTH-1:0] mem_norm [2**WADDR_WIDTH-1:0];
    reg [BYTE_WIDTH-1:0] byte_en_rec [2**WADDR_WIDTH-1:0];

    initial begin
        if (INIT_MODE == "mem_file" && INIT_FILE != "none") begin
          if (INIT_FILE_FORMAT == "hex") begin
            $readmemh(INIT_FILE, mem_norm, 0, WADDR_DEPTH-1);
          end
          else begin
            $readmemb(INIT_FILE, mem_norm, 0, WADDR_DEPTH-1);
          end
        end
        else begin
            for(mem_normi0 = 0; mem_normi0 < 2**WADDR_WIDTH; mem_normi0 = mem_normi0 + 1) begin
                mem_norm[mem_normi0] = (INIT_MODE == "all_one") ? {WDATA_WIDTH{1'b1}} : {WDATA_WIDTH{1'b0}};
            end
        end
    end

    if(BYTE_ENABLE == 0) begin
        always @ (posedge wr_clk_i) begin
            if(current_state == SM_WRITE_MODE & wr_en_i) begin
                mem_norm[wr_addr_i] <= wr_data_i;
            end
        end
    end
    else begin
        localparam BYTE_SIZE = (WDATA_WIDTH % 9 == 0) ? 9 : 8;
        localparam EQUIV_LEN = (WDATA_WIDTH/BYTE_SIZE);
        wire [BYTE_SIZE-1:0] act_wr_data [EQUIV_LEN-1:0];
        wire [WDATA_WIDTH-1:0] pref_data = mem_norm[wr_addr_i];
        for(ben0 = 0; ben0 < EQUIV_LEN; ben0 = ben0 + 1) begin
            assign act_wr_data [ben0] = (ben_i[ben0] == 1'b1) ? (wr_data_i[ben0*BYTE_SIZE+BYTE_SIZE-1:ben0*BYTE_SIZE]) : 
                                                                (pref_data[ben0*BYTE_SIZE+BYTE_SIZE-1:ben0*BYTE_SIZE]);
        end
        wire [WDATA_WIDTH-1:0] wr_data_t_w;
        for(ben0 = 0; ben0 < EQUIV_LEN; ben0 = ben0 + 1) begin
            assign wr_data_t_w[ben0*BYTE_SIZE+BYTE_SIZE-1:ben0*BYTE_SIZE] = act_wr_data[ben0];
        end
        always @ (posedge wr_clk_i) begin
            if(current_state == SM_WRITE_MODE & wr_en_i) begin
                mem_norm[wr_addr_i] <= wr_data_t_w;
            end
        end
    end
    
    localparam Q_WOR = WDATA_WIDTH/RDATA_WIDTH;
    localparam Q_ROW = RDATA_WIDTH/WDATA_WIDTH;

    wire [1:0] state_check = (REGMODE == "noreg") ? prev_state : prev2_state;

    if(WDATA_WIDTH == RDATA_WIDTH) begin : W_EQ_R
        wire [WADDR_WIDTH-1:0] rd_addr_chk_w = rd_addr_i;
        reg [WADDR_WIDTH-1:0] rd_addr_p = {WADDR_WIDTH{1'b0}};
        reg rd_en_p_r = 1'b0;
        wire [WDATA_WIDTH-1:0] sel_mem = mem_norm[rd_addr_p];
        
        if(REGMODE == "noreg") begin
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_chk_w;
                rd_en_p_r <= rd_en_i;
            end
        end
        else begin
            reg [WADDR_WIDTH-1:0] rd_addr_p2 = {WADDR_WIDTH{1'b0}};
            reg rd_en_p2_r = 1'b0; 
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_p2;
                rd_en_p_r <= rd_en_p2_r;
                rd_addr_p2 <= rd_addr_chk_w;
                rd_en_p2_r <= rd_en_i;
            end
        end

        always @ (posedge rd_clk_i) begin
            if(rd_en_p_r & state_check == SM_READ_MODE) begin
                if(sel_mem != rd_data_o) begin
                    $display("Expected DATA = %h, Read DATA = %h", sel_mem, rd_data_o);
                    chk_norm = 1'b0;
                end
            end
        end           
    end
    else if(WDATA_WIDTH > RDATA_WIDTH) begin : W_G_R
        wire [WADDR_WIDTH-1:0] rd_addr_chk_w = rd_addr_i[RADDR_WIDTH-1:RADDR_WIDTH-WADDR_WIDTH];
        wire [RADDR_WIDTH-(WADDR_WIDTH+1):0] rd_addr_sel_w = rd_addr_i[RADDR_WIDTH-(WADDR_WIDTH+1):0];
        reg [WADDR_WIDTH-1:0] rd_addr_p = {WADDR_WIDTH{1'b0}};
        reg [RADDR_WIDTH-(WADDR_WIDTH+1):0] rd_addr_sel_r = {(RADDR_WIDTH-WADDR_WIDTH){1'b0}};
        reg rd_en_p_r = 1'b0;
        wire [WDATA_WIDTH-1:0] sel_mem = mem_norm[rd_addr_p];
        wire [RDATA_WIDTH-1:0] cmp_mem = sel_mem >> (RDATA_WIDTH*rd_addr_sel_r);
    
        if(REGMODE == "noreg") begin
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_chk_w;
                rd_addr_sel_r <= rd_addr_sel_w;
                rd_en_p_r <= rd_en_i;
            end
        end
        else begin
            reg [WADDR_WIDTH-1:0] rd_addr_p2 = {WADDR_WIDTH{1'b0}};
            reg [RADDR_WIDTH-(WADDR_WIDTH+1):0] rd_addr_sel2_r = {(RADDR_WIDTH-WADDR_WIDTH){1'b0}};
            reg rd_en_p2_r = 1'b0;
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_p2;
                rd_addr_sel_r <= rd_addr_sel2_r;
                rd_en_p_r <= rd_en_p2_r;
                rd_addr_p2 <= rd_addr_chk_w;
                rd_addr_sel2_r <= rd_addr_sel_w;
                rd_en_p2_r <= rd_en_i;
            end
        end
        always @ (posedge rd_clk_i) begin 
            if(rd_en_p_r & state_check == SM_READ_MODE) begin
                if(cmp_mem != rd_data_o) begin
                    $display("Expected DATA = %h, Read DATA = %h", cmp_mem, rd_data_o);
                    chk_norm = 1'b0;
                end
            end
        end
    end
    else begin : W_L_R
        wire [WADDR_WIDTH-1:0] rd_addr_chk_w;
        assign rd_addr_chk_w [WADDR_WIDTH-1:WADDR_WIDTH-RADDR_WIDTH] = rd_addr_i;
        assign rd_addr_chk_w [(WADDR_WIDTH-RADDR_WIDTH)-1:0] = {(WADDR_WIDTH-RADDR_WIDTH){1'b0}};
        reg [WADDR_WIDTH-1:0] rd_addr_p = {WADDR_WIDTH{1'b0}};
        reg rd_en_p_r;
        wire [RDATA_WIDTH-1:0] cmp_mem;
        for(i_1 = 0; i_1 < Q_ROW; i_1 = i_1 + 1) begin
            wire [WDATA_WIDTH-1:0] tmem_read = mem_norm[rd_addr_p + i_1];
            assign cmp_mem[i_1*WDATA_WIDTH+WDATA_WIDTH-1:i_1*WDATA_WIDTH] = tmem_read;
        end
        if(REGMODE == "noreg") begin
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_chk_w;
                rd_en_p_r <= rd_en_i;
            end
        end
        else begin
            reg [WADDR_WIDTH-1:0] rd_addr_p2 = {WADDR_WIDTH{1'b0}}; 
            reg rd_en_p2_r = 1'b0;
            always @ (posedge rd_clk_i) begin
                rd_addr_p <= rd_addr_p2;
                rd_en_p_r <= rd_en_p2_r;
                rd_addr_p2 <= rd_addr_chk_w;
                rd_en_p2_r <= rd_en_i;
            end
        end
        always @ (posedge rd_clk_i) begin
            if(rd_en_p_r & state_check == SM_READ_MODE) begin
                if(cmp_mem != rd_data_o) begin
                    $display("Expected DATA = %h, Read DATA = %h", cmp_mem, rd_data_o);
                    chk_norm = 1'b0;
                end
            end
        end
    end
end

endmodule
`endif
