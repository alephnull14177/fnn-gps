; ModuleID = '/ecel/UFAD/mark.gross/fnn-gps/gps-parser/gps-parser/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"class.hls::stream<char, 0>" = type { i8 }
%struct.gnss_data_t = type { %"struct.ap_int<32>", %"struct.ap_int<32>", %"struct.ap_int<32>", %"struct.ap_int<32>", %"struct.ap_int<32>", %"struct.ap_int<32>", float, float, %"struct.ap_int<32>", %"struct.ap_int<32>" }
%"struct.ap_int<32>" = type { %"struct.ap_int_base<32, true>" }
%"struct.ap_int_base<32, true>" = type { %"struct.ssdm_int<32, true>" }
%"struct.ssdm_int<32, true>" = type { i32 }
%"struct.ap_uint<1>" = type { %"struct.ap_int_base<1, false>" }
%"struct.ap_int_base<1, false>" = type { %"struct.ssdm_int<1, false>" }
%"struct.ssdm_int<1, false>" = type { i1 }

; Function Attrs: inaccessiblememonly nounwind willreturn
declare void @llvm.sideeffect() #0

; Function Attrs: noinline willreturn
define void @apatb_gps_translation_ir(%"class.hls::stream<char, 0>"* noalias nocapture nonnull dereferenceable(1) %msg, %"struct.ap_uint<1>"* nocapture readonly %pps, %struct.gnss_data_t* noalias nocapture nonnull dereferenceable(40) %gd, %"struct.ap_uint<1>"* noalias nocapture nonnull dereferenceable(1) %data_valid) local_unnamed_addr #1 {
entry:
  %msg_copy = alloca i8, align 512
  call void @llvm.sideeffect() #9 [ "stream_interface"(i8* %msg_copy, i32 0) ]
  %gd_copy = alloca i320, align 512
  %data_valid_copy = alloca i1, align 512
  call fastcc void @copy_in(%"class.hls::stream<char, 0>"* nonnull %msg, i8* nonnull align 512 %msg_copy, %struct.gnss_data_t* nonnull %gd, i320* nonnull align 512 %gd_copy, %"struct.ap_uint<1>"* nonnull %data_valid, i1* nonnull align 512 %data_valid_copy)
  call void @apatb_gps_translation_hw(i8* %msg_copy, %"struct.ap_uint<1>"* %pps, i320* %gd_copy, i1* %data_valid_copy)
  call void @copy_back(%"class.hls::stream<char, 0>"* %msg, i8* %msg_copy, %struct.gnss_data_t* %gd, i320* %gd_copy, %"struct.ap_uint<1>"* %data_valid, i1* %data_valid_copy)
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @copy_in(%"class.hls::stream<char, 0>"* noalias "unpacked"="0", i8* noalias nocapture align 512 "unpacked"="1.0", %struct.gnss_data_t* noalias readonly "unpacked"="2", i320* noalias align 512 "unpacked"="3", %"struct.ap_uint<1>"* noalias readonly "unpacked"="4", i1* noalias nocapture align 512 "unpacked"="5.0") unnamed_addr #2 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<char, 0>.20"(i8* align 512 %1, %"class.hls::stream<char, 0>"* %0)
  call fastcc void @onebyonecpy_hls.p0struct.gnss_data_t(i320* align 512 %3, %struct.gnss_data_t* %2)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>"(i1* align 512 %5, %"struct.ap_uint<1>"* %4)
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<char, 0>"(%"class.hls::stream<char, 0>"* noalias "unpacked"="0" %dst, i8* noalias nocapture align 512 "unpacked"="1.0" %src) unnamed_addr #3 {
entry:
  %0 = icmp eq %"class.hls::stream<char, 0>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<char, 0>"(%"class.hls::stream<char, 0>"* nonnull %dst, i8* align 512 %src)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<char, 0>"(%"class.hls::stream<char, 0>"* noalias nocapture "unpacked"="0", i8* noalias nocapture align 512 "unpacked"="1.0") unnamed_addr #4 {
entry:
  %2 = alloca i8
  %3 = alloca %"class.hls::stream<char, 0>"
  br label %empty

