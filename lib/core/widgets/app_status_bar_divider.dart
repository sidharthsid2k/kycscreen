import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppStatusBarDivider extends StatelessWidget {
  const AppStatusBarDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: AppColors.statusBarDivider,
    );
  }
}
