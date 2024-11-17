set SynModuleInfo {
  {SRCNAME gps_translation_Pipeline_shift_loop MODELNAME gps_translation_Pipeline_shift_loop RTLNAME gps_translation_gps_translation_Pipeline_shift_loop
    SUBMODULES {
      {MODELNAME gps_translation_flow_control_loop_pipe_sequential_init RTLNAME gps_translation_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME gps_translation_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME gps_translation_Pipeline_VITIS_LOOP_23_1 MODELNAME gps_translation_Pipeline_VITIS_LOOP_23_1 RTLNAME gps_translation_gps_translation_Pipeline_VITIS_LOOP_23_1
    SUBMODULES {
      {MODELNAME gps_translation_gps_translation_Pipeline_VITIS_LOOP_23_1_p_str_ROM_AUTO_1R RTLNAME gps_translation_gps_translation_Pipeline_VITIS_LOOP_23_1_p_str_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME gps_translation_Pipeline_VITIS_LOOP_132_1 MODELNAME gps_translation_Pipeline_VITIS_LOOP_132_1 RTLNAME gps_translation_gps_translation_Pipeline_VITIS_LOOP_132_1}
  {SRCNAME hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2 MODELNAME hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2 RTLNAME gps_translation_hls_get_field_from_nmea_Pipeline_VITIS_LOOP_53_2}
  {SRCNAME hls_get_field_from_nmea MODELNAME hls_get_field_from_nmea RTLNAME gps_translation_hls_get_field_from_nmea}
  {SRCNAME hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1 MODELNAME hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1 RTLNAME gps_translation_hls_atoi_w_len_Pipeline_VITIS_LOOP_8_1}
  {SRCNAME hls_atoi_w_len MODELNAME hls_atoi_w_len RTLNAME gps_translation_hls_atoi_w_len}
  {SRCNAME hls_get_coordinate MODELNAME hls_get_coordinate RTLNAME gps_translation_hls_get_coordinate
    SUBMODULES {
      {MODELNAME gps_translation_fmul_32ns_32ns_32_1_max_dsp_1 RTLNAME gps_translation_fmul_32ns_32ns_32_1_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME hls_get_coordinate.1 MODELNAME hls_get_coordinate_1 RTLNAME gps_translation_hls_get_coordinate_1}
  {SRCNAME gps_translation MODELNAME gps_translation RTLNAME gps_translation IS_TOP 1
    SUBMODULES {
      {MODELNAME gps_translation_mul_26s_19ns_32_1_1 RTLNAME gps_translation_mul_26s_19ns_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_mul_32ns_34ns_65_1_1 RTLNAME gps_translation_mul_32ns_34ns_65_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_mul_32s_9ns_32_1_1 RTLNAME gps_translation_mul_32s_9ns_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_mul_32s_10ns_32_1_1 RTLNAME gps_translation_mul_32s_10ns_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_mul_32s_18ns_32_1_1 RTLNAME gps_translation_mul_32s_18ns_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_mul_32s_34ns_65_1_1 RTLNAME gps_translation_mul_32s_34ns_65_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_mul_26s_10s_32_1_1 RTLNAME gps_translation_mul_26s_10s_32_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_fadd_32ns_32ns_32_2_full_dsp_1 RTLNAME gps_translation_fadd_32ns_32ns_32_2_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_fdiv_32ns_32ns_32_3_no_dsp_1 RTLNAME gps_translation_fdiv_32ns_32ns_32_3_no_dsp_1 BINDTYPE op TYPE fdiv IMPL fabric LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_sitofp_32ns_32_2_no_dsp_1 RTLNAME gps_translation_sitofp_32ns_32_2_no_dsp_1 BINDTYPE op TYPE sitofp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_msg_shift_RAM_AUTO_1R1W RTLNAME gps_translation_msg_shift_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_stored_msg_RAM_AUTO_1R1W RTLNAME gps_translation_stored_msg_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME gps_translation_regslice_both RTLNAME gps_translation_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME gps_translation_regslice_both_U}
    }
  }
}
