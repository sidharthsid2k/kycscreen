
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height,
    this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.padding,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final double? height;
  final double? width;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? AppDimensions.h52;
    final double radius = borderRadius ?? AppDimensions.r8;

    final Widget content = isLoading
        ? SizedBox(
            height: AppDimensions.h20,
            width: AppDimensions.w20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == AppButtonVariant.primary
                    ? AppColors.backgroundWhite
                    : AppColors.primary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: AppDimensions.w8),
              ],
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (textStyle ??
                          (variant == AppButtonVariant.primary
                              ? AppTextStyles.buttonLarge
                              : AppTextStyles.buttonMedium.copyWith(
                                  color: textColor ?? AppColors.primary,
                                )))
                      .copyWith(
                    color: textColor ??
                        (textStyle?.color ??
                            (variant == AppButtonVariant.primary
                                ? AppColors.backgroundWhite
                                : AppColors.primary)),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                SizedBox(width: AppDimensions.w8),
                suffixIcon!,
              ],
            ],
          );

    Widget button;

    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primary,
            disabledBackgroundColor: AppColors.borderLight,
            elevation: 0,
            shadowColor: AppColors.transparent,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: AppDimensions.w16,
                  vertical: height != null ? 0 : AppDimensions.h12,
                ),
          ),
          child: content,
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: backgroundColor ?? AppColors.primary,
              width: 1.5,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: AppDimensions.w16,
                  vertical: height != null ? 0 : AppDimensions.h12,
                ),
          ),
          child: content,
        );
        break;
      case AppButtonVariant.secondary:
      case AppButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: AppDimensions.w16,
                  vertical: height != null ? 0 : AppDimensions.h12,
                ),
          ),
          child: content,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: buttonHeight,
        child: button,
      );
    }

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: buttonHeight,
        child: button,
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: buttonHeight),
      child: button,
    );
  }
}
