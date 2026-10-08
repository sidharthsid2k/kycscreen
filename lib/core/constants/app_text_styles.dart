import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get h1 => GoogleFonts.readexPro(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        height: 1.36,
        color: AppColors.textPrimary,
      );

  static TextStyle get h2 => GoogleFonts.readexPro(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.33,
        color: AppColors.textPrimary,
      );

  static TextStyle get h3 => GoogleFonts.readexPro(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.38,
        color: AppColors.textPrimary,
      );

  static TextStyle get subtitle => GoogleFonts.readexPro(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.43,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyLarge => GoogleFonts.readexPro(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1.43,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodyMedium => GoogleFonts.readexPro(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 1.50,
        color: AppColors.textSecondary,
      );

  static TextStyle get bodySmall => GoogleFonts.readexPro(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: AppColors.textMuted,
      );

  static TextStyle get buttonLarge => GoogleFonts.readexPro(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: AppColors.backgroundWhite,
      );

  static TextStyle get buttonMedium => GoogleFonts.readexPro(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: AppColors.backgroundWhite,
      );

  static TextStyle get buttonSmall => GoogleFonts.readexPro(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: AppColors.primary,
      );

  static TextStyle get label => GoogleFonts.readexPro(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.33,
        color: AppColors.textPrimary,
      );

  static TextStyle get caption => GoogleFonts.readexPro(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        height: 1.30,
        color: AppColors.textMuted,
      );
}