empty:                                            ; preds = %push, %entry
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %1)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  call void @fpga_fifo_pop_1(i8* %2, i8* %1)
  %5 = load volatile i8, i8* %2
  %.ivi = insertvalue %"class.hls::stream<char, 0>" undef, i8 %5, 0
  store %"class.hls::stream<char, 0>" %.ivi, %"class.hls::stream<char, 0>"* %3
  %6 = bitcast %"class.hls::stream<char, 0>"* %3 to i8*
  %7 = bitcast %"class.hls::stream<char, 0>"* %0 to i8*
  call void @fpga_fifo_push_1(i8* %6, i8* %7)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.gnss_data_t(i320* noalias align 512 %dst, %struct.gnss_data_t* noalias readonly %src) unnamed_addr #5 {
entry:
  %0 = icmp eq i320* %dst, null
  %1 = icmp eq %struct.gnss_data_t* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.0.05 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 0, i32 0, i32 0, i32 0
  %3 = load i32, i32* %src.0.0.0.05, align 4
  %4 = zext i32 %3 to i320
  %src.1.0.0.011 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 1, i32 0, i32 0, i32 0
  %5 = load i32, i32* %src.1.0.0.011, align 4
  %6 = zext i32 %5 to i320
  %7 = shl i320 %6, 32
  %.partset6 = or i320 %7, %4
  %src.2.0.0.017 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 2, i32 0, i32 0, i32 0
  %8 = load i32, i32* %src.2.0.0.017, align 4
  %9 = zext i32 %8 to i320
  %10 = shl i320 %9, 64
  %.partset5 = or i320 %.partset6, %10
  %src.3.0.0.023 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 3, i32 0, i32 0, i32 0
  %11 = load i32, i32* %src.3.0.0.023, align 4
  %12 = zext i32 %11 to i320
  %13 = shl i320 %12, 96
  %.partset4 = or i320 %.partset5, %13
  %src.4.0.0.029 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 4, i32 0, i32 0, i32 0
  %14 = load i32, i32* %src.4.0.0.029, align 4
  %15 = zext i32 %14 to i320
  %16 = shl i320 %15, 128
  %src.5.0.0.035 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 5, i32 0, i32 0, i32 0
  %17 = load i32, i32* %src.5.0.0.035, align 4
  %18 = zext i32 %17 to i320
  %19 = shl i320 %18, 160
  %src.6 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 6
  %20 = load float, float* %src.6, align 4
  %21 = call i32 @_llvm.fpga.pack.bits.i32.f32(float %20)
  %22 = zext i32 %21 to i320
  %23 = shl i320 %22, 192
  %src.7 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 7
  %24 = load float, float* %src.7, align 4
  %25 = call i32 @_llvm.fpga.pack.bits.i32.f32(float %24)
  %26 = zext i32 %25 to i320
  %27 = shl i320 %26, 224
  %src.8.0.0.041 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 8, i32 0, i32 0, i32 0
  %28 = load i32, i32* %src.8.0.0.041, align 4
  %29 = zext i32 %28 to i320
  %30 = shl i320 %29, 256
  %src.9.0.0.047 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %src, i64 0, i32 9, i32 0, i32 0, i32 0
  %31 = load i32, i32* %src.9.0.0.047, align 4
  %32 = zext i32 %31 to i320
  %33 = shl i320 %32, 288
  %.masked.masked.masked.masked = or i320 %.partset4, %16
  %.masked10.masked.masked = or i320 %.masked.masked.masked.masked, %19
  %.masked.masked = or i320 %.masked10.masked.masked, %23
  %.masked11 = or i320 %.masked.masked, %27
  %34 = or i320 %.masked11, %30
  %.partset = or i320 %34, %33
  store i320 %.partset, i320* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>"(i1* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<1>"* noalias readonly "unpacked"="1" %src) unnamed_addr #5 {
entry:
  %0 = icmp eq %"struct.ap_uint<1>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<1>", %"struct.ap_uint<1>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i1* %src.0.0.03 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i1
  store i1 %3, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @copy_out(%"class.hls::stream<char, 0>"* noalias "unpacked"="0", i8* noalias nocapture align 512 "unpacked"="1.0", %struct.gnss_data_t* noalias "unpacked"="2", i320* noalias readonly align 512 "unpacked"="3", %"struct.ap_uint<1>"* noalias "unpacked"="4", i1* noalias nocapture readonly align 512 "unpacked"="5.0") unnamed_addr #6 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<char, 0>"(%"class.hls::stream<char, 0>"* %0, i8* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0struct.gnss_data_t.33(%struct.gnss_data_t* %2, i320* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>.13"(%"struct.ap_uint<1>"* %4, i1* align 512 %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>.13"(%"struct.ap_uint<1>"* noalias "unpacked"="0" %dst, i1* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #5 {
