import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/widgets/app_button.dart';
import '../state/kyc_cubit.dart';
import '../state/kyc_state.dart';

class KycIntroBottomAction extends StatelessWidget {
  const KycIntroBottomAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KycCubit, KycState>(
      buildWhen: (previous, current) =>
          previous.termsAccepted != current.termsAccepted,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.w20,
            AppDimensions.h12,
            AppDimensions.w20,
            AppDimensions.h20,
          ),
          decoration: const BoxDecoration(
            color: AppColors.transparent,
          ),
          child: AppButton(
            text: AppStrings.agreeAndContinue,
            onPressed: state.termsAccepted
                ? () => context.push(RouteNames.panUpload)
                : null,
          ),
        );
      },
    );
  }
}
