import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class PanVerifiedThumbnail extends StatelessWidget {
  const PanVerifiedThumbnail({
    super.key,
    required this.onDifferentPanTap,
  });

  final VoidCallback onDifferentPanTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.r8),
          child: Image.asset(
            AppAssets.panCard,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
        SizedBox(height: AppDimensions.h10),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: onDifferentPanTap,
            behavior: HitTestBehavior.opaque,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                children: [
                  const TextSpan(text: AppStrings.toUploadDifferentPan),
                  TextSpan(
                    text: AppStrings.clickHere,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.accentMagenta,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.accentMagenta,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
