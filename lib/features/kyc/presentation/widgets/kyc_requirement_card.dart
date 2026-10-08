import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';

class KycRequirementCard extends StatelessWidget {
  const KycRequirementCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
  });

  final String title;
  final String? subtitle;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.surfaceCard,
      borderRadius: AppDimensions.r16,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.w12,
        vertical: AppDimensions.h12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
              fontSize: 15.sp,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: AppDimensions.h8),
            Text(
              subtitle!,
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
              ),
            ),
          ],
          SizedBox(height: AppDimensions.h10),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.h8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppDimensions.w16,
                    height: AppDimensions.h16,
                    margin: EdgeInsets.only(top: AppDimensions.h2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentMagenta,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.check,
                      size: AppDimensions.iconXs,
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                  SizedBox(width: AppDimensions.w8),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.textPrimary,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
