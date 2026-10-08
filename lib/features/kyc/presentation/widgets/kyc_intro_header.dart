import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class KycIntroHeader extends StatelessWidget {
  const KycIntroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.h1,
          children: [
            const TextSpan(text: AppStrings.kycIntroTitle1),
            TextSpan(
              text: AppStrings.kycIntroTitleHighlight1,
              style: AppTextStyles.h1.copyWith(
                color: AppColors.accentMagenta,
              ),
            ),
            const TextSpan(text: AppStrings.kycIntroTitle2),
            TextSpan(
              text: AppStrings.kycIntroTitleHighlight2,
              style: AppTextStyles.h1.copyWith(
                color: AppColors.accentMagenta,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
