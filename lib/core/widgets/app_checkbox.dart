import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.activeColor,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? label;
  final bool enabled;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = activeColor ?? AppColors.primary;
    final Widget box = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: AppDimensions.w20,
      height: AppDimensions.h20,
      decoration: BoxDecoration(
        color: value ? effectiveColor : AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(AppDimensions.r4),
        border: Border.all(
          color: value ? effectiveColor : AppColors.borderMedium,
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: value
          ? Icon(
              Icons.check,
              size: AppDimensions.iconXs,
              color: AppColors.backgroundWhite,
            )
          : null,
    );

    if (label == null) {
      return GestureDetector(
        onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
        behavior: HitTestBehavior.opaque,
        child: box,
      );
    }

    return InkWell(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(AppDimensions.r8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppDimensions.h2),
            child: box,
          ),
          SizedBox(width: AppDimensions.w12),
          Expanded(child: label!),
        ],
      ),
    );
  }
}
