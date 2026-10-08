import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_step_indicator.dart';
import 'business_details_form.dart';

class BusinessDetailsMainCard extends StatelessWidget {
  const BusinessDetailsMainCard({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.backgroundWhite,
      borderRadius: AppDimensions.r24,
      borderColor: AppColors.cardBorder,
      borderWidth: 1.0,
      padding: EdgeInsets.fromLTRB(
        AppDimensions.w16,
        AppDimensions.h18,
        AppDimensions.w16,
        AppDimensions.h24,
      ),
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
          const AppStepIndicator(
            currentStep: 1,
            completionPercentage: AppStrings.step2Progress,
          ),
          SizedBox(height: AppDimensions.h24),
          Text(
            AppStrings.panVerifiedHighlight,
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.success,
            ),
          ),
          Text(
            AppStrings.fillBusinessDetailsTitle,
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.h6),
          Text(
            AppStrings.businessDetailsSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimensions.h20),
          BusinessDetailsForm(formKey: formKey),
        ],
      ),
    );
  }
}
