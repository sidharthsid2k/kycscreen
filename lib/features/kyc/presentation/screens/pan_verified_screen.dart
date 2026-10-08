import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_status_bar_divider.dart';
import '../widgets/aadhaar_otp_bottom_sheet.dart';
import '../widgets/pan_verified_main_card.dart';

class PanVerifiedScreen extends StatefulWidget {
  const PanVerifiedScreen({super.key});

  @override
  State<PanVerifiedScreen> createState() => _PanVerifiedScreenState();
}

class _PanVerifiedScreenState extends State<PanVerifiedScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onVerifyAadhaar(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      AadhaarOtpBottomSheet.show(
        context,
        onConfirmed: () {
          context.push(RouteNames.enterGstin);
        },
      );
    }
  }

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
                  child: PanVerifiedMainCard(
                    onDifferentPanTap: () => Navigator.of(context).maybePop(),
                    formKey: _formKey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.w16,
                  AppDimensions.h12,
                  AppDimensions.w16,
                  AppDimensions.h20,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.transparent,
                ),
                child: AppButton(
                  text: AppStrings.verifyAadhaar,
                  onPressed: () => _onVerifyAadhaar(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