entry:
  %0 = icmp eq %"struct.ap_uint<1>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<1>", %"struct.ap_uint<1>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i1* %src to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i1
  store i1 %3, i1* %dst.0.0.04, align 1
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<char, 0>.20"(i8* noalias nocapture align 512 "unpacked"="0.0" %dst, %"class.hls::stream<char, 0>"* noalias "unpacked"="1" %src) unnamed_addr #3 {
entry:
  %0 = icmp eq %"class.hls::stream<char, 0>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<char, 0>.23"(i8* align 512 %dst, %"class.hls::stream<char, 0>"* nonnull %src)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<char, 0>.23"(i8* noalias nocapture align 512 "unpacked"="0.0", %"class.hls::stream<char, 0>"* noalias nocapture "unpacked"="1") unnamed_addr #4 {
entry:
  %2 = alloca %"class.hls::stream<char, 0>"
  %3 = alloca i8
  br label %empty

empty:                                            ; preds = %push, %entry
  %4 = bitcast %"class.hls::stream<char, 0>"* %1 to i8*
  %5 = call i1 @fpga_fifo_not_empty_1(i8* %4)
  br i1 %5, label %push, label %ret

push:                                             ; preds = %empty
  %6 = bitcast %"class.hls::stream<char, 0>"* %2 to i8*
  %7 = bitcast %"class.hls::stream<char, 0>"* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %6, i8* %7)
  %8 = load volatile %"class.hls::stream<char, 0>", %"class.hls::stream<char, 0>"* %2
  %.evi = extractvalue %"class.hls::stream<char, 0>" %8, 0
  store i8 %.evi, i8* %3
  call void @fpga_fifo_push_1(i8* %3, i8* %0)
  br label %empty, !llvm.loop !7

ret:                                              ; preds = %empty
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0struct.gnss_data_t.33(%struct.gnss_data_t* noalias %dst, i320* noalias readonly align 512 %src) unnamed_addr #5 {
entry:
  %0 = icmp eq %struct.gnss_data_t* %dst, null
  %1 = icmp eq i320* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.0.06 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 0, i32 0, i32 0, i32 0
  %3 = load i320, i320* %src, align 512
  %.partselect9 = trunc i320 %3 to i32
  store i32 %.partselect9, i32* %dst.0.0.0.06, align 512
  %dst.1.0.0.012 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 1, i32 0, i32 0, i32 0
  %4 = lshr i320 %3, 32
  %.partselect8 = trunc i320 %4 to i32
  store i32 %.partselect8, i32* %dst.1.0.0.012, align 4
  %dst.2.0.0.018 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 2, i32 0, i32 0, i32 0
  %5 = lshr i320 %3, 64
  %.partselect7 = trunc i320 %5 to i32
  store i32 %.partselect7, i32* %dst.2.0.0.018, align 8
  %dst.3.0.0.024 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 3, i32 0, i32 0, i32 0
  %6 = lshr i320 %3, 96
  %.partselect6 = trunc i320 %6 to i32
  store i32 %.partselect6, i32* %dst.3.0.0.024, align 4
  %dst.4.0.0.030 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 4, i32 0, i32 0, i32 0
  %7 = lshr i320 %3, 128
  %.partselect5 = trunc i320 %7 to i32
  store i32 %.partselect5, i32* %dst.4.0.0.030, align 16
  %dst.5.0.0.036 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 5, i32 0, i32 0, i32 0
  %8 = lshr i320 %3, 160
  %.partselect4 = trunc i320 %8 to i32
  store i32 %.partselect4, i32* %dst.5.0.0.036, align 4
  %dst.6 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 6
  %9 = lshr i320 %3, 192
  %.partselect3 = trunc i320 %9 to i32
  %10 = call float @_llvm.fpga.unpack.bits.f32.i32(i32 %.partselect3)
  store float %10, float* %dst.6, align 8
  %dst.7 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 7
  %11 = lshr i320 %3, 224
  %.partselect2 = trunc i320 %11 to i32
  %12 = call float @_llvm.fpga.unpack.bits.f32.i32(i32 %.partselect2)
  store float %12, float* %dst.7, align 4
  %dst.8.0.0.042 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 8, i32 0, i32 0, i32 0
  %13 = lshr i320 %3, 256
  %.partselect1 = trunc i320 %13 to i32
  store i32 %.partselect1, i32* %dst.8.0.0.042, align 32
  %dst.9.0.0.048 = getelementptr %struct.gnss_data_t, %struct.gnss_data_t* %dst, i64 0, i32 9, i32 0, i32 0, i32 0
  %14 = lshr i320 %3, 288
  %.partselect = trunc i320 %14 to i32
  store i32 %.partselect, i32* %dst.9.0.0.048, align 4
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: alwaysinline nounwind readnone willreturn
define internal float @_llvm.fpga.unpack.bits.f32.i32(i32 %A) #7 {
  %A.cast = bitcast i32 %A to float
  ret float %A.cast
}

