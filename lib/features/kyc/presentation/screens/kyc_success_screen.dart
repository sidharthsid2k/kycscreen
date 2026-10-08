import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/widgets/app_status_bar_divider.dart';
import '../widgets/kyc_success_main_card.dart';

class KycSuccessScreen extends StatelessWidget {
  const KycSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBasePink,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(1.1, -1.0),
            radius: 1.3,
            colors: [
              AppColors.bgGradientPink,
              AppColors.bgGradientPinkMid,
              AppColors.bgBasePink,
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const AppStatusBarDivider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.w16,
                  vertical: AppDimensions.h8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.textPrimary,
                      size: AppDimensions.iconLg,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.w16,
                    0,
                    AppDimensions.w16,
                    AppDimensions.h24,
                  ),
                  child: const KycSuccessMainCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
