set ModuleHierarchy {[{
"Name" : "gps_translation","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_gps_translation_Pipeline_shift_loop_fu_212","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "shift_loop","ID" : "2","Type" : "pipeline"},]},
	{"Name" : "grp_gps_translation_Pipeline_VITIS_LOOP_23_1_fu_218","ID" : "3","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_23_1","ID" : "4","Type" : "pipeline"},]},
	{"Name" : "grp_gps_translation_Pipeline_VITIS_LOOP_132_1_fu_226","ID" : "5","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_132_1","ID" : "6","Type" : "pipeline"},]},
	{"Name" : "grp_hls_get_field_from_nmea_fu_234","ID" : "7","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "VITIS_LOOP_51_1","ID" : "8","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2_fu_44","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_53_2","ID" : "10","Type" : "pipeline"},]},]},]},
	{"Name" : "grp_hls_atoi_w_len_fu_243","ID" : "11","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1_fu_36","ID" : "12","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_8_1","ID" : "13","Type" : "pipeline"},]},]},
	{"Name" : "grp_hls_get_coordinate_fu_252","ID" : "14","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_hls_get_field_from_nmea_fu_43","ID" : "15","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_51_1","ID" : "16","Type" : "no",
			"SubInsts" : [
			{"Name" : "grp_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2_fu_44","ID" : "17","Type" : "sequential",
					"SubLoops" : [
					{"Name" : "VITIS_LOOP_53_2","ID" : "18","Type" : "pipeline"},]},]},]},
		{"Name" : "grp_hls_atoi_w_len_fu_52","ID" : "19","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1_fu_36","ID" : "20","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_8_1","ID" : "21","Type" : "pipeline"},]},]},]},
	{"Name" : "grp_hls_get_coordinate_1_fu_258","ID" : "22","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_hls_get_field_from_nmea_fu_45","ID" : "23","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_51_1","ID" : "24","Type" : "no",
			"SubInsts" : [
			{"Name" : "grp_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2_fu_44","ID" : "25","Type" : "sequential",
					"SubLoops" : [
					{"Name" : "VITIS_LOOP_53_2","ID" : "26","Type" : "pipeline"},]},]},]},
		{"Name" : "grp_hls_atoi_w_len_fu_54","ID" : "27","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1_fu_36","ID" : "28","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_8_1","ID" : "29","Type" : "pipeline"},]},]},]},]
}]}