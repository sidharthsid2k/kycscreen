import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_step_indicator.dart';
import 'bank_account_form.dart';
import 'bank_verified_banner.dart';

class BankAccountMainCard extends StatelessWidget {
  const BankAccountMainCard({
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
            currentStep: 3,
            completionPercentage: AppStrings.step4Progress,
          ),
          SizedBox(height: AppDimensions.h20),
          const BankVerifiedBanner(),
          SizedBox(height: AppDimensions.h20),
          Text(
            AppStrings.businessBankDetailsTitle,
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.h6),
          Text(
            AppStrings.businessBankDetailsSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimensions.h20),
          BankAccountForm(formKey: formKey),
        ],
      ),
    );
  }
}
