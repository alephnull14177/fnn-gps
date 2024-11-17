#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_start", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_done", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_idle", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_ready", 1, hls_out, -1, "", "", 1),
	Port_Property("msg_TDATA", 8, hls_in, 0, "axis", "in_data", 1),
	Port_Property("msg_TVALID", 1, hls_in, 0, "axis", "in_vld", 1),
	Port_Property("msg_TREADY", 1, hls_out, 0, "axis", "in_acc", 1),
	Port_Property("pps", 1, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("gd", 320, hls_out, 2, "ap_vld", "out_data", 1),
	Port_Property("gd_ap_vld", 1, hls_out, 2, "ap_vld", "out_vld", 1),
	Port_Property("data_valid", 1, hls_out, 3, "ap_vld", "out_data", 1),
	Port_Property("data_valid_ap_vld", 1, hls_out, 3, "ap_vld", "out_vld", 1),
};
const char* HLS_Design_Meta::dut_name = "gps_translation";
