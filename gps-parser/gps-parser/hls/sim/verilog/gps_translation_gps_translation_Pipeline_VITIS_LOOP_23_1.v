// ==============================================================
// Generated by Vitis HLS v2023.2.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module gps_translation_gps_translation_Pipeline_VITIS_LOOP_23_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        msg_shift_address0,
        msg_shift_ce0,
        msg_shift_q0,
        ap_return
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [6:0] msg_shift_address0;
output   msg_shift_ce0;
input  [7:0] msg_shift_q0;
output  [0:0] ap_return;

reg ap_idle;
reg msg_shift_ce0;
reg[0:0] ap_return;

(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state2;
wire   [0:0] icmp_ln24_fu_120_p2;
reg   [0:0] icmp_ln23_reg_137;
reg    ap_condition_exit_pp0_iter0_stage1;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
wire   [1:0] p_str_address0;
reg    p_str_ce0;
wire   [7:0] p_str_q0;
reg   [0:0] merge_reg_68;
wire   [0:0] icmp_ln23_fu_88_p2;
reg    ap_block_state1_pp0_stage0_iter0;
wire   [1:0] add_ln23_fu_94_p2;
reg   [1:0] add_ln23_reg_141;
reg   [0:0] ap_phi_mux_merge_phi_fu_72_p4;
wire   [63:0] zext_ln24_fu_115_p1;
wire   [63:0] zext_ln23_fu_100_p1;
reg   [1:0] i_fu_38;
wire    ap_loop_init;
reg   [1:0] ap_sig_allocacmp_i_4;
wire   [2:0] zext_ln23_1_fu_105_p1;
wire   [2:0] add_ln24_fu_109_p2;
reg   [0:0] ap_return_preg;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [1:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 2'd1;
#0 i_fu_38 = 2'd0;
#0 ap_return_preg = 1'd0;
#0 ap_done_reg = 1'b0;
end

gps_translation_gps_translation_Pipeline_VITIS_LOOP_23_1_p_str_ROM_AUTO_1R #(
    .DataWidth( 8 ),
    .AddressRange( 4 ),
    .AddressWidth( 2 ))
p_str_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(p_str_address0),
    .ce0(p_str_ce0),
    .q0(p_str_q0)
);

gps_translation_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage1),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_loop_exit_ready == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_preg <= 1'd0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state2) & ((icmp_ln23_reg_137 == 1'd1) | (icmp_ln24_fu_120_p2 == 1'd0)))) begin
            ap_return_preg <= ap_phi_mux_merge_phi_fu_72_p4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_state1_pp0_stage0_iter0) & (1'b1 == ap_CS_fsm_state1))) begin
        i_fu_38 <= 2'd0;
    end else if (((icmp_ln23_reg_137 == 1'd0) & (icmp_ln24_fu_120_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
        i_fu_38 <= add_ln23_reg_141;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln23_reg_137 == 1'd0) & (icmp_ln24_fu_120_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        merge_reg_68 <= 1'd0;
    end else if (((1'b0 == ap_block_state1_pp0_stage0_iter0) & (icmp_ln23_fu_88_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1))) begin
        merge_reg_68 <= 1'd1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_state1_pp0_stage0_iter0) & (1'b1 == ap_CS_fsm_state1))) begin
        add_ln23_reg_141 <= add_ln23_fu_94_p2;
        icmp_ln23_reg_137 <= icmp_ln23_fu_88_p2;
    end
end

always @ (*) begin
    if ((1'b1 == ap_block_state1_pp0_stage0_iter0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & ((icmp_ln23_reg_137 == 1'd1) | (icmp_ln24_fu_120_p2 == 1'd0)))) begin
        ap_condition_exit_pp0_iter0_stage1 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_exit_ready == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln23_reg_137 == 1'd0) & (icmp_ln24_fu_120_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_phi_mux_merge_phi_fu_72_p4 = 1'd0;
    end else begin
        ap_phi_mux_merge_phi_fu_72_p4 = merge_reg_68;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) & ((icmp_ln23_reg_137 == 1'd1) | (icmp_ln24_fu_120_p2 == 1'd0)))) begin
        ap_return = ap_phi_mux_merge_phi_fu_72_p4;
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_sig_allocacmp_i_4 = 2'd0;
    end else begin
        ap_sig_allocacmp_i_4 = i_fu_38;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state1_pp0_stage0_iter0) & (1'b1 == ap_CS_fsm_state1))) begin
        msg_shift_ce0 = 1'b1;
    end else begin
        msg_shift_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state1_pp0_stage0_iter0) & (1'b1 == ap_CS_fsm_state1))) begin
        p_str_ce0 = 1'b1;
    end else begin
        p_str_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b0 == ap_block_state1_pp0_stage0_iter0) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln23_fu_94_p2 = (ap_sig_allocacmp_i_4 + 2'd1);

assign add_ln24_fu_109_p2 = (zext_ln23_1_fu_105_p1 + 3'd3);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_start_int == 1'b0);
end

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage1;

assign icmp_ln23_fu_88_p2 = ((ap_sig_allocacmp_i_4 == 2'd3) ? 1'b1 : 1'b0);

assign icmp_ln24_fu_120_p2 = ((msg_shift_q0 == p_str_q0) ? 1'b1 : 1'b0);

assign msg_shift_address0 = zext_ln24_fu_115_p1;

assign p_str_address0 = zext_ln23_fu_100_p1;

assign zext_ln23_1_fu_105_p1 = ap_sig_allocacmp_i_4;

assign zext_ln23_fu_100_p1 = ap_sig_allocacmp_i_4;

assign zext_ln24_fu_115_p1 = add_ln24_fu_109_p2;

endmodule //gps_translation_gps_translation_Pipeline_VITIS_LOOP_23_1
