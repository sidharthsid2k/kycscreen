import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_otp_input.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class AadhaarOtpBottomSheet extends StatelessWidget {
  const AadhaarOtpBottomSheet({
    super.key,
    required this.onConfirmed,
  });

  final VoidCallback onConfirmed;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmed,
  }) {
    context.read<KycCubit>().startOtpTimer();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<KycCubit>(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
          ),
          child: AadhaarOtpBottomSheet(onConfirmed: onConfirmed),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.r24),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.w24,
        vertical: AppDimensions.h24,
      ),
      child: BlocBuilder<KycCubit, KycState>(
        builder: (context, state) {
          final cubit = context.read<KycCubit>();
          final countdownFormatted =
              state.otpCountdown < 10 ? '0${state.otpCountdown}' : '${state.otpCountdown}';

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.otpIcon,
                width: AppDimensions.w70,
                height: AppDimensions.h70,
                fit: BoxFit.contain,
              ),
              SizedBox(height: AppDimensions.h16),
              Text(
                AppStrings.enterOtpTitle,
                style: AppTextStyles.h2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppDimensions.h4),
              Container(
                width: AppDimensions.w38,
                height: AppDimensions.h3,
                decoration: BoxDecoration(
                  color: AppColors.accentMagenta,
                  borderRadius: BorderRadius.circular(AppDimensions.r2),
                ),
              ),
              SizedBox(height: AppDimensions.h14),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    const TextSpan(text: AppStrings.enterOtpSubtitleStart),
                    TextSpan(
                      text: AppStrings.mobileNumber,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.h24),
              AppOtpInput(
                length: 6,
                hasError: state.otpError != null,
                onChanged: cubit.updateOtp,
                onCompleted: (_) {
                  if (cubit.validateAndConfirmOtp()) {
                    Navigator.of(context).pop();
                    onConfirmed();
                  }
                },
              ),
              if (state.otpError != null) ...[
                SizedBox(height: AppDimensions.h8),
                Text(
                  state.otpError!,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
              SizedBox(height: AppDimensions.h12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: state.canResendOtp ? cubit.resendOtp : null,
                  behavior: HitTestBehavior.opaque,
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.resendOtp,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.accentMagenta,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.accentMagenta,
                          ),
                        ),
                        if (!state.canResendOtp)
                          TextSpan(
                            text: ' in: 00: ${countdownFormatted}s',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.h16),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.opaque,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      const TextSpan(text: AppStrings.wrongAadhaar),
                      TextSpan(
                        text: AppStrings.edit,
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
              SizedBox(height: AppDimensions.h24),
              AppButton(
                text: AppStrings.confirmAndContinue,
                onPressed: () {
                  if (cubit.validateAndConfirmOtp()) {
                    Navigator.of(context).pop();
                    onConfirmed();
                  }
                },
              ),
              SizedBox(height: AppDimensions.h8),
            ],
          );
        },
      ),
    );
  }
}
