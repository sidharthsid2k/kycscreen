import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/document_upload_model.dart';

class PanVerificationSteps extends StatelessWidget {
  const PanVerificationSteps({
    super.key,
    required this.status,
  });

  final DocumentStatus status;

  static const List<String> _steps = [
    AppStrings.stepUploading,
    AppStrings.stepExtracting,
    AppStrings.stepVerifying,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_steps.length, (index) {
        final bool isLast = index == _steps.length - 1;
        final bool isDone = _isStepDone(index, status);
        final bool isInProgress = _isStepInProgress(index, status);

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppDimensions.w24,
                child: Column(
                  children: [
                    Container(
                      width: AppDimensions.w20,
                      height: AppDimensions.h20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? AppColors.success
                            : (isInProgress
                                ? AppColors.primary
                                : AppColors.backgroundWhite),
                        border: Border.all(
                          color: isDone
                              ? AppColors.success
                              : (isInProgress
                                  ? AppColors.primary
                                  : AppColors.textMuted),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: isDone
                          ? Icon(
                              Icons.check,
                              size: AppDimensions.iconXs,
                              color: AppColors.backgroundWhite,
                            )
                          : (isInProgress
                              ? SizedBox(
                                  width: AppDimensions.w10,
                                  height: AppDimensions.h10,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.backgroundWhite,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.check,
                                  size: AppDimensions.iconXs,
                                  color: AppColors.textMuted,
                                )),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          color: isDone ? AppColors.success : AppColors.textMuted,
                          margin: EdgeInsets.symmetric(
                            vertical: AppDimensions.h4,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: AppDimensions.w12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : AppDimensions.h16,
                  ),
                  child: Text(
                    _steps[index],
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDone || isInProgress
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontWeight:
                          isInProgress ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  bool _isStepDone(int stepIndex, DocumentStatus status) {
    if (status == DocumentStatus.verified) return true;
    if (status == DocumentStatus.verifying && stepIndex < 2) return true;
    if (status == DocumentStatus.extracting && stepIndex < 1) return true;
    return false;
  }

  bool _isStepInProgress(int stepIndex, DocumentStatus status) {
    if (status == DocumentStatus.uploading && stepIndex == 0) return true;
    if (status == DocumentStatus.extracting && stepIndex == 1) return true;
    if (status == DocumentStatus.verifying && stepIndex == 2) return true;
    return false;
  }
}
