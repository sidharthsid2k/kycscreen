import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_checkbox.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class KycTermsConsentCard extends StatelessWidget {
  const KycTermsConsentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (previous, current) =>
          previous.termsAccepted != current.termsAccepted,
      builder: (context, state) {
        return AppCard(
          backgroundColor: AppColors.backgroundWhite,
          borderRadius: AppDimensions.r16,
          borderColor: AppColors.cardBorder,
          borderWidth: 1.0,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.w16,
            vertical: AppDimensions.h14,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.cardShadowColor,
              offset: Offset(0, 5),
              blurRadius: 9,
            ),
          ],
          child: AppCheckbox(
            value: state.termsAccepted,
            onChanged: (val) {
              context.read<KycCubit>().toggleTerms(val);
            },
            label: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.35,
                ),
                children: [
                  const TextSpan(text: AppStrings.termsPrefix),
                  TextSpan(
                    text: AppStrings.termsOfUse,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: AppStrings.and),
                  TextSpan(
                    text: AppStrings.privacyPolicy,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
