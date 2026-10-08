import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class AppDropdownField extends FormField<String> {
  AppDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    this.value,
    required this.onTap,
    super.validator,
    this.errorText,
  }) : super(
          initialValue: value,
          builder: (FormFieldState<String> fieldState) {
            final effectiveError = errorText ?? fieldState.errorText;
            final hasError =
                effectiveError != null && effectiveError.isNotEmpty;
            final displayValue = value ?? fieldState.value;
            final hasValue =
                displayValue != null && displayValue.trim().isNotEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: AppDimensions.h6),
                GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.w12,
                      vertical: AppDimensions.h12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.fieldFill,
                      border: Border(
                        bottom: BorderSide(
                          color: hasError
                              ? AppColors.error
                              : AppColors.fieldUnderline,
                          width: hasError ? 1.5 : 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            hasValue ? displayValue : hintText,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: hasValue
                                  ? AppColors.textPrimary
                                  : AppColors.textDisabled,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textSecondary,
                          size: AppDimensions.iconMd,
                        ),
                      ],
                    ),
                  ),
                ),
                if (hasError)
                  Padding(
                    padding: EdgeInsets.only(top: AppDimensions.h4),
                    child: Text(
                      effectiveError,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
              ],
            );
          },
        );

  final String label;
  final String hintText;
  final String? value;
  final VoidCallback onTap;
  final String? errorText;

  @override
  FormFieldState<String> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends FormFieldState<String> {
  @override
  AppDropdownField get widget => super.widget as AppDropdownField;

  @override
  void didUpdateWidget(AppDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setValue(widget.value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && hasError) {
          validate();
        }
      });
    }
  }
}
