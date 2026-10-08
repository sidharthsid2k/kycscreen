import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.readexPro().fontFamily,
      textTheme: GoogleFonts.readexProTextTheme(),
      scaffoldBackgroundColor: AppColors.backgroundWhite,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accentMagenta,
        surface: AppColors.backgroundWhite,
        error: AppColors.error,
        onPrimary: AppColors.backgroundWhite,
        onSecondary: AppColors.backgroundWhite,
        onSurface: AppColors.textPrimary,
        onError: AppColors.backgroundWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
