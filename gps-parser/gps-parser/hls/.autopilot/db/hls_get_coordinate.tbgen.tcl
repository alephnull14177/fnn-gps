set moduleName hls_get_coordinate
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {hls_get_coordinate}
set C_modelType { float 32 }
set C_modelArgList {
	{ stored_msg int 8 regular {array 82 { 1 3 } 1 1 } {global 0}  }
}
set hasAXIMCache 0
set AXIMCacheInstList { }
set C_modelArgMapList {[ 
	{ "Name" : "stored_msg", "interface" : "memory", "bitwidth" : 8, "direction" : "READONLY", "extern" : 0} , 
 	{ "Name" : "ap_return", "interface" : "wire", "bitwidth" : 32} ]}
# RTL Port declarations: 
set portNum 22
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ stored_msg_address0 sc_out sc_lv 7 signal 0 } 
	{ stored_msg_ce0 sc_out sc_logic 1 signal 0 } 
	{ stored_msg_q0 sc_in sc_lv 8 signal 0 } 
	{ ap_return sc_out sc_lv 32 signal -1 } 
	{ grp_fu_792_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_792_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_792_p_opcode sc_out sc_lv 2 signal -1 } 
	{ grp_fu_792_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_792_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_796_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_796_p_din1 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_796_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_796_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_800_p_din0 sc_out sc_lv 32 signal -1 } 
	{ grp_fu_800_p_dout0 sc_in sc_lv 32 signal -1 } 
	{ grp_fu_800_p_ce sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "stored_msg_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":7, "type": "signal", "bundle":{"name": "stored_msg", "role": "address0" }} , 
 	{ "name": "stored_msg_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "stored_msg", "role": "ce0" }} , 
 	{ "name": "stored_msg_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "stored_msg", "role": "q0" }} , 
 	{ "name": "ap_return", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "ap_return", "role": "default" }} , 
 	{ "name": "grp_fu_792_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_792_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_792_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_792_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_792_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "grp_fu_792_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_792_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_792_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_792_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_792_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_796_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_796_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_796_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_796_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_796_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_796_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_796_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_796_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_800_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_800_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_800_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "grp_fu_800_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_800_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_800_p_ce", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "4", "7"],
		"CDFG" : "hls_get_coordinate",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "stored_msg", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "4", "SubInstance" : "grp_hls_atoi_w_len_fu_52", "Port" : "stored_msg", "Inst_start_state" : "7", "Inst_end_state" : "8"},
					{"ID" : "1", "SubInstance" : "grp_hls_get_field_from_nmea_fu_43", "Port" : "stored_msg", "Inst_start_state" : "17", "Inst_end_state" : "18"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_hls_get_field_from_nmea_fu_43", "Parent" : "0", "Child" : ["2"],
		"CDFG" : "hls_get_field_from_nmea",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "fieldnum", "Type" : "None", "Direction" : "I"},
			{"Name" : "stored_msg", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "2", "SubInstance" : "grp_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2_fu_44", "Port" : "stored_msg", "Inst_start_state" : "2", "Inst_end_state" : "3"}]}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_51_1", "PipelineType" : "no",
				"LoopDec" : {"FSMBitwidth" : "4", "FirstState" : "ap_ST_fsm_state2", "LastState" : ["ap_ST_fsm_state4"], "QuitState" : ["ap_ST_fsm_state2"], "PreState" : ["ap_ST_fsm_state1"], "PostState" : ["ap_ST_fsm_state1"], "OneDepthLoop" : "0", "OneStateBlock": ""}}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_hls_get_field_from_nmea_fu_43.grp_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2_fu_44", "Parent" : "1", "Child" : ["3"],
		"CDFG" : "hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "empty", "Type" : "None", "Direction" : "I"},
			{"Name" : "add_ln51_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "stored_msg", "Type" : "Memory", "Direction" : "I"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_53_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "2", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "3", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_hls_get_field_from_nmea_fu_43.grp_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2_fu_44.flow_control_loop_pipe_sequential_init_U", "Parent" : "2"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.grp_hls_atoi_w_len_fu_52", "Parent" : "0", "Child" : ["5"],
		"CDFG" : "hls_atoi_w_len",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "s", "Type" : "None", "Direction" : "I"},
			{"Name" : "n", "Type" : "None", "Direction" : "I"},
			{"Name" : "stored_msg", "Type" : "Memory", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "5", "SubInstance" : "grp_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1_fu_36", "Port" : "stored_msg", "Inst_start_state" : "1", "Inst_end_state" : "2"}]}]},
	{"ID" : "5", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.grp_hls_atoi_w_len_fu_52.grp_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1_fu_36", "Parent" : "4", "Child" : ["6"],
		"CDFG" : "hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "s", "Type" : "None", "Direction" : "I"},
			{"Name" : "n", "Type" : "None", "Direction" : "I"},
			{"Name" : "res_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "is_neg_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "stored_msg", "Type" : "Memory", "Direction" : "I"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_8_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "2", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state2", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state2_blk", "QuitState" : "ap_ST_fsm_state2", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state2_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "6", "Level" : "3", "Path" : "`AUTOTB_DUT_INST.grp_hls_atoi_w_len_fu_52.grp_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1_fu_36.flow_control_loop_pipe_sequential_init_U", "Parent" : "5"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.fmul_32ns_32ns_32_1_max_dsp_1_U20", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	hls_get_coordinate {
		stored_msg {Type I LastRead 18 FirstWrite -1}}
	hls_get_field_from_nmea {
		fieldnum {Type I LastRead 0 FirstWrite -1}
		stored_msg {Type I LastRead 1 FirstWrite -1}}
	hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		add_ln51_out {Type O LastRead -1 FirstWrite 2}
		stored_msg {Type I LastRead 1 FirstWrite -1}}
	hls_atoi_w_len {
		s {Type I LastRead 0 FirstWrite -1}
		n {Type I LastRead 0 FirstWrite -1}
		stored_msg {Type I LastRead 0 FirstWrite -1}}
	hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1 {
		s {Type I LastRead 0 FirstWrite -1}
		n {Type I LastRead 0 FirstWrite -1}
		res_out {Type O LastRead -1 FirstWrite 1}
		is_neg_out {Type O LastRead -1 FirstWrite 1}
		stored_msg {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	stored_msg { ap_memory {  { stored_msg_address0 mem_address 1 7 }  { stored_msg_ce0 mem_ce 1 1 }  { stored_msg_q0 in_data 0 8 } } }
}
