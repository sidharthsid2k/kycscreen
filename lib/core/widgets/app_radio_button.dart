import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.enabled = true,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final String? title;
  final String? subtitle;
  final bool enabled;

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final Widget radioCircle = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: AppDimensions.w20,
      height: AppDimensions.h20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: !enabled
              ? AppColors.borderLight
              : isSelected
                  ? AppColors.primary
                  : AppColors.borderMedium,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Container(
              width: AppDimensions.w10,
              height: AppDimensions.h10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: enabled ? AppColors.primary : AppColors.textDisabled,
              ),
            )
          : null,
    );

    if (title == null && subtitle == null) {
      return GestureDetector(
        onTap: enabled && onChanged != null ? () => onChanged!(value) : null,
        behavior: HitTestBehavior.opaque,
        child: radioCircle,
      );
    }

    return InkWell(
      onTap: enabled && onChanged != null ? () => onChanged!(value) : null,
      borderRadius: BorderRadius.circular(AppDimensions.r8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.h8,
          horizontal: AppDimensions.w4,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            radioCircle,
            SizedBox(width: AppDimensions.w12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: enabled
                            ? AppColors.textPrimary
                            : AppColors.textDisabled,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppDimensions.h2),
                    Text(
                      subtitle!,
                      style: AppTextStyles.caption.copyWith(
                        color: enabled
                            ? AppColors.textSecondary
                            : AppColors.textDisabled,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
