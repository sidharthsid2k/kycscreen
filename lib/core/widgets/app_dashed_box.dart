import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class AppDashedBox extends StatelessWidget {
  const AppDashedBox({
    super.key,
    required this.child,
    this.color = AppColors.borderDashed,
    this.strokeWidth = 1.2,
    this.dashLength = 6.0,
    this.dashSpace = 4.0,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.width,
    this.height,
  });

  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final double? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final double radius = borderRadius ?? AppDimensions.r16;

    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        dashSpace: dashSpace,
        radius: radius,
      ),
      child: Container(
        width: width,
        height: height,
        padding: padding ?? EdgeInsets.all(AppDimensions.w16),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surfaceCard.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpace,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = _buildDashPath(path, dashLength, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _buildDashPath(Path source, double length, double space) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double currentLength =
            (distance + length > metric.length) ? (metric.length - distance) : length;
        dest.addPath(
          metric.extractPath(distance, distance + currentLength),
          Offset.zero,
        );
        distance += length + space;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.radius != radius;
  }
}
