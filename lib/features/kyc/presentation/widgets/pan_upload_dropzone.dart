import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dashed_box.dart';

class PanUploadDropzone extends StatelessWidget {
  const PanUploadDropzone({
    super.key,
    required this.onBrowsePressed,
    required this.onTakePhotoPressed,
  });

  final VoidCallback onBrowsePressed;
  final VoidCallback onTakePhotoPressed;

  @override
  Widget build(BuildContext context) {
    return AppDashedBox(
      backgroundColor: AppColors.backgroundWhite,
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.w20,
        vertical: AppDimensions.h24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.uploadIcon,
            width: AppDimensions.w64,
            height: AppDimensions.h64,
          ),
          SizedBox(height: AppDimensions.h12),
          Text(
            AppStrings.uploadPanHere,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppDimensions.h14),
          AppButton(
            text: AppStrings.browse,
            onPressed: onBrowsePressed,
            isFullWidth: false,
            width: AppDimensions.w140,
            height: AppDimensions.h40,
            borderRadius: AppDimensions.r6,
            textStyle: AppTextStyles.subtitle.copyWith(
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppDimensions.h10),
          Text(
            AppStrings.fileTypesAndSize,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          SizedBox(height: AppDimensions.h12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppDimensions.w24,
                height: 1,
                color: AppColors.textSecondary,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.w10),
                child: Text(
                  AppStrings.orDivider,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Container(
                width: AppDimensions.w24,
                height: 1,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: AppDimensions.h10),
          GestureDetector(
            onTap: onTakePhotoPressed,
            behavior: HitTestBehavior.opaque,
            child: Text(
              AppStrings.takePhoto,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.accentMagenta,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.accentMagenta,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