; Function Attrs: alwaysinline nounwind readnone willreturn
define internal i32 @_llvm.fpga.pack.bits.i32.f32(float %A) #7 {
  %A.cast = bitcast float %A to i32
  ret i32 %A.cast
}

declare void @apatb_gps_translation_hw(i8*, %"struct.ap_uint<1>"*, i320*, i1*)

; Function Attrs: argmemonly noinline willreturn
define internal fastcc void @copy_back(%"class.hls::stream<char, 0>"* noalias "unpacked"="0", i8* noalias nocapture align 512 "unpacked"="1.0", %struct.gnss_data_t* noalias "unpacked"="2", i320* noalias readonly align 512 "unpacked"="3", %"struct.ap_uint<1>"* noalias "unpacked"="4", i1* noalias nocapture readonly align 512 "unpacked"="5.0") unnamed_addr #6 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<char, 0>"(%"class.hls::stream<char, 0>"* %0, i8* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0struct.gnss_data_t.33(%struct.gnss_data_t* %2, i320* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>.13"(%"struct.ap_uint<1>"* %4, i1* align 512 %5)
  ret void
}

define void @gps_translation_hw_stub_wrapper(i8*, %"struct.ap_uint<1>"*, i320*, i1*) #8 {
entry:
  %4 = alloca %"class.hls::stream<char, 0>"
  %5 = alloca %struct.gnss_data_t
  %6 = alloca %"struct.ap_uint<1>"
  call void @copy_out(%"class.hls::stream<char, 0>"* %4, i8* %0, %struct.gnss_data_t* %5, i320* %2, %"struct.ap_uint<1>"* %6, i1* %3)
  call void @gps_translation_hw_stub(%"class.hls::stream<char, 0>"* %4, %"struct.ap_uint<1>"* %1, %struct.gnss_data_t* %5, %"struct.ap_uint<1>"* %6)
  call void @copy_in(%"class.hls::stream<char, 0>"* %4, i8* %0, %struct.gnss_data_t* %5, i320* %2, %"struct.ap_uint<1>"* %6, i1* %3)
  ret void
}

declare void @gps_translation_hw_stub(%"class.hls::stream<char, 0>"*, %"struct.ap_uint<1>"*, %struct.gnss_data_t*, %"struct.ap_uint<1>"*)

declare i1 @fpga_fifo_not_empty_1(i8*)

declare void @fpga_fifo_pop_1(i8*, i8*)

declare void @fpga_fifo_push_1(i8*, i8*)

attributes #0 = { inaccessiblememonly nounwind willreturn }
attributes #1 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #2 = { argmemonly noinline willreturn "fpga.wrapper.func"="copyin" }
attributes #3 = { argmemonly noinline willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { argmemonly noinline willreturn "fpga.wrapper.func"="streamcpy_hls" }
attributes #5 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #6 = { argmemonly noinline willreturn "fpga.wrapper.func"="copyout" }
attributes #7 = { alwaysinline nounwind readnone willreturn }
attributes #8 = { "fpga.wrapper.func"="stub" }
attributes #9 = { inaccessiblememonly nounwind willreturn "xlx.port.bitwidth"="8" "xlx.source"="user" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.rotate.disable"}
!7 = distinct !{!7, !6}
