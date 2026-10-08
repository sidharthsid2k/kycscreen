import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_status_bar_divider.dart';
import '../widgets/kyc_intro_bottom_action.dart';
import '../widgets/kyc_intro_header.dart';
import '../widgets/kyc_requirement_card.dart';
import '../widgets/kyc_terms_consent_card.dart';

class KycIntroScreen extends StatelessWidget {
  const KycIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBasePink,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.1, -1.0),
            radius: 1.3,
            colors: [
              AppColors.bgGradientPink,
              AppColors.bgGradientPinkMid,
              AppColors.bgBasePink,
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const AppStatusBarDivider(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.w16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: AppDimensions.h24),
                      AppCard(
                        backgroundColor: AppColors.backgroundWhite,
                        borderRadius: AppDimensions.r24,
                        borderColor: AppColors.cardBorder,
                        borderWidth: 1.0,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.w10,
                          vertical: AppDimensions.h20,
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
                            const KycIntroHeader(),
                            SizedBox(height: AppDimensions.h20),
                            const KycRequirementCard(
                              title: AppStrings.whatToKeepHandy,
                              subtitle: AppStrings.businessDetails,
                              items: [
                                AppStrings.businessPan,
                                AppStrings.businessBankAndIfsc,
                              ],
                            ),
                            SizedBox(height: AppDimensions.h12),
                            const KycRequirementCard(
                              title: AppStrings.whyDoWeNeedKyc,
                              items: [
                                AppStrings.rbiMandateReason,
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.h16),
                      const KycTermsConsentCard(),
                      SizedBox(height: AppDimensions.h20),
                    ],
                  ),
                ),
              ),
              const KycIntroBottomAction(),
            ],
          ),
        ),
      ),
    );
  }
}
