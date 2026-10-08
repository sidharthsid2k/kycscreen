import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dashed_box.dart';
import '../../data/models/document_upload_model.dart';

class PanPreviewCard extends StatelessWidget {
  const PanPreviewCard({
    super.key,
    required this.document,
    required this.onRemovePressed,
    required this.onChangePressed,
  });

  final DocumentUploadModel document;
  final VoidCallback onRemovePressed;
  final VoidCallback onChangePressed;

  @override
  Widget build(BuildContext context) {
    return AppDashedBox(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.w16,
        vertical: AppDimensions.h18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.imagePreview,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppDimensions.h12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.r14),
              border: Border.all(
                color: AppColors.borderLight,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.r14),
              child: AspectRatio(
                aspectRatio: 281 / 170,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AppAssets.cameraBg,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.w20,
                        vertical: AppDimensions.h12,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.r10),
                          border: Border.all(
                            color: AppColors.textPrimary
                                .withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.r10),
                          child: Image.asset(
                            document.assetPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.h16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton(
                text: AppStrings.remove,
                onPressed: onRemovePressed,
                variant: AppButtonVariant.text,
                isFullWidth: false,
                textColor: AppColors.primary,
                height: AppDimensions.h36,
              ),
              AppButton(
                text: AppStrings.change,
                onPressed: onChangePressed,
                variant: AppButtonVariant.outline,
                isFullWidth: false,
                width: AppDimensions.w100,
                height: AppDimensions.h36,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
