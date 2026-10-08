import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class PanTitleHeader extends StatelessWidget {
  const PanTitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.h3.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              const TextSpan(text: AppStrings.uploadDirectorPanTitle1),
              TextSpan(
                text: AppStrings.uploadDirectorPanHighlight,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentMagenta,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.h8),
        Text(
          AppStrings.uploadDirectorPanDesc,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13.sp,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
