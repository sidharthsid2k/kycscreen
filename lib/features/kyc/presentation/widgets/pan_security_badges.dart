import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class PanSecurityBadges extends StatelessWidget {
  const PanSecurityBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (previous, current) =>
          previous.documentStatus != current.documentStatus,
      builder: (context, state) {
        if (state.hasDocument || state.isBwError) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.only(
            top: AppDimensions.h16,
          ),
          child: AppCard(
      backgroundColor: AppColors.backgroundWhite,
      borderRadius: AppDimensions.r24,
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: AppDimensions.w36,
                height: AppDimensions.h36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.successLight,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.lock_outline,
                  size: AppDimensions.iconSm,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: AppDimensions.w12),
              Expanded(
                child: Text(
                  AppStrings.dataSecureProtected,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.borderLight,
            height: AppDimensions.h20,
            thickness: 1,
          ),
          Row(
            children: [
              Container(
                width: AppDimensions.w36,
                height: AppDimensions.h36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.successLight,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check,
                  size: AppDimensions.iconSm,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: AppDimensions.w12),
              Expanded(
                child: Text(
                  AppStrings.kycCompliantRbi,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
      },
    );
  }
}
