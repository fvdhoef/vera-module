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

`include "mem_model.v"
`include "pdp_master.v"
`include "clk_rst_gen.v"

`ifndef TB_TOP
`define TB_TOP

//==========================================================================
// Module : tb_top
//==========================================================================

`timescale 1ns/1ns

module tb_top();

`include "dut_params.v"

localparam CLK_FREQ   = (FAMILY == "iCE40UP") ? 40 : 10;
localparam RESET_CNT  = (FAMILY == "iCE40UP") ? 140 : 35;
localparam DIFF_CLOCK = 1;

wire                    wr_clk_i;                 
wire                    rd_clk_i;                 
wire                    rst_i;                    
wire                    wr_clk_en_i;              
wire                    rd_clk_en_i;              
wire                    rd_out_clk_en_i;          
                                                    
wire                    wr_en_i;                  
wire [WDATA_WIDTH-1:0]  wr_data_i;                
wire [WADDR_WIDTH-1:0]  wr_addr_i;                
wire                    rd_en_i;                  
wire [RADDR_WIDTH-1:0]  rd_addr_i;                
wire [BYTE_WIDTH-1:0]   ben_i;                    
                                                    
wire [RDATA_WIDTH-1:0]  rd_data_o;
wire                    one_err_det_o;
wire                    two_err_det_o;

wire [RDATA_WIDTH-1:0]  rd_data_ref;

// ----------------------------
// GSR instance
// ----------------------------
`ifndef iCE40UP
    GSR GSR_INST ( .GSR_N(1'b1), .CLK(1'b0));
`endif

`include "dut_inst.v"

pdp_master # (
    .WADDR_DEPTH      (WADDR_DEPTH     ),
    .WADDR_WIDTH      (WADDR_WIDTH     ),
    .WDATA_WIDTH      (WDATA_WIDTH     ),
    .RADDR_DEPTH      (RADDR_DEPTH     ),
    .RADDR_WIDTH      (RADDR_WIDTH     ),
    .RDATA_WIDTH      (RDATA_WIDTH     ),
    .REGMODE          (REGMODE         ),
    .RESETMODE        (RESETMODE       ),
    .INIT_FILE        (INIT_FILE       ),
    .INIT_FILE_FORMAT (INIT_FILE_FORMAT),
    .INIT_MODE        (INIT_MODE       ),
    .BYTE_ENABLE      (BYTE_ENABLE     ),
    .BYTE_SIZE        (BYTE_SIZE       ),
    .BYTE_WIDTH       (BYTE_WIDTH      ),
    .ECC_ENABLE       (ECC_ENABLE      ),
    .OUTPUT_CLK_EN    (OUTPUT_CLK_EN   )
) pdp_ctrl (
    .wr_clk_i         (wr_clk_i),       
    .rd_clk_i         (rd_clk_i),       
    .rst_i            (rst_i),       
    .wr_clk_en_o      (wr_clk_en_i),       
    .rd_clk_en_o      (rd_clk_en_i),       
    .rd_out_clk_en_o  (rd_out_clk_en_i),       
                                                            
    .wr_en_o          (wr_en_i),       
    .wr_data_o        (wr_data_i),       
    .wr_addr_o        (wr_addr_i),       
    .rd_en_o          (rd_en_i),       
    .rd_addr_o        (rd_addr_i),       
    .ben_o            (ben_i),       
                                                            
    .rd_data_dut_i    (rd_data_o),
    .rd_data_ref_i    (rd_data_ref),
    .one_err_det_i    (one_err_det_o),
    .two_err_det_i    (two_err_det_o)
);

clk_rst_gen # (
    .CLK_FREQ   (CLK_FREQ  ),
    .RESET_CNT  (RESET_CNT ),
    .DIFF_CLOCK (DIFF_CLOCK)
) clk_gen (
    .clk1       (wr_clk_i),
    .clk2       (rd_clk_i),
    .rst        (rst_i)
);

mem_model # (
    .FAMILY      (FAMILY),
    .A_DEPTH     (WADDR_DEPTH),
    .A_AWID      (WADDR_WIDTH),
    .A_DWID      (WDATA_WIDTH),
    .B_DEPTH     (RADDR_DEPTH),
    .B_AWID      (RADDR_WIDTH),
    .B_DWID      (RDATA_WIDTH),
    .INIT_MODE   (INIT_MODE),
    .INIT_FORMAT (INIT_FILE_FORMAT),
    .INIT_FILE   (INIT_FILE),
    .BEN_WID     (BYTE_SIZE),
    .A_BDWID     (BYTE_WIDTH),
    .BYTE_EN_A   (BYTE_ENABLE),
    .BYTE_EN_B   (0),
    .REGMODE_B   (REGMODE)
) mem0_ref (
    .clk_a_i     (wr_clk_i),
    .clk_en_a_i  (wr_clk_en_i & wr_en_i),
    .rst_a_i     (rst_i),
    .wr_en_a_i   (1'b1),
    .addr_a_i    (wr_addr_i),
    .data_a_i    (wr_data_i),
    .ben_a_i     (ben_i),

    .data_a_o    (),

    .clk_b_i     (rd_clk_i),
    .clk_en_b_i  (rd_clk_en_i & rd_en_i),
    .rst_b_i     (rst_i),
    .wr_en_b_i   (1'b0),
    .addr_b_i    (rd_addr_i),
    .data_b_i    ({RDATA_WIDTH{1'b0}}),
    .ben_b_i     ({roundUP(RDATA_WIDTH, BYTE_SIZE){1'b0}}),

    .data_b_o    (rd_data_ref)
);

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

endmodule
`endif
