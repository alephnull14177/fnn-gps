// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2.1 (64-bit)
// Tool Version Limit: 2023.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

`timescale 1 ns / 1 ps

`define TV_IN_msg_TDATA "../tv/cdatafile/c.gps_translation.autotvin_msg.dat"

`define AUTOTB_TRANSACTION_NUM 68

module AESL_axi_s_msg (
    input clk,
    input reset,
    output [8 - 1:0] TRAN_msg_TDATA,
    output TRAN_msg_TVALID,
    input TRAN_msg_TREADY,
    input ready,
    input done,
    output [31:0] transaction);

    wire TRAN_msg_TVALID_temp;
    wire msg_TDATA_full;
    wire msg_TDATA_empty;
    reg msg_TDATA_write_en;
    reg [8 - 1:0] msg_TDATA_write_data;
    reg msg_TDATA_read_en;
    wire [8 - 1:0] msg_TDATA_read_data;
    
    fifo #(2, 8) fifo_msg_TDATA (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(msg_TDATA_write_en),
        .write_data(msg_TDATA_write_data),
        .read_clock(clk),
        .read_en(msg_TDATA_read_en),
        .read_data(msg_TDATA_read_data),
        .full(msg_TDATA_full),
        .empty(msg_TDATA_empty));
    
    always @ (*) begin
        msg_TDATA_write_en <= 0;
        msg_TDATA_read_en <= TRAN_msg_TREADY & TRAN_msg_TVALID;
    end
    
    assign TRAN_msg_TDATA = msg_TDATA_read_data;
    assign TRAN_msg_TVALID = TRAN_msg_TVALID_temp;

    
    assign TRAN_msg_TVALID_temp = ~(msg_TDATA_empty);
    
    function is_blank_char(input [7:0] in_char);
        if (in_char == " " || in_char == "\011" || in_char == "\012" || in_char == "\015") begin
            is_blank_char = 1;
        end else begin
            is_blank_char = 0;
        end
    endfunction
    
    function [663:0] read_token(input integer fp);
        integer ret;
        begin
            read_token = "";
                    ret = 0;
                    ret = $fscanf(fp,"%s",read_token);
        end
    endfunction
    
    function [663:0] rm_0x(input [663:0] token);
        reg [663:0] token_tmp;
        integer i;
        begin
            token_tmp = "";
            for (i = 0; token[15:0] != "0x"; token = token >> 8) begin
                token_tmp = (token[7:0] << (8 * i)) | token_tmp;
                i = i + 1;
            end
            rm_0x = token_tmp;
        end
    endfunction
    
    reg [31:0] transaction_load_msg_TDATA;
    
    assign transaction = transaction_load_msg_TDATA;
    
    initial begin : AXI_stream_driver_msg_TDATA
        integer fp;
        reg [663:0] token;
        reg [8 - 1:0] data;
        reg [663:0] data_integer;
        reg [8 * 5:1] str;
        integer ret;
        
        transaction_load_msg_TDATA = 0;
        fifo_msg_TDATA.clear();
        wait (reset === 1);
        fp = $fopen(`TV_IN_msg_TDATA, "r");
        if (fp == 0) begin
            $display("ERROR: Failed to open file \"%s\"!", `TV_IN_msg_TDATA);
            $finish;
        end
        token = read_token(fp);
        if (token != "[[[runtime]]]") begin
            $display("ERROR: token %s != [[[runtime]]]", token);
            $finish;
        end
        token = read_token(fp); // read 1st "[[transaction]]"
        forever begin
            @ (negedge clk);
            if (ready == 1) begin
                if (token != "[[[/runtime]]]") begin
                    if (token != "[[transaction]]") begin
                        $display("ERROR: token %s != [[[transaction]]]", token);
                        $finish;
                    end
                    token = read_token(fp); // skip transaction number
                    fifo_msg_TDATA.clear();
                    token = read_token(fp);
                    while (token != "[[/transaction]]") begin
                        if (fifo_msg_TDATA.full) begin
                            $display("ERROR: FIFO is full");
                            $finish;
                        end
                        ret = $sscanf(rm_0x(token), "%x", data_integer);
                        data = data_integer;
                        fifo_msg_TDATA.push(data);
                        token = read_token(fp);
                    end
                    token = read_token(fp);
                end else begin
                    if (fp != 0) begin
                        $fclose(fp);
                        fp = 0;
                    end
                end
                transaction_load_msg_TDATA = transaction_load_msg_TDATA + 1;
            end
        end
    end

endmodule
