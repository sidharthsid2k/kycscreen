import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class AppStepIndicator extends StatelessWidget {
  const AppStepIndicator({
    super.key,
    this.currentStep = 0,
    this.completionPercentage = '0% Completed',
  });

  final int currentStep;
  final String completionPercentage;

  static const List<IconData> _stepIcons = [
    Icons.person_outline,
    Icons.language_outlined,
    Icons.groups_outlined,
    Icons.account_balance_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: AppDimensions.h40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: AppDimensions.w24,
                right: AppDimensions.w24,
                child: Row(
                  children: List.generate(_stepIcons.length - 1, (index) {
                    final bool isPassed = index < currentStep;
                    return Expanded(
                      child: Container(
                        height: AppDimensions.h2,
                        color:
                            isPassed ? AppColors.primary : AppColors.stepLine,
                      ),
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_stepIcons.length, (index) {
                  final bool isCurrent = index == currentStep;
                  final bool isDone = index < currentStep;

                  Color circleColor;
                  Color iconColor;
                  Border? border;

                  if (isCurrent) {
                    circleColor = AppColors.accentMagenta;
                    iconColor = AppColors.backgroundWhite;
                  } else if (isDone) {
                    circleColor = AppColors.primary;
                    iconColor = AppColors.backgroundWhite;
                  } else {
                    circleColor = AppColors.backgroundWhite;
                    iconColor = AppColors.stepInactive;
                    border = Border.all(
                      color: AppColors.stepLine,
                      width: 1.5,
                    );
                  }

                  return Container(
                    width: AppDimensions.w36,
                    height: AppDimensions.h36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleColor,
                      border: border,
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: AppColors.accentMagenta
                                    .withValues(alpha: 0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      _stepIcons[index],
                      size: AppDimensions.iconSm,
                      color: iconColor,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.h6),
        Center(
          child: Text(
            completionPercentage,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.accentMagenta,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
