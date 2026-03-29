import 'package:evencir_pulse_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyle {
  static TextStyle mulishTextStyle(
      {double? fontSize,
      Color? c,
      FontWeight? fontWeight,
      TextDecoration? textDecoration,
      double? letterSpacing,
      double? height}) {
    return GoogleFonts.mulish(
        color: c ?? AppColors.kWhiteColor,
        fontSize: fontSize?.sp ?? 12.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        height: height,
        decoration: textDecoration ?? TextDecoration.none);
  }
}
