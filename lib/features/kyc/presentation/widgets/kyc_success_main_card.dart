import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_step_indicator.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import 'kyc_success_support_card.dart';

class KycSuccessMainCard extends StatelessWidget {
  const KycSuccessMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      builder: (context, state) {
        final recipientName = state.panVerification.preferredName.isNotEmpty
            ? state.panVerification.preferredName
            : 'Hemant Kumar';

        return AppCard(
          backgroundColor: AppColors.backgroundWhite,
          borderRadius: AppDimensions.r24,
          borderColor: AppColors.cardBorder,
          borderWidth: 1.0,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.zero,
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
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppStepIndicator(
                      currentStep: 4,
                      completionPercentage: AppStrings.step5Progress,
                    ),
                    SizedBox(height: AppDimensions.h16),
                    Center(
                      child: SvgPicture.asset(
                        AppAssets.thanksIllustration,
                        width: 270.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: AppDimensions.h16),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppStrings.thankYouPrefix,
                              style: AppTextStyles.h2.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: '$recipientName!',
                              style: AppTextStyles.h2.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.accentMagenta,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: AppDimensions.h8),
                    Text(
                      AppStrings.kycSubmittedSuccess,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: AppDimensions.h24),
                  ],
                ),
              ),
              const KycSuccessSupportCard(),
            ],
          ),
        );
      },
    );
  }
}
