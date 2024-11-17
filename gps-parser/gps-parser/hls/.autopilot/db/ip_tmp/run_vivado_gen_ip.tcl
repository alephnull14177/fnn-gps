create_project prj -part xc7z020-clg400-1 -force
set_property target_language verilog [current_project]
set vivado_ver [version -short]
set COE_DIR "../../syn/verilog"
source "/ecel/UFAD/mark.gross/fnn-gps/gps-parser/gps-parser/hls/syn/verilog/gps_translation_fmul_32ns_32ns_32_1_max_dsp_1_ip.tcl"
source "/ecel/UFAD/mark.gross/fnn-gps/gps-parser/gps-parser/hls/syn/verilog/gps_translation_fadd_32ns_32ns_32_2_full_dsp_1_ip.tcl"
source "/ecel/UFAD/mark.gross/fnn-gps/gps-parser/gps-parser/hls/syn/verilog/gps_translation_fdiv_32ns_32ns_32_3_no_dsp_1_ip.tcl"
source "/ecel/UFAD/mark.gross/fnn-gps/gps-parser/gps-parser/hls/syn/verilog/gps_translation_sitofp_32ns_32_2_no_dsp_1_ip.tcl"
