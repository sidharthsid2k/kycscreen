import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.margin,
    this.boxShadow,
    this.width,
    this.height,
    this.clipBehavior,
  });

  final Widget child;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? AppDimensions.r16;

    return Container(
      width: width,
      height: height,
      margin: margin,
      clipBehavior: clipBehavior ?? Clip.none,
      padding: padding ?? EdgeInsets.all(AppDimensions.w16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(radius),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1.0,
              )
            : null,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
