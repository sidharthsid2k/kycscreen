import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class KycSuccessSupportCard extends StatelessWidget {
  const KycSuccessSupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppDimensions.w20,
        AppDimensions.h20,
        AppDimensions.w20,
        AppDimensions.h24,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardInnerPink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.r20),
          topRight: Radius.circular(AppDimensions.r20),
          bottomLeft: Radius.circular(AppDimensions.r24),
          bottomRight: Radius.circular(AppDimensions.r24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.haveAnyQueries,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.h6),
          Text(
            AppStrings.queriesSubtitle,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          SizedBox(height: AppDimensions.h16),
          Row(
            children: [
              Container(
                width: AppDimensions.w28,
                height: AppDimensions.h28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accentMagenta,
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.mail_outline_rounded,
                  size: AppDimensions.iconXs,
                  color: AppColors.accentMagenta,
                ),
              ),
              SizedBox(width: AppDimensions.w12),
              Text(
                AppStrings.supportEmail,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.h12),
          Row(
            children: [
              Container(
                width: AppDimensions.w28,
                height: AppDimensions.h28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accentMagenta,
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.phone_outlined,
                  size: AppDimensions.iconXs,
                  color: AppColors.accentMagenta,
                ),
              ),
              SizedBox(width: AppDimensions.w12),
              Text(
                AppStrings.supportPhone,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
