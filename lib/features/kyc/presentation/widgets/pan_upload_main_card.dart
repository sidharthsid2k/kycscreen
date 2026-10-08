import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_step_indicator.dart';
import 'pan_title_header.dart';
import 'pan_upload_card_area.dart';
import 'pan_verification_and_badges_section.dart';

class PanUploadMainCard extends StatelessWidget {
  const PanUploadMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.backgroundWhite,
      borderRadius: AppDimensions.r24,
      borderColor: AppColors.cardBorder,
      borderWidth: 1.0,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadowColor,
          offset: Offset(0, 8),
          blurRadius: 24,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.w16,
              AppDimensions.h18,
              AppDimensions.w16,
              AppDimensions.h16,
            ),
            child: const AppStepIndicator(
              currentStep: 0,
              completionPercentage: AppStrings.directorStepProgress,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardInnerPink,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.r20),
              ),
              border: const Border(
                top: BorderSide(
                  color: AppColors.cardBorder,
                  width: 1.0,
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              AppDimensions.w16,
              AppDimensions.h20,
              AppDimensions.w16,
              AppDimensions.h20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PanTitleHeader(),
                SizedBox(height: AppDimensions.h18),
                const PanUploadCardArea(),
                const PanVerificationAndBadgesSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
