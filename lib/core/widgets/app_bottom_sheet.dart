import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showCloseButton = true,
    this.showDragHandle = true,
    this.bottomAction,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showCloseButton;
  final bool showDragHandle;
  final Widget? bottomAction;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? subtitle,
    bool showCloseButton = true,
    bool showDragHandle = true,
    Widget? bottomAction,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: AppColors.transparent,
      builder: (ctx) => AppBottomSheet(
        title: title,
        subtitle: subtitle,
        showCloseButton: showCloseButton,
        showDragHandle: showDragHandle,
        bottomAction: bottomAction,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.r24),
          topRight: Radius.circular(AppDimensions.r24),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showDragHandle) ...[
              SizedBox(height: AppDimensions.h8),
              Center(
                child: Container(
                  width: AppDimensions.w40,
                  height: AppDimensions.h4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(AppDimensions.r4),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.h8),
            ],
            if (title != null || showCloseButton) ...[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.w20,
                  AppDimensions.h12,
                  AppDimensions.w16,
                  AppDimensions.h8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: AppTextStyles.h3,
                            ),
                          if (subtitle != null) ...[
                            SizedBox(height: AppDimensions.h4),
                            Text(
                              subtitle!,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (showCloseButton)
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        iconSize: AppDimensions.iconMd,
                        color: AppColors.textPrimary,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
              ),
              const Divider(color: AppColors.borderLight),
            ],
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.w20),
                child: child,
              ),
            ),
            if (bottomAction != null) ...[
              const Divider(color: AppColors.borderLight),
              Padding(
                padding: EdgeInsets.all(AppDimensions.w16),
                child: bottomAction!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
