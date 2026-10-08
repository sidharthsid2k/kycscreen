import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/app_status_bar_divider.dart';
import '../../data/models/document_upload_model.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';
import '../widgets/pan_bottom_upload_action.dart';
import '../widgets/pan_security_badges.dart';
import '../widgets/pan_upload_main_card.dart';

class PanUploadScreen extends StatelessWidget {
  const PanUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycCubit, KycState>(
      listenWhen: (prev, curr) =>
          prev.documentStatus != curr.documentStatus &&
          curr.documentStatus == DocumentStatus.verified,
      listener: (context, state) => context.push(RouteNames.panVerified),
      child: Scaffold(
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PanUploadMainCard(),
                        PanSecurityBadges(),
                      ],
                    ),
                  ),
                ),
                const PanBottomUploadAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
