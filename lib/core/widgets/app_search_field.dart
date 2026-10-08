import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = AppStrings.search,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.h44,
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(AppDimensions.r4),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.primary,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textDisabled,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.w12,
                  vertical: AppDimensions.h10,
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            height: AppDimensions.h24,
            color: AppColors.borderMedium.withValues(alpha: 0.3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.w12),
            child: Icon(
              Icons.search_rounded,
              color: AppColors.textMuted,
              size: AppDimensions.iconMd,
            ),
          ),
        ],
      ),
    );
  }
}
