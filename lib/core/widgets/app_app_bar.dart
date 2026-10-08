import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';
import 'app_status_bar_divider.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.onBackPressed,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor = AppColors.transparent,
    this.elevation = 0,
  });

  final String? title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;

  @override
  Size get preferredSize => Size.fromHeight(AppDimensions.h56 + 1.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppStatusBarDivider(),
        AppBar(
          backgroundColor: backgroundColor,
          elevation: elevation,
          surfaceTintColor: AppColors.transparent,
          leading: showBackButton
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                    size: AppDimensions.iconLg,
                  ),
                  onPressed:
                      onBackPressed ?? () => Navigator.of(context).maybePop(),
                )
              : null,
          title: title != null
              ? Text(
                  title!,
                  style: AppTextStyles.h3,
                )
              : null,
          centerTitle: false,
          actions: actions,
        ),
      ],
    );
  }
}
